""" XVM (c) www.modxvm.com 2013-2016 """

#####################################################################
# constants

# Shared commands 

class XVM_BATTLE_COMMAND(object):
    REQUEST_BATTLE_GLOBAL_DATA = "xvm_battle.request_battle_global_data"
    BATTLE_CTRL_SET_VEHICLE_DATA = "xvm_battle.battle_ctrl_set_vehicle_data"
    CAPTURE_BAR_GET_BASE_NUM_TEXT = "xvm_battle.capture_bar_get_base_num_text"
    MINIMAP_CLICK = "xvm_battle.minimap_click"

    AS_RESPONSE_BATTLE_GLOBAL_DATA = "xvm.as.response_battle_global_data"
    AS_UPDATE_PLAYER_STATE = "xvm.as.update_player_state"
    AS_UPDATE_DEVICE_STATE = "xvm.as.update_device_state"
    AS_TEAMS_HP_CHANGED = "xvm.as.teams_hp_changed"
    AS_SNIPER_CAMERA = "xvm.as.sniper_camera"
    AS_AIM_OFFSET_UPDATE = "xvm.as.aim_offset_update"

# Markers only commands

class XVM_VM_COMMAND(object):
    # Flash -> Python
    LOG = "xfw.log"
    INITIALIZED = "initialized"

# Invalidation targets

class INV(object):
    NONE                = 0x00000000
    VEHICLE_STATUS      = 0x00000001 # ready, alive, not_available, stop_respawn
    #PLAYER_STATUS       = 0x00000002 # isActionDisabled, isSelected, isSquadMan, isSquadPersonal, isTeamKiller, isVoipDisabled
    SQUAD_INDEX         = 0x00000008
    CUR_HEALTH          = 0x00000010
    MAX_HEALTH          = 0x00000020
    MARKS_ON_GUN        = 0x00000040
    SPOTTED_STATUS      = 0x00000080
    FRAGS               = 0x00000100
    HITLOG              = 0x00010000
    ALL_VINFO           = VEHICLE_STATUS | SQUAD_INDEX | FRAGS # | PLAYER_STATUS
    ALL_VSTATS          = FRAGS
    ALL_ENTITY          = CUR_HEALTH | MAX_HEALTH | MARKS_ON_GUN
    ALL                 = 0x0000FFFF

# Spotted statuses

class SPOTTED_STATUS(object):
    NEVER_SEEN = 'neverSeen'
    SPOTTED = 'spotted'
    LOST = 'lost'
    DEAD = 'dead'
