{
  "minimap": {
    //"enabled": false,
    //"mapBackgroundImageAlpha": 50,
    //"selfIconColor": "{{player?0x0000FF|0x0000FF}}",
    //"selfIconAlpha": 70,
    //"selfIconScale": 0.5,
    //"iconAlpha": 10,
    //"iconScale": 0.5,
    "directionTriangleAlpha": 0,
    "directionLineAlpha": 0,
    //"showDirectionLineAfterDeath": false,
    //"showCellClickAnimation": false,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim.png",
    "minimapAimIconScale": 100,
    //"zoom": { "index": 5, "centered": true },
    "mapSize": ${"../default/minimapMapSize.xc":"mapSize"},
    //"circlesEnabled": false,
    //"labelsEnabled": false,
    //"linesEnabled": false,
    "labels": ${"sirmax-minimapLabels.xc":"labels"},
    "circles": ${"sirmax-minimapCircles.xc":"circles"},
    "lines": ${"sirmax-minimapLines.xc":"lines"}
  },
  "minimapAlt": {
    "$ref": { "path": "minimap" },
    "mapBackgroundImageAlpha": 75,
    "selfIconAlpha": 50,
    "selfIconScale": 1.2,
    "iconAlpha": 75,
    "iconScale": 1.2,
    "directionTriangleAlpha": 50,
    "directionLineAlpha": 50,
    "showDirectionLineAfterDeath": false,
    "showCellClickAnimation": false,
    "minimapAimIcon": "cfg://sirmax/img/MinimapAim2.png",
    "minimapAimIconScale": 200,
    "zoom": { "index": 5, "centered": true },
    "mapSize": ${"../default/minimapMapSize.xc":"mapSize"},
    "labels": ${"sirmax-minimapLabels.xc":"labels"},
    "circles": ${"sirmax-minimapCircles.xc":"circles"},
    "lines": ${"sirmax-minimapLines.xc":"lines"}
  }
}
