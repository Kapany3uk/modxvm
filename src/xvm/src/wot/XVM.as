﻿/**
/**
 * ...
 * @author Nikolas Siver
 * @author bkon
 * @author sirmax2
 * @author STL1te
 */
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.greensock.easing.Cubic;
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Stat;
import wot.utils.Utils;
import wot.utils.Logger;

class wot.XVM extends net.wargaming.ingame.VehicleMarker
{
  static var DEBUG_TIMES = false;
        
  // UI Elements
  var damageHolder: MovieClip;
  var xvmHealthBar: MovieClip;
  var grid: MovieClip;

  // Private members
  var m_showExInfo: Boolean = false;
  var m_currentHealth: Number;
  var m_showMaxHealth: Boolean;

  // TextFields
  var textFields: Array;

  // Damage Text Settings
  var damageCfg: Object;

  // Healthbar Settings
  var hbBar: MovieClip;
  var hbDamageBar: MovieClip;
  var hb: Object = { };

  function XVM()
  {
    super();

    Config.LoadConfigAndStatLegacy("XVM.xvmconf");

    damageHolder = createEmptyMovieClip("damageHolder", getNextHighestDepth());
    xvmHealthBar = createEmptyMovieClip("xvmHealthBar", getNextHighestDepth());

    grid = createEmptyMovieClip("grid", getNextHighestDepth());

    pNameField._visible = false;
    pNameField.removeTextField();
    delete pNameField;
    pNameField = undefined;
    vNameField._visible = false;
    vNameField.removeTextField();
    delete vNameField;
    vNameField = undefined;
    healthBar.stop();
    healthBar._visible = false;
    healthBar.removeMovieClip();
    delete healthBar;
    healthBar = undefined;
  }
  
  // override
  function init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt)
  {
    if (entityName != null)
      m_entityName = entityName;

    // Use currently remembered extended / normal status for new markers
    m_showExInfo = s_showExInfo;

    super.init(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth, entityName, speaking, hunt);
  }

  // override
  function showHealthBar(show)
  {
    // do nothing
  }

  // override
  function updateHealth(curHealth)
  {
    m_curHealth = curHealth >= 0 ? curHealth : 0;
    setupNewHealth(curHealth);
    updateHealthUI(curHealth);
  }

  // override
  function updateState(newState, isImmediate)
  {
    super.updateState(newState, isImmediate);

    XVMUpdateStyle();
  }

  // override
  function showExInfo(show)
  {
    if (m_showExInfo == show)
      return;
    m_showExInfo = show;

    // Save current extended / normal state flag to static variable, so
    // new markers can refer to it when rendered initially
    s_showExInfo = show;

    XVMUpdateStyle();
  }

  // override
  function configUI()
  {
    m_currentHealth = m_curHealth;

    super.configUI();
    
    if (Config.s_config.battle.drawGrid)
      GraphicsUtil.drawGrid(grid, -50, -50, 100, 100, 0xFFFF00, 30);

    XVMUpdateStyle();
  }

  function draw()
  {
    super.draw();
    if (iconLoader != null && iconLoader.initialized)
      iconLoader.addEventListener("complete", this, "XVMIconCompleteLoad");
  }

  // override
  function populateData()
  {
    if (m_isPopulated)
      return false;
    m_isPopulated = true;

    this.initMarkerLabel();

    if (iconLoader != null && iconLoader.initialized)
    {
      iconLoader.addEventListener("ioError", this, "_onErrorLoad");
      iconLoader.addEventListener("complete", this, "_onCompleteLoad");
      var color = this.colorsManager.getAliasColor(this.colorSchemeName);
      var trans = new flash.geom.Transform(iconLoader);
      trans.colorTransform = color.transform;
    }
    else
    {
      this.invalidate();
    }

    if (levelIcon != null)
      levelIcon.gotoAndStop(m_level);

    if (m_vehicleClass != null)
      this.setVehicleClass();

    if (m_markerState != null)
      marker.gotoAndPlay(m_markerState);

    XVMPopulateData();
    setupNewHealth(m_curHealth);

    return true;
  }

  // Comment below is not useful for now, but it's very beauty, so I can't delete it :) (sirmax2)
  //
  // The name is a LIE! We're actually selecting marker color scheme here.
  // VehicleMarkerAlly should contain 4 named frames:
  // - green - normal ally
  // - gold - squad mate
  // - blue - teamkiller
  // - yellow - squad mate in "alternate colors" mode
  // VehicleMarkerEnemy should contain 2 named frames:
  // - red - normal enemy
  // - purple - enemy in "alternate colors" mode
  //function initMarkerLabel() {
  //  this.gotoAndStop(this.colorsManager.getAliasColor(this.colorSchemeName));
  //}

  // override
  function updateMarkerLabel()
  {
    var color = this.colorsManager.getAliasColor(this.colorSchemeName);
    if (m_markerLabel == color.aliasColor)
      return;

    m_markerLabel = color.aliasColor;
    this.gotoAndStop(m_markerLabel);
    if (m_vehicleClass != null)
      this.setVehicleClass();
    if (m_markerState != null)
    {
      if (this.vehicleDestroyed)
        m_markerState = "immediate_dead";
      marker.gotoAndPlay(m_markerState);
    }
    var trans = new flash.geom.Transform(iconLoader);
    trans.colorTransform = color.transform;

    // Update layout for the current marker state
    XVMPopulateData();
    XVMUpdateStyle();
  }

  // override
  function _onErrorLoad(event)
  {
    super._onErrorLoad(event);
  }

  // override
  function _onCompleteLoad(event)
  {
    super._onCompleteLoad(event);
  }
  
  /**
   * MAIN
   */

  function GetCurrentStateConfigRoot()
  {
    var result = Config.s_config.markers;
    result = m_entityName == "enemy" ? result.enemy : result.ally;
    result = this.vehicleDestroyed ? result.dead : result.alive;
    result = m_showExInfo ? result.extended : result.normal;
    return result;
  }
   
  function XVMColorWithFallback(value)
  {
    if (!isNaN(value))
      return Number(value);
    var color = value ? Number(Stat.FormatText({ label: m_playerFullName }, value).split("#").join("0x")) : null;
    return (color && !isNaN(color)) ? color : this.colorsManager.getRGB(this.colorSchemeName);
  }

  function XVMFormatText(format: String, curHealth: Number, delta: Number)
  {
    // AS 2 doesn't have String.replace? Shame on them. Let's use our own square wheel.
    format = format.split("{{hp}}").join(String(curHealth));
    format = format.split("{{hp-max}}").join(String(m_maxHealth));
    var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
    format = format.split("{{hp-ratio}}").join(String(hpRatio));
    format = format.split("{{nick}}").join(m_playerFullName);
    format = format.split("{{vehicle}}").join(m_vname);
    format = format.split("{{dmg}}").join(delta != 0 ? String(delta) : "");
    var dmgRatio: Number = Math.ceil(delta / m_maxHealth * 100);
    format = format.split("{{dmg-ratio}}").join(delta != 0 ? String(dmgRatio) : "");

    format = format.split("{{c:hp}}").join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, curHealth));
    format = format.split("{{c:hp-ratio}}").join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, hpRatio));

    format = Stat.FormatText({ label: m_playerFullName }, format);
    format = Utils.trim(format);

    return format;
  }

  function XVMFormatAlpha(format: String, curHealth: Number)
  {
    if (!format)
      return 100;
    if (!isNaN(format))
      return Number(format);

    //wot.utils.Logger.add("format=" + net.wargaming.io.JSON.stringify(format));
    format = format.split("{{a:hp}}").join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP, curHealth));
    var hpRatio: Number = Math.ceil(curHealth / m_maxHealth * 100);
    format = format.split("{{a:hp-ratio}}").join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO, hpRatio));

    var n: Number = parseInt(format);
    //wot.utils.Logger.add("format=" + format + " value=" + n + " curHealth=" + curHealth);
    n = isNaN(n) ? 100 : n;
    return n;
  }

  function XVMCreateNewTextFormat(config_font: Object)
  {
    if (!config_font)
      return null;

    return new TextFormat(
      config_font.name,
      config_font.size,
      0x000000,
      config_font.bold,
      false, false, null, null,
      config_font.align);
  }

  function XVMCreateTextField(cfg)
  {
    //Logger.addObject(cfg);
    var textField = createTextField("infoText", getNextHighestDepth(), 0, 0, 140, 31);
    //textField.html = false; // FIXIT: in html mode Font and Position are wrong.
    var textFormat: TextFormat = XVMCreateNewTextFormat(cfg.font);
    textField.setNewTextFormat(textFormat);
    textField.filters = [ GraphicsUtil.createShadowFilter(cfg.shadow) ];

    textField.textColor = XVMColorWithFallback(cfg.color);
    textField._x = cfg.x - textField._width / 2;
    textField._y = cfg.y - textField._height / 2;
    textField._visible = cfg.visible;

    return { field: textField, format: cfg.format, alpha: cfg.alpha };
  }

  function XVMRemoveTextFields()
  {
    for (var i in this.textFields)
    {
      this.textFields[i].field.removeTextField();
      delete this.textFields[i].field;
    }
    this.textFields = [];
  } 

  // Damage Visualization
  function removeTextField(f: TextField)
  {
    f.removeTextField();
  }

  function showDamage(text: String)
  {
    var n = damageHolder.getNextHighestDepth();
    var damageField = damageHolder.createTextField("damageField" + n, n, 0, 0, 140, 20);
    var animation: TimelineLite = new TimelineLite({ onComplete:this.removeTextField, onCompleteParams:[damageField] });

    // For some reason, DropShadowFilter is not rendered when textfield contains only one character,
    // so we're appending empty prefix and suffix to bypass this unexpected behavior
    damageField.text = " " + text + " ";
    damageField.antiAliasType = "advanced";
    damageField.autoSize = "left";
    damageField.border = false;
    damageField.embedFonts = true;
    damageField.setTextFormat(XVMCreateNewTextFormat(damageCfg.font));
    damageField.textColor = XVMColorWithFallback(damageCfg.color);
    damageField._x = -(damageField._width >> 1);
    damageField.filters = [ GraphicsUtil.createShadowFilter(damageCfg.shadow) ];

    animation.insert(new TweenLite(damageField, damageCfg.speed, { _y: -damageCfg.maxRange, ease: Linear.easeOut }), 0);
  }

  // Health Visualization
  function setupNewHealth(curHealth)
  {
    var delta: Number = curHealth - m_currentHealth;
    if (delta < 0)
    {
      updateCurrentColor(curHealth, m_maxHealth); //colorizing health bar after taking damage

      if (damageCfg.visible)
        this.showDamage(XVMFormatText((curHealth < 0) ? damageCfg.blowupMessage : damageCfg.damageMessage, curHealth, -delta));

      m_currentHealth = curHealth;

      //Flow bar animation
      TweenLite.killTweensOf(this.hbDamageBar);
      this.hbDamageBar._x = hb.border + hb.width * (curHealth / m_maxHealth);
      this.hbDamageBar._xscale = this.hbDamageBar._xscale + 100 * (-delta / m_maxHealth);
      TweenLite.to(this.hbDamageBar, hb.damageTime, {_xscale:0, ease:Cubic.easeIn});
    }
  }

  function updateHealthUI(curHealth)
  {
    var ratio: Number = curHealth / m_maxHealth * 100;
    //healthField.text = m_showMaxHealth ? curHealth + " / " + m_maxHealth : curHealth;
    //healthRatio.text = Math.ceil(ratio) + "%";
    this.hbBar._xscale = ratio;

    for (var i in this.textFields)
    {
      this.textFields[i].field.text = XVMFormatText(this.textFields[i].format, curHealth);
      this.textFields[i].field._alpha = XVMFormatAlpha(this.textFields[i].alpha, curHealth);
    }
  }

  function updateCurrentColor(curHealth)
  {
    var cfg = GetCurrentStateConfigRoot().healthBar;

    var fullColor: Number = XVMColorWithFallback(cfg.color);
    var lowColor: Number = XVMColorWithFallback(cfg.lcolor || cfg.color);

    var percent: Number = curHealth / m_maxHealth;

    //determ current (real-time) color
    hb.currColor = GraphicsUtil.colorByRatio(percent, lowColor, fullColor);
    GraphicsUtil.setColor(this.hbBar, hb.currColor); //colorizing health bar
  }

  function XVMIconCompleteLoad(event)
  {
    // Vehicle Icon
    var cfg = GetCurrentStateConfigRoot().contourIcon;

    if (cfg.amount > 0)
    {
      var iconColor: Color = new Color(iconLoader);
      var tintColor: Number = XVMColorWithFallback(cfg.color);
      var tintAmount: Number = cfg.amount * 0.01;
      var tintRatio: Number;

      var iconTransform: Object = iconColor.getTransform();
      iconTransform.rb = (tintColor >> 16);
      iconTransform.gb = (tintColor >> 8) & 0xff;
      iconTransform.bb = (tintColor & 0xff);
      iconTransform.ra = 0;
      iconTransform.ga = 0;
      iconTransform.ba = 0;
      tintRatio = tintAmount / (1 - ((iconTransform.ra + iconTransform.ga + iconTransform.ba) / 300));
      iconTransform.rb *= tintRatio;
      iconTransform.gb *= tintRatio;
      iconTransform.bb *= tintRatio;
      iconTransform.ra = iconTransform.ga = iconTransform.ba = (1 - tintAmount) * 100;
      iconColor.setTransform(iconTransform);
    }

    XVMUpdateStyle();
  }

  function XVMPopulateData()
  {
    var start = new Date();

    var cfg = GetCurrentStateConfigRoot();

    // Vehicle Type Marker
    for (var childName in marker.marker)
    {
      var child = marker.marker[childName];
      child._x += cfg.vehicleIcon.scaleX * cfg.vehicleIcon.maxScale / 100;
      child._y += cfg.vehicleIcon.scaleY * cfg.vehicleIcon.maxScale / 100;
      child._xscale = child._yscale = cfg.vehicleIcon.maxScale;
    };

    // Vehicle Type Icon
    if (iconLoader != null && iconLoader.initialized)
    {
      iconLoader.addEventListener("complete", this, "XVMIconCompleteLoad");
      XVMIconCompleteLoad(null);
    }

    // Damage Text
    damageCfg = cfg.damageText;

    // Health Bar
    xvmHealthBar.clear();

    if (this.hbBar)
      this.hbBar.clear();
    else
      this.hbBar = xvmHealthBar.createEmptyMovieClip("barMC", xvmHealthBar.getNextHighestDepth());

    if (this.hbDamageBar)
      this.hbDamageBar.clear();
    else
      this.hbDamageBar = xvmHealthBar.createEmptyMovieClip("damageMC", xvmHealthBar.getNextHighestDepth());

    hb.border = cfg.healthBar.border.size;
    hb.width = cfg.healthBar.width;
    hb.height = cfg.healthBar.height;
    hb.damageTime = cfg.healthBar.damage.fade;

    GraphicsUtil.fillRect(xvmHealthBar, 0, 0, hb.width + 2 * hb.border, hb.height + 2 * hb.border,
      cfg.healthBar.border.color, cfg.healthBar.border.alpha);
    GraphicsUtil.fillRect(this.hbBar, 0, 0, hb.width, hb.height,
      hb.currColor, cfg.healthBar.fill.alpha);
    GraphicsUtil.fillRect(this.hbDamageBar, 0, 0, hb.width, hb.height,
      XVMColorWithFallback(cfg.healthBar.damage.color), cfg.healthBar.damage.alpha);

    this.hbBar._x = this.hbBar._y = hb.border;
    this.hbDamageBar._x = hb.border + hb.width;
    this.hbDamageBar._y = hb.border;
    this.hbDamageBar._xscale = 0;

    if (DEBUG_TIMES)
      Logger.add("DEBUG TIME: XVMPopulateData(): " + Utils.elapsedMSec(start, new Date()) + " ms");
  }

  function XVMUpdateStyle()
  {
    var start = new Date();

    try
    {
      var cfg = GetCurrentStateConfigRoot();

      var visible: Boolean;
      
      // Vehicle Type Marker
      visible = cfg.vehicleIcon.visible;
      if (visible)
      {
        marker._x = cfg.vehicleIcon.x;
        marker._y = cfg.vehicleIcon.y;
        marker._alpha = XVMFormatAlpha(cfg.vehicleIcon.alpha, m_curHealth);
      }
      marker._visible = visible;

      // Level Icon
      visible = cfg.levelIcon.visible;
      if (visible)
      {
        levelIcon._x = cfg.levelIcon.x;
        levelIcon._y = cfg.levelIcon.y;
        levelIcon._alpha = XVMFormatAlpha(cfg.levelIcon.alpha, m_curHealth);
      }
      levelIcon._visible = visible;

      // Action Marker
      visible = cfg.actionMarker.visible;
      if (visible)
      {
        actionMarker._x = cfg.actionMarker.x;
        actionMarker._y = cfg.actionMarker.y;
      }
      actionMarker._visible = visible;

      // Vehicle Icon
      visible = cfg.contourIcon.visible;
      if (visible)
      {
        iconLoader._x = cfg.contourIcon.x - iconLoader.__width / 2;
        iconLoader._y = cfg.contourIcon.y - iconLoader.__height / 2;
        iconLoader._alpha = XVMFormatAlpha(cfg.contourIcon.alpha, m_curHealth);
      }
      iconLoader._visible = visible;

      // Damage Text
      visible = cfg.damageText.visible;
      if (visible)
      {
        damageHolder._x = cfg.damageText.x;
        damageHolder._y = cfg.damageText.y;
      }
      damageHolder._visible = visible;

      // Health Bar
      visible = cfg.healthBar.visible;
      if (visible)
      {
        xvmHealthBar._x = cfg.healthBar.x;
        xvmHealthBar._y = cfg.healthBar.y;
        xvmHealthBar._alpha = XVMFormatAlpha(cfg.healthBar.alpha, m_curHealth);
      }
      xvmHealthBar._visible = visible;

      // Info Text (must be optimized - it is not good to recreate objects each time)
      XVMRemoveTextFields();
      this.textFields = [];
      for (var i in cfg.textFields)
        this.textFields.push(XVMCreateTextField(cfg.textFields[i]));

      // Update Colors
      this.updateCurrentColor(m_curHealth);
      this.updateHealthUI(m_curHealth);
    }
    catch (e)
    {
      XVMSetErrorText("ERR:us:" + String(e));
    }

    if (DEBUG_TIMES)
      Logger.add("DEBUG TIME: XVMUpdateStyle(): " + Utils.elapsedMSec(start, new Date()) + " ms");
  }

  function XVMSetErrorText(str)
  {
    pNameField.setNewTextFormat(new TextFormat("$FieldFont", 13, 0xFF0000, true, false, true, null, null, "center"));
    pNameField.text = str;
    pNameField._width = 150;
    pNameField._height = 20;
    pNameField._x = -75;
    pNameField._y = 5;
    pNameField._alpha = 100;
    pNameField._visible = true;
  }
}
