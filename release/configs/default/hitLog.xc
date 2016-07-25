﻿/**
 * Hit log (my hits calculator).
 * Лог попаданий (счетчик своих попаданий).
 */
{
  "hitLog": {
    // false - Disable.
    // false - отключить.
    "enabled": true,
    // Group hits by players name.
    // Группировать попадания по имени игрока.
    "groupHitsByPlayer": true,
    // Log direction: up - lines will be added from up to down, down - from down to up.
    // Направление лога: up - строки добавляются сверху, down - снизу.
    "direction": "down",
    // Insert order: begin - insert new values to begin, end - add to end.
    // Сортировка попаданий: begin - новые значения добавляются сверху, end - снизу.
    "insertOrder": "end",
    // Substitution for {{hitlog.dead}} macro when tank is dead.
    // Подстановка для макроса {{hitlog.dead}}, когда танк умирает.
    "deadMarker": "&#x77;",
    "blowupMarker": "&#x78;",
    // Default header format (before first hit). Only localization macros are allowed, see macros.txt.
    // Формат заголовка по умолчанию (до первого попадания). Допускаются только макросы перевода, см. macros.txt.
    "defaultHeader":  "<font color='#FFFFFF'>{{l10n:Hits}}:</font> <font size='13'>#0</font>",
    // Hits header format, including last hit (macros allowed, see macros.txt).
    // Формат заголовка (допускаются макроподстановки, см. macros.txt).
    "formatHeader":  "<font color='#FFFFFF'>{{l10n:Hits}}:</font> <font size='13'>#{{hitlog.n}}</font> <font color='#FFFFFF'>{{l10n:Total}}: </font><b>{{hitlog.dmg-total}}</b>  <font color='#FFFFFF'>{{l10n:Last}}:</font> <font color='{{hitlog.dmg-kind-color}}'><b>{{hitlog.dmg}}</b></font> <font face='xvm' size='21'>{{hitlog.dead=&#x77;?&#x29;|{{hitlog.dead=&#x78;?&#x28;}}}}</font>",
    // List of hits format (macros allowed, see macros.txt).
    // Формат лога попаданий (допускаются макроподстановки, см. macros.txt)
    "formatHistory": "<textformat leading='-4' tabstops='[20,50,90,190]'><font size='12'>\u00D7{{hitlog.n-player}}:</font><tab><font color='{{c:dmg-kind}}'>{{dmg}}</font><tab>| {{hitlog.dmg-player}}<tab>|<font color='{{c:vtype}}'>{{vehicle}}</font> <font face='xvm' size='19' color='#FF0000'>{{hitlog.dead}}</font><tab><font color='#FFFFFF'>|{{name%.15s~..}} <font alpha='#A0'>{{clan}}</font></font></textformat>"
  }
}
