/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import com.xvm.types.stat.*;

    internal class LobbyMacros
    {
        internal static function RegisterBattleTypeMacros(battleType:String):void
        {
            // {{battletype-key}}
            Macros.Globals["battletype-key"] = function():String { return battleType; }
        }

        private static var _requestSent:Boolean = false;
        internal static function RegisterMyStatMacros():void
        {
            Macros.Globals["mystat"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null)
                {
                    return null;
                }
                switch (o.getSubname())
                {
                    case "player_id":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_ID);
                    case "name":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_NAME);
                    case "clan":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_CLAN_NAME);
                    case "clan_id":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_CLAN_ID);
                    case "battles":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'battles');
                    case "wins":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'wins');
                    case "winrate":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'winrate');
                    case "def":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'defence');
                    case "frg":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'frags');
                    case "dmg":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'damageDealt');
                    case "cap":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'capture');
                    case "hip":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'hitPercent');
                    case "spo":
                        return Xfw.cmd(XvmCommands.GET_PLAYER_DOSSIER_VALUE, 'spotted');
                }

                var playerName:String = Xfw.cmd(XvmCommands.GET_PLAYER_NAME);
                var stat:StatData = Stat.getUserDataByName(playerName);
                //Logger.addObject(stat, 3);
                if (!stat)
                {
                    Stat.loadUserData(playerName);
                    return null;
                }

                switch (o.getSubname())
                {
                    case "c_winrate":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, stat.winrate, "#");
                    case "c_eff":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_EFF, stat.eff, "#");
                    case "c_wgr":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WGR, stat.wgr, "#");
                    case "c_wtr":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WTR, stat.wtr, "#");
                    case "c_wn8":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WN8, stat.wn8, "#");
                    case "c_xeff":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xeff, "#");
                    case "c_xwgr":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwgr, "#");
                    case "c_xwtr":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwtr, "#");
                    case "c_xwn8":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, stat.xwn8, "#");
                    case "c_avglvl":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_AVGLVL, stat.avglvl, "#");
                    case "c_battles":
                        return MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_KB, stat.battles / 1000.0, "#");
                    case "a_winrate":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WINRATE, stat.winrate);
                    case "a_eff":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_EFF, stat.eff);
                    case "a_wgr":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WGR, stat.wgr);
                    case "a_wtr":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WTR, stat.wtr);
                    case "a_wn8":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_WN8, stat.wn8);
                    case "a_xeff":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xeff);
                    case "a_xwgr":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwgr);
                    case "a_xwtr":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwtr);
                    case "a_xwn8":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_X, stat.xwn8);
                    case "a_avglvl":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_AVGLVL, stat.avglvl);
                    case "a_battles":
                        return MacrosUtils.getDynamicAlphaValue(Defines.DYNAMIC_ALPHA_KB, stat.battles / 1000);
                }

                return stat[o.getSubname()];
            }
        }

        internal static function RegisterVehiclesMacros():void
        {
            Macros.Globals["v"] = function(o:IVOMacrosOptions):* {
                if (o == null || o.getSubname() == null || o.vehicleData == null)
                {
                    return null;
                }
                return o.vehicleData.__vehicleDossierCut[o.getSubname()]; // TODO: refactor, remove VehicleDossierCut class
            }
        }
    }
}
