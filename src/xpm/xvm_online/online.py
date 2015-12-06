""" XVM (c) www.modxvm.com 2013-2015 """

#############################
# Command

def online():
    _get_online.get_online()

#############################
# imports

import traceback
import threading
import simplejson
from random import randint

import BigWorld
import ResMgr
from gui.shared.utils.HangarSpace import g_hangarSpace

from xfw import *
from xfw.constants import URLS
from xvm_main.python.logger import *
from xvm_main.python.constants import XVM
from xvm_main.python.xvm import l10n_macros_replace
import xvm_main.python.config as config
import xvm_main.python.xvmapi as xvmapi


#############################

class _Get_online(object):

    def __init__(self):
        self.lock = threading.RLock()
        self.thread = None
        self.resp = None
        if GAME_REGION not in URLS.WG_API_SERVERS:
            warn('xvm_online: no API available for this server')
            return
        self.hosts = []
        loginSection = ResMgr.openSection('scripts_config.xml')['login']
        if loginSection is not None:
            for (name, subSec) in loginSection.items():
                host_name = subSec.readStrings('name')[0]
                if len(host_name) >= 13:
                    host_name = subSec.readStrings('short_name')[0]
                elif host_name.find('WOT ') == 0:
                    host_name = host_name[4:]
                self.hosts.append(host_name)


    def get_online(self):
        with self.lock:
            if self.thread is not None:
                return
        self.resp = None
        # create thread
        self.thread = threading.Thread(target=self._getOnlineAsync)
        self.thread.daemon = False
        self.thread.start()
        # timer for result check
        BigWorld.callback(0.05, self._checkResult)

    def _checkResult(self):
        with self.lock:
            # debug("checkResult: " + ("no" if self.resp is None else "yes"))
            if self.resp is None:
                BigWorld.callback(0.05, self._checkResult)
                return
            try:
                self._respond()
            except Exception, ex:
                err('_checkResult() exception: ' + traceback.format_exc())
            finally:
                self.thread = None

    def _respond(self):
        from . import XVM_ONLINE_COMMAND
        as_xfw_cmd(XVM_ONLINE_COMMAND.AS_ONLINEDATA, self.resp)

    # Threaded
    def _getOnlineAsync(self):
        try:
            res = {}
            for host in self.hosts:
                res[host] = l10n_macros_replace(config.get('hangar/onlineServers/errorString', '--k') if g_hangarSpace.inited else config.get('login/onlineServers/errorString', '--k'))

            data = xvmapi.getOnlineUsersCount()
            # typical response:
            #{
            #    "eu":  [{"players_online":4297,"server":"EU2"},{"players_online":8331,"server":"EU1"}],
            #    "na":  [{"players_online":22740,"server":"NA EAST"},{"players_online":7431,"server":"NA WEST"}],
            #    "asia":[{"players_online":6603,"server":"ASIA"}],
            #    "kr":  [{"players_online":868,"server":"KR"}],
            #    "ru":  [{"players_online":14845,"server":"RU8"},{"players_online":8597,"server":"RU2"},{"players_online":9847,"server":"RU1"},{"players_online":3422,"server":"RU3"},{"players_online":11508,"server":"RU6"},{"players_online":6795,"server":"RU5"},{"players_online":3354,"server":"RU4"}]
            #}

            if data is not None:
                region = GAME_REGION.lower()
                if 'CT' in URLS.WG_API_SERVERS and region == 'ct': # CT is uncommented in xfw.constants to check on test server
                    region = 'ru'
                data = data.get(region, [])

            best_online = 0
            if data is not None and type(data) is list:
                for host in data:
                    if host['server'].find('NA ') == 0: # API returns "NA EAST" instead of "US East" => can't determine current server
                        host['server'] = 'US ' + host['server'][3:].capitalize()
                    res[str(host['server'])] = host['players_online']
                    best_online = max(best_online, int(host['players_online']))
            if (g_hangarSpace.inited and config.get('hangar/onlineServers/showTitle')) or (not g_hangarSpace.inited and config.get('login/onlineServers/showTitle')):
                res['###best_online###'] = str(best_online)  # will be first in sorting, key is replaced by localized "Online"
        except Exception, ex:
            err('_getOnlineAsync() exception: ' + traceback.format_exc())
        with self.lock:
            self.resp = res

_get_online = _Get_online()
