""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# imports

import traceback

import BigWorld, GUI
import game
from Avatar import PlayerAvatar
from gui import g_guiResetters
from gui.shared import g_eventBus
import gui.Scaleform.daapi.view.battle.score_panel as score_panel
from gui.battle_control import g_sessionProvider

from xfw import *

from xvm_main.python.constants import *
from xvm_main.python.logger import *
from xvm_main.python.xvm import Xvm as xvm_class
from xvm_main.python import config
from xvm_main.python import vehstate

#####################################################################
# initialization/finalization

def start():
    g_eventBus.addListener(XVM_EVENT.RELOAD_CONFIG, update_conf_hp)
    update_conf_hp()

BigWorld.callback(0, start)

@registerEvent(game, 'fini')
def fini():
    g_eventBus.removeListener(XVM_EVENT.RELOAD_CONFIG, update_conf_hp)

#####################################################################
# globals
teams_vehicles = [{}, {}]
teams_totalhp = [0, 0]
hp_color = 'FFFFFF'

#####################################################################
# handlers

# show quantity of alive instead of dead in frags panel
# original idea/code by yaotzinv: http://forum.worldoftanks.ru/index.php?/topic/1339762-
@overrideMethod(score_panel._FragCorrelationPanel, 'updateScore')
def FragCorrelationPanel_updateScore(base, self):
    try:
        if config.get('fragCorrelation/showAliveNotFrags'):
            if len(self._FragCorrelationPanel__teamsDeaths) and len(self._FragCorrelationPanel__teamsShortLists):
                isTeamEnemy = g_sessionProvider.getArenaDP().isEnemyTeam
                ally_frags, enemy_frags, ally_vehicles, enemy_vehicles  = (0, 0, 0, 0)
                for teamIdx, vehs in self._FragCorrelationPanel__teamsShortLists.iteritems():
                    if isTeamEnemy(teamIdx):
                        enemy_vehicles += len(vehs)
                    else:
                        ally_vehicles += len(vehs)
                for teamIdx, score in self._FragCorrelationPanel__teamsDeaths.iteritems():
                    if isTeamEnemy(teamIdx):
                        ally_frags += score
                    else:
                        enemy_frags += score
            team_left = ally_vehicles - enemy_frags
            enemy_left = enemy_vehicles - ally_frags
            self._FragCorrelationPanel__callFlash('updateFrags', [team_left, enemy_left])
            return
    except Exception, ex:
        err(traceback.format_exc())
    base(self)


@registerEvent(score_panel._FragCorrelationPanel, 'populate')
def populate_hp(*args, **kwargs):
    try:
        if not config.get('totalHP/enabled'):
            return
        GUI.addRoot(hp_panel)
        hp_panel.visible = True
        g_guiResetters.add(update_conf_hp)
    except Exception, ex:
        err(traceback.format_exc())

@registerEvent(score_panel._FragCorrelationPanel, 'destroy')
def destroy_hp(*args, **kwargs):
    try:
        if not config.get('totalHP/enabled'):
            return
        g_guiResetters.discard(update_conf_hp)
        hp_panel.visible = False
        GUI.delRoot(hp_panel)
        teams_vehicles = [{}, {}]
        teams_totalhp = [0, 0]
    except Exception, ex:
        err(traceback.format_exc())

@registerEvent(PlayerAvatar, '_PlayerAvatar__setVisibleGUI')
def visibility_hp_panel(self, is_gui_visible):
    try:
        if not config.get('totalHP/enabled'):
            return
        hp_panel.visible = is_gui_visible
    except Exception, ex:
        err(traceback.format_exc())

def update_conf_hp(*args, **kwargs):
    try:
        if not config.get('totalHP/enabled'):
            return
        global hp_color
        hp_color      = config.get('totalHP/color', 'FFFFFF')
        hp_panel.font = config.get('totalHP/font', 'default_small.font')
        vAlign        = config.get('totalHP/vAlign', 'top')
        hAlign        = config.get('totalHP/hAlign', 'center')
        x             = config.get('totalHP/x', 0)
        y             = config.get('totalHP/y', 36)
        res_x, res_y  = GUI.screenResolution()

        if hp_color[0] == '#':
            hp_color = hp_color[1:]

        if vAlign == 'center':
            hp_panel.verticalAnchor = 'CENTER'
            y += res_y / 2
        elif vAlign == 'bottom':
            hp_panel.verticalAnchor = 'BOTTOM'
            y += res_y
        else:
            hp_panel.verticalAnchor = 'TOP'

        if hAlign == 'center':
            hp_panel.horizontalAnchor = 'CENTER'
            x += res_x / 2
        elif hAlign == 'right':
            hp_panel.horizontalAnchor = 'RIGHT'
            x += res_x
        else:
            hp_panel.horizontalAnchor = 'LEFT'
            
        hp_panel.position = (x, y, 1)
    except Exception, ex:
        err(traceback.format_exc())

@registerEvent(xvm_class, 'doUpdateBattle')
def update_hp(self, vID, *args, **kwargs):
    try:
        if not config.get('totalHP/enabled'):
            return
        state = vehstate.getVehicleStateData(vID)
        if state is None:
            return
        team = state['team'] - 1
        if state['dead']:
            hp = 0
        elif state['curHealth'] is not None:
            hp = state['curHealth']
        else:
            veh_descr = BigWorld.player().arena.vehicles.get(vID, {}).get('vehicleType')
            if not veh_descr:
                return
            hp = veh_descr.maxHealth

        teams_vehicles[team][vID] = hp
        teams_totalhp[team] = sum(teams_vehicles[team].values())
    
        if teams_totalhp[0] < teams_totalhp[1]:
            sign = '<'
        elif teams_totalhp[0] > teams_totalhp[1]:
            sign = '>'
        else:
            sign = '='
        hp_panel.text = '\c%sFF;%s %s %s' % (hp_color, teams_totalhp[0], sign, teams_totalhp[1])
    except Exception, ex:
        err(traceback.format_exc())

hp_panel = GUI.Text('')
hp_panel.colourFormatting = True
hp_panel.horizontalPositionMode = 'PIXEL'
hp_panel.verticalPositionMode = 'PIXEL'
hp_panel.text = ''
