/**
 * ...
 * @author sirmax2
 */
class wot.utils.Defines
{
  // Global mod versiob
  public static var XVM_VERSION = "1.4-pre1";

  public static var DEFAULT_CONFIG_NAME = "XVM.xvmconf";
        
  // file name limit is ~ 220 chars
  public static var MAX_PATH = 180;

  // Path to Dokan MountPoint
  public static var DOKAN_MP = "../../../.stat/";

  // WebDav commands
  public static var COMMAND_LOG = DOKAN_MP + "@LOG";
  public static var COMMAND_SET = DOKAN_MP + "@SET";
  public static var COMMAND_ADD = DOKAN_MP + "@ADD";
  public static var COMMAND_GET = DOKAN_MP + "@GET";
  public static var COMMAND_RUN = DOKAN_MP + "@RUN";
  public static var COMMAND_GET_LAST_STAT = DOKAN_MP + "@GET_LAST_STAT";

  // Position
  public static var POSITION_LEFT = 0;
  public static var POSITION_RIGHT = 1;

  // Team
  public static var TEAM_ALLY = 0;
  public static var TEAM_ENEMY = 1;
  
  // Dynamic color types
  public static var DYNAMIC_COLOR_EFF = 1;
  public static var DYNAMIC_COLOR_RATING = 2;
  public static var DYNAMIC_COLOR_KB = 3;
}
