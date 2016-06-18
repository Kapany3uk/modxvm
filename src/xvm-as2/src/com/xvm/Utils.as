﻿/**
 * ...
 * @author sirmax2
 */
import com.xvm.*;
import flash.filters.*;

class com.xvm.Utils
{
    private static var TRACE_XVM_MODULES = true;

// AS3:DONE     public static function toInt(value:Object, defaultValue:Number):Number
// AS3:DONE     {
// AS3:DONE         if (!defaultValue)
// AS3:DONE             defaultValue = NaN;
// AS3:DONE         if (!value)
// AS3:DONE             return defaultValue;
// AS3:DONE         var n:Number = parseInt(value.toString());
// AS3:DONE         return isNaN(n) ? defaultValue : n;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     public static function toFloat(value:Object, defaultValue:Number):Number
// AS3:DONE     {
// AS3:DONE         if (!defaultValue)
// AS3:DONE             defaultValue = NaN;
// AS3:DONE         if (!value)
// AS3:DONE             return defaultValue;
// AS3:DONE         var n:Number = parseFloat(value.toString());
// AS3:DONE         return isNaN(n) ? defaultValue : n;
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     public static function toBool(value:Object, defaultValue:Boolean):Boolean
// AS3:DONE     {
// AS3:DONE         if ((typeof value) == "boolean")
// AS3:DONE             return Boolean(value);
// AS3:DONE         if (!value)
// AS3:DONE             return defaultValue;
// AS3:DONE         value = String(value).toLowerCase();
// AS3:DONE         return defaultValue ? value != "false" : value == "true";
// AS3:DONE     }
// AS3:DONE 
// AS3:DONE     private static var _lastArenaGuiType:Number = -1;
// AS3:DONE     private static var _isArenaGuiTypeWithPlayerPanels:Boolean;
// AS3:DONE     public static function isArenaGuiTypeWithPlayerPanels():Boolean
// AS3:DONE     {
// AS3:DONE         if (_lastArenaGuiType != Config.arenaGuiType)
// AS3:DONE         {
// AS3:DONE             _lastArenaGuiType = Config.arenaGuiType;
// AS3:DONE             _isArenaGuiTypeWithPlayerPanels = true;
// AS3:DONE             var len:Number = Defines.ARENA_GUI_TYPE_NO_PLAYER_PANELS.length;
// AS3:DONE             for (var i:Number = 0; i < len; ++i)
// AS3:DONE             {
// AS3:DONE                 if (Defines.ARENA_GUI_TYPE_NO_PLAYER_PANELS[i] == Config.arenaGuiType)
// AS3:DONE                 {
// AS3:DONE                     _isArenaGuiTypeWithPlayerPanels = false;
// AS3:DONE                     break;
// AS3:DONE                 }
// AS3:DONE             }
// AS3:DONE         }
// AS3:DONE         return _isArenaGuiTypeWithPlayerPanels;
// AS3:DONE     }

    ////////////////////

    public static function vehicleClassToVehicleType(vclass:String):String
    {
        switch (vclass)
        {
            case "lightTank": return "LT";
            case "mediumTank": return "MT";
            case "heavyTank": return "HT";
            case "SPG": return "SPG";
            case "AT-SPG": return "TD";
            default: return vclass;
        }
    }

    public static function getMarksOnGunText(value:Number):String
    {
        if (value == null || !Config.config.texts.marksOnGun["_" + value])
            return null;
        var v:String = Config.config.texts.marksOnGun["_" + value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);
        return v;
    }

// AS3:DONE     public static function getSpottedText(value:String, isArty:Boolean):String
// AS3:DONE     {
// AS3:DONE         if (value == null)
// AS3:DONE             return null;
// AS3:DONE 
// AS3:DONE         if (isArty)
// AS3:DONE             value += "_arty";
// AS3:DONE 
// AS3:DONE         if (!Config.config.texts.spotted[value])
// AS3:DONE             return null;
// AS3:DONE 
// AS3:DONE         var v:String = Config.config.texts.spotted[value];
// AS3:DONE         if (v.indexOf("{{l10n:") >= 0)
// AS3:DONE             v = Locale.get(v);
// AS3:DONE 
// AS3:DONE         return v;
// AS3:DONE     }

    public static function getXvmUserText(status:Number):String
    {
        var value:String = isNaN(status) ? 'none' : (status & 0x01) ? 'on' : 'off';

        if (!Config.config.texts.xvmuser[value])
            return null;

        var v:String = Config.config.texts.xvmuser[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    public static function getBattleTypeText(battleType:Number):String
    {
        var value:String = getBattleTypeStr(battleType);

        if (!Config.config.texts.battletype[value])
            return null;

        var v:String = Config.config.texts.battletype[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    public static function getBattleTypeStr(battleType:Number):String
    {
        switch (battleType)
        {
            case 1: return 'regular';
            case 2: return 'training';
            case 3: return 'company';
            case 4: return 'tournament';
            case 5: return 'clan';
            case 6: return 'tutorial';
            case 7: return 'cybersport';
            case 8: return 'historical';
            case 9: return 'event_battles';
            case 10: return 'sortie';
            case 11: return 'fort_battle';
            case 12: return 'rated_cybersport';
            case 13: return 'global_map';
            case 14: return 'tournament_regular';
            case 15: return 'tournament_clan';
            case 16: return 'rated_sandbox';
            case 17: return 'sandbox';
            case 18: return 'fallout_classic';
            case 19: return 'fallout_multiteam';
            default: return 'unknown';
        }
    }

    public static function getTopClanText(rank:Number):String
    {
        var value:String = isNaN(rank) ? "regular" : rank == 0 ? "persist" :
            rank <= Config.networkServicesSettings.topClansCount ? "top" : "regular";

        if (!Config.config.texts.topclan[value])
            return null;

        var v:String = Config.config.texts.topclan[value];
        if (v.indexOf("{{l10n:") >= 0)
            v = Locale.get(v);

        return v;
    }

    //   src: ally, squadman, enemy, unknown, player (allytk, enemytk - how to detect?)
    public static function damageFlagToDamageSource(damageFlag:Number):String
    {
        switch (damageFlag)
        {
            case Defines.FROM_ALLY:
                return "ally";
            case Defines.FROM_ENEMY:
                return "enemy";
            case Defines.FROM_PLAYER:
                return "player";
            case Defines.FROM_SQUAD:
                return "squadman";
            case Defines.FROM_UNKNOWN:
            default:
                return "unknown";
        }
    }

    ////////////////////

    public static function GetPlayerName(fullplayername:String):String
    {
        var pos = fullplayername.indexOf("[");
        return (pos < 0) ? fullplayername : Strings.trim(fullplayername.slice(0, pos));
    }

    public static function GetClanNameWithoutBrackets(fullplayername:String):String
    {
        var pos:Number = fullplayername.indexOf("[");
        if (pos < 0)
            return null;
        var n:String = fullplayername.slice(pos + 1);
        return n.slice(0, n.indexOf("]"));
    }

    public static function GetClanNameWithBrackets(fullplayername:String):String
    {
        var clan:String = GetClanNameWithoutBrackets(fullplayername);
        return clan ? "[" + clan + "]" : null;
    }

    private static var xvmModules: Array = [];
    public static function TraceXvmModule(moduleName:String):Void
    {
        if (!TRACE_XVM_MODULES)
            return;
        if (_global["_xvm__trace_module_" + moduleName] != undefined)
            return;
        _global["_xvm__trace_module_" + moduleName] = 1;
        xvmModules.push(moduleName);
        Logger.add("xvm -> [\"" + xvmModules.join("\", \"") + "\"]");
    }

    ////////////////////

    /**
     * Get children MovieClips of MovieClip
     * FIXIT: skips TextField?
     */
    public static function getChildrenOf(target:MovieClip, recursive:Boolean):Array
    {
        var result:Array = [];
        for (var i in target)
        {
            if (target[i] instanceof MovieClip)
            {
                result.push(target[i]);

                /** Concatenate children of clips at this level,recurse */
                if (recursive)
                    result = result.concat(getChildrenOf(target[i],true));
            }
        }
        return result;
    }

    public static function removeChildren(mc:MovieClip, match:Function):Void
    {
        var children:Array = getChildrenOf(mc, false);
        var len:Number = children.length;
        for (var i:Number = 0; i < len; ++i)
        {
            var child:MovieClip = MovieClip(children[i]);
            if (child == null)
                continue;
            if (match != null && !match(child))
                continue
            child.removeMovieClip();
        }
    }

    // Duplicate text field
    public static function duplicateTextField(mc:MovieClip, name:String, textField:TextField, yOffset:Number, align:String):TextField
    {
        var res:TextField = mc.createTextField(name, mc.getNextHighestDepth(),
            textField._x, textField._y + yOffset, textField._width, textField._height);
        res.antiAliasType = "advanced";
        res.html = true;
        res.selectable = false;
        res.autoSize = align; // http://theolagendijk.com/2006/09/07/aligning-htmltext-inside-flash-textfield/
        var tf: TextFormat = textField.getNewTextFormat();
        res.styleSheet = Utils.createStyleSheet(Utils.createCSS("xvm_" + name,
            tf.color, tf.font, tf.size, align, tf.bold, tf.italic));

        return res;
    }

    ////////////////////

    /**
     * Create CSS
     */
    public static function createCSS(className:String, color:Number,
        fontName:String, fontSize:Number, align:String, bold:Boolean, italic:Boolean):String
    {
        return "." + className + " {" +
            "color:#" + Strings.padLeft(color.toString(16), 6, '0') + ";" +
            "font-family:\"" + fontName + "\";" +
            "font-size:" + fontSize + ";" +
            "text-align:" + align + ";" +
            "font-weight:" + (bold ? "bold" : "normal") + ";" +
            "font-style:" + (italic ? "italic" : "normal") + ";" +
            "}";
    }

    /**
     * Create Extended CSS
     */
    public static function createCSSExtended(className:String, color:Number, fontName:String,
        fontSize:Number, align:String, bold:Boolean, italic:Boolean, underline:Boolean, display:String, leading:Number,
        marginLeft:Number, marginRight:Number):String
    {
            return "." + className + " {" +
                "color:#" + Strings.padLeft(color.toString(16), 6, '0') + ";" +
                "font-family:\"" + fontName + "\";" +
                "font-size:" + fontSize + ";" +
                "text-align:" + align + ";" +
                "font-weight:" + (bold ? "bold" : "normal") + ";" +
                "font-style:" + (italic ? "italic" : "normal") + ";" +
                "text-decoration:" + (underline ? "underline" : "none") + ";" +
                "display:" + (display ? "display" : "inline") + ";" +
                "leading:" + leading + ";" +
                "margin-left:" + marginLeft + ";" +
                "margin-right:" + marginRight + ";" +
                "}";
    }

    /**
     * Create CSS based on config
     */
    public static function createCSSFromConfig(config_font:Object, color:Number, className:String):String
    {
        return createCSS(className,
            color,
            config_font && config_font.name ? config_font.name : "$FieldFont",
            config_font && config_font.size ? config_font.size : 13,
            config_font && config_font.align ? config_font.align : "center",
            config_font && config_font.bold ? true : false,
            config_font && config_font.italic ? true : false);
    }

    public static function createStyleSheet(css:String):TextField.StyleSheet
    {
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(css);
        return style;
    }

    /** Create DropShadowFilter from config section */
    public static function extractShadowFilter(source:Object):DropShadowFilter
    {
        if (!source || !source.alpha || !source.strength || !source.blur)
            return null;
        return new DropShadowFilter(
            source.distance, // distance
            source.angle, // angle
            parseInt(source.color, 16),
            // DropShadowFilter accepts alpha be from 0 to 1.
            // 90 at default config.
            source.alpha * 0.01,
            source.blur,
            source.blur,
            source.strength);
    }

    /**
     *   (Get relative to screen resolution x or y coordinates for using when applying horizontal or vertical align to object
     */
     public static function HVAlign(align, WidthOrHeight: Number, isValign: Boolean)
        {
        //'align' allows only 'left', 'right', 'center' values for horizontal alignment and 'top', 'bottom', 'middle' or "center" for vertical
            switch (align) {
                case 'left':
                    return 0;
                case 'right' :
                    return Stage.width - WidthOrHeight;
                case 'center':
                    if (!isValign){
                      return (Stage.width/2) - (WidthOrHeight/2);
                    }
                    else {
                      return (Stage.height/2) - (WidthOrHeight/2);
                    }
                case 'top':
                    return 0;
                case 'bottom':
                    return Stage.height - WidthOrHeight;
                case 'middle':
                    return (Stage.height/2) - (WidthOrHeight/2);
            }

        }

    ////////////////////

    // Fix <img src='xvm://...'> to <img src='img://XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
    // Fix <img src='cfg://...'> to <img src='img://XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
    public static function fixImgTag(str:String):String
    {
        str = str.split("xvm://").join("img://" + Defines.XVM_IMG_RES_ROOT);
        str = str.split("cfg://").join("img://" + Defines.XVM_IMG_CFG_ROOT);
        return str;
    }

    // Fix 'img://...' to '../...'> (res_mods/x.x.x/gui/maps/icons)
    // Fix 'xvm://...' to '../../XVM_IMG_RES_ROOT/...'> (res_mods/mods/shared_resources/xvm/res)
    // Fix 'cfg://...' to '../../XVM_IMG_CFG_ROOT/...'> (res_mods/configs/xvm)
    public static function fixImgTagSrc(str:String):String
    {
        if (Strings.startsWith("img://gui/maps/icons/", str.toLowerCase()))
            return "../" + str.slice(10);
        return "../../" + Utils.fixImgTag(str).split("img://").join("");
    }

    public static function indexOf(array:Array, value:Object):Number
    {
        var i:Number = 0;
        var len:Number = array.length;
        while(i < len)
        {
            if (array[i] === value)
                return i;
            ++i;
        }
        return -1;
    }

    public static function getObjectValueByPath(obj, path:String)
    {
        if (obj === undefined)
            return undefined;

        if (path == "." || path == "")
            return obj;

        var p:Array = path.split("."); // "path.to.value"
        var o = obj;
        var p_len:Number = p.length;
        for (var i:Number = 0; i < p_len; ++i)
        {
            var opi = o[p[i]];
            if (opi === undefined)
                return undefined;
            o = opi;
        }
        return o == null ? null : Utils.deepCopy(o);
    }

    /**
     * Deep copy using json stringify+parse.
     */
    public static function jsonClone(obj:Object):Object
    {
        return JSONx.parse(JSONx.stringify(obj, "", true));
    }

    /**
     * Deep copy recursively
     * http://www.senocular.com/flash/actionscript/?file=ActionScript_2.0/deepObjectCopy.as
     */
    public static function deepCopy(obj:Object):Object
    {
        if (typeof obj != "object" || obj instanceof Button || obj instanceof TextField || obj instanceof MovieClip)
            return obj;

        var copy;

        if (obj instanceof Boolean)
            copy = new Boolean(Boolean.prototype.valueOf.call(obj));
        else if (obj instanceof Number)
            copy = new Number(Number.prototype.valueOf.call(obj));
        else if (obj instanceof String)
            copy = new String(String.prototype.valueOf.call(obj));
        else if (obj.__constructor__)
        {
            if (typeof obj.clone == "function") {
                copy = obj.clone();
                if (copy.__proto__ == obj.__proto__)
                    return copy;
            }
            copy = new obj.__constructor__();
        }
        else if (obj instanceof Array)
            copy = [];
        else
            copy = {};

        for (var p in obj)
        {
            if (obj.hasOwnProperty(p))
                copy[p] = arguments.callee(obj[p]);
        }

        return copy;
    }

    public static function parseError(ex):String
    {
        if (ex.at == null)
            return (ex.name != null ? Strings.trim(ex.name) + ": " : "") + Strings.trim(ex.message);

        var head = ex.at > 0 ? ex.text.substring(0, ex.at) : "";
        head = head.split("\r").join("").split("\n").join("");
        while (head.indexOf("  ") != -1)
            head = head.split("  ").join(" ");
        head = head.substr(head.length - 75, 75);

        var tail = (ex.at + 1 < ex.text.length) ? ex.text.substring(ex.at + 1, ex.text.length) : "";
        tail = tail.split("\r").join("").split("\n").join("");
        while (tail.indexOf("  ") != -1)
        tail = tail.split("  ").join(" ");

        return "[" + ex.at + "] " + Strings.trim(ex.name) + ": " + Strings.trim(ex.message) + "\n  " +
            head + ">>>" + ex.text.charAt(ex.at) + "<<<" + tail;
    }

// AS3:DONE     public static function timeStrToSec(str:String):Number
// AS3:DONE     {
// AS3:DONE         var p = str.split(':');
// AS3:DONE         var s = 0;
// AS3:DONE         var m = 1;
// AS3:DONE         while (p.length > 0) {
// AS3:DONE             s += m * parseInt(p.pop(), 10);
// AS3:DONE             m *= 60;
// AS3:DONE         }
// AS3:DONE         return s;
// AS3:DONE     }
}
