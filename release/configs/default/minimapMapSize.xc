﻿/**
 * Textfield for map side size. 1000m, 700m, 600m.
 * Поле размера стороны карты. Например, 1000м, 700м, 600м.
 */
{
  "mapSize": {
    "enabled": true,
    "format": "<b>{{cellsize}}0 m</b>",
    "css": "font-size:10px; color:#FFCC66;",
    "alpha": 80,
    "offsetX": 0,
    "offsetY": 0,
    "shadow": { // Тень.
      "enabled": true,
      "color": "0x000000",
      "distance": 0,
      "angle": 0,
      "alpha": 80,
      "blur": 2,
      "strength": 3
    },
    // Decrease sizes in case of map image weird shrinking while map resize.
    // Increase sizes in case of field being partially cut off.
    // -------------------------------------------------------------------------------------
    // Уменьшайте размеры, если при изменении размера миникарты изображение карты сжимается.
    // Увеличивайте размеры, если содержимое поля обрезается.
    "width": 100,
    "height": 30
  }
}
