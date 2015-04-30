""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "3.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.7"]

#####################################################################

import traceback

import BigWorld
from gui.shared.SoundEffectsId import SoundEffectsId
from gui.shared.utils.sound import Sound

from xfw import *

import xvm_main.python.config as config
from xvm_main.python.logger import *

#####################################################################
# event handlers

def Battle_showSixthSenseIndicator(self, isShow):
    try:
        vehId = BigWorld.entities[BigWorld.player().playerVehicleID].typeDescriptor.type.compactDescr
        if vehId == 59393: # Rudy
            Sound('/rudy/dog/dog').play()
        else:
            soundId = config.config['sounds']['sixthSense']
            if soundId is not None and soundId != '':
                Sound(soundId).play()
    except:
        err(traceback.format_exc())

def _test():
    log('test')
    if config.config is not None:
        soundId = config.config['sounds']['sixthSense']
        if soundId is not None and soundId != '':
            Sound(soundId).play()
    BigWorld.callback(1, _test)

#####################################################################
# Register events

def _RegisterEvents():
    #import FMOD
    #FMOD.loadEventProject('../mods/shared_resources/xvm/res/audio/xvm')
    #loadSuccessfully = FMOD.loadSoundBankIntoMemoryFromPath('../mods/shared_resources/xvm/res/audio/xvm.fsb')
    #log('ok: {}'.format(loadSuccessfully))
    #log(FMOD.getSoundBanks())

    from gui.Scaleform.Battle import Battle
    RegisterEvent(Battle, 'showSixthSenseIndicator', Battle_showSixthSenseIndicator)

    #BigWorld.callback(10, _test)

BigWorld.callback(0, _RegisterEvents)
