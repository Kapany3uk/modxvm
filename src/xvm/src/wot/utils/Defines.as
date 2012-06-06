/**
 * ...
 * @author sirmax2
 */
class wot.utils.Defines
{
  // Global versions
  public static var XVM_VERSION: String = "2.4.test5";
  public static var WOT_VERSION: String = "0.7.4";
  public static var CONFIG_VERSION: String = "1.3.0";
  public static var EDITOR_VERSION: String = "0.1.beta1";

  public static var DEFAULT_CONFIG_NAME: String = "XVM.xvmconf";

  // MAX_PATH is 259 on NTFS
  public static var MAX_PATH: Number = 100;

  // Path to Dokan MountPoint
  public static var DOKAN_MP = "../../../.stat/";

  // WebDav commands
  public static var COMMAND_LOG: String = DOKAN_MP + "@LOG";
  public static var COMMAND_SET: String = DOKAN_MP + "@SET";
  public static var COMMAND_ADD: String = DOKAN_MP + "@ADD";
  public static var COMMAND_RUN: String = DOKAN_MP + "@RUN";
  public static var COMMAND_RUNINGAME: String = DOKAN_MP + "@RUNINGAME";
  public static var COMMAND_RETRIEVE: String = DOKAN_MP + "@RETRIEVE";
  public static var COMMAND_READY: String = DOKAN_MP + "@READY";
  public static var COMMAND_GET_LAST_STAT: String = DOKAN_MP + "@GET_LAST_STAT";
  public static var COMMAND_GET_VERSION: String = DOKAN_MP + "@GET_VERSION";

  // Position
  public static var POSITION_LEFT: Number = 0;
  public static var POSITION_RIGHT: Number = 1;

  // Team
  public static var TEAM_ALLY: Number = 0;
  public static var TEAM_ENEMY: Number = 1;

  // Dynamic color types
  public static var DYNAMIC_COLOR_EFF: Number = 1;
  public static var DYNAMIC_COLOR_RATING: Number = 2;
  public static var DYNAMIC_COLOR_KB: Number = 3;
  public static var DYNAMIC_COLOR_HP: Number = 4;
  public static var DYNAMIC_COLOR_HP_RATIO: Number = 5;

  // Dynamic alpha types
  //public static var DYNAMIC_ALPHA_EFF: Number = 1;
  //public static var DYNAMIC_ALPHA_RATING: Number = 2;
  //public static var DYNAMIC_ALPHA_KB: Number = 3;
  public static var DYNAMIC_ALPHA_HP: Number = 4;
  public static var DYNAMIC_ALPHA_HP_RATIO: Number = 5;

  // Default path to vehicle icons (relative)
  public static var CONTOUR_ICON_PATH: String = "../maps/icons/vehicle/contour/";
}
