""" XVM (c) www.modxvm.com 2013-2015 """

#####################################################################
# MOD INFO (mandatory)

XFW_MOD_VERSION    = "2.0.0"
XFW_MOD_URL        = "http://www.modxvm.com/"
XFW_MOD_UPDATE_URL = "http://www.modxvm.com/en/download-xvm/"
XFW_GAME_VERSIONS  = ["0.9.6","0.9.7"]

#####################################################################
# constants

XFW_COMMAND_PING = "xfw.ping"
XFW_AS_COMMAND_PINGDATA = "xfw.pingdata"

#####################################################################
# includes

import traceback

import BigWorld

import simplejson
from xfw import *
from xvm_main.python.logger import *

import pinger
# import pinger_wg as pinger

#####################################################################
# event handlers

# INIT

def start():
    from gui.shared import g_eventBus
    g_eventBus.addListener(XFW_CMD, onXfwCommand)

def fini():
    from gui.shared import g_eventBus
    g_eventBus.removeListener(XFW_CMD, onXfwCommand)

# onXfwCommand

_LOG_COMMANDS = (
    #XFW_COMMAND_PING,
)

# returns: (result, status)
def onXfwCommand(cmd, *args):
    try:
        if IS_DEVELOPMENT and cmd in _LOG_COMMANDS:
            debug("cmd=" + str(cmd) + " args=" + simplejson.dumps(args))
        if cmd == XFW_COMMAND_PING:
            pinger.ping()
            return (None, True)
    except Exception, ex:
        err(traceback.format_exc())
        return (None, True)
    return (None, False)


# WGPinger (WARNING: bugs with the multiple hosts)

def PreDefinedHostList_autoLoginQuery(base, callback):
    # debug('> PreDefinedHostList_autoLoginQuery')
    import pinger_wg
    if pinger_wg.request_sent:
        BigWorld.callback(0, lambda: PreDefinedHostList_autoLoginQuery(base, callback))
    else:
        # debug('login ping: start')
        pinger_wg.request_sent = True
        BigWorld.WGPinger.setOnPingCallback(PreDefinedHostList_onPingPerformed)
        base(callback)

def PreDefinedHostList_onPingPerformed(result):
    # debug('login ping: end')
    pinger_wg.request_sent = False
    from predefined_hosts import g_preDefinedHosts
    g_preDefinedHosts._PreDefinedHostList__onPingPerformed(result)

# Delayed registration
def _RegisterEvents():
    start()

    import game
    RegisterEvent(game, 'fini', fini)

    # enable for pinger_wg
    # from predefined_hosts import g_preDefinedHosts
    # OverrideMethod(g_preDefinedHosts, 'autoLoginQuery', PreDefinedHostList_autoLoginQuery)

BigWorld.callback(0, _RegisterEvents)
