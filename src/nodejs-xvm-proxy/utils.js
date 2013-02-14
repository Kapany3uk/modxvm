// calculate average level of tanks
var calculateAvgLvl = exports.calculateAvgLevel = function(vehicles) {
    var level_battles = 0,
        total_battles = 0;

    for (var vname in vehicles) {
        var item = vehicles[vname];
        level_battles += item.l * item.b;
        total_battles += item.b;
    }
    return total_battles <= 0 ? 0 : level_battles / total_battles;
};

// calculateEfficiency
// EFF formula:
// DAMAGE * (10 / (TIER + 2)) * (0.23 + 2 * TIER / 100)
// + FRAGS * 0.25 * 1000
// + SPOT * 0.15 * 1000 +
// + LOG((CAP + 1), 1.732) * 0.15 * 1000
// + DEF * 0.15 * 1000
exports.calculateEfficiency = function(data) {
    if (!data || !data.b || data.b <= 0)
        return 0;

    var TIER = data.lvl;
    var FRAGS = data.frg / data.b;
    var DAMAGE = data.dmg / data.b;
    var SPOT = data.spo / data.b;
    var CAP = data.cap / data.b;
    var DEF = data.def / data.b;

    var res = Math.round(
        DAMAGE * (10 / (TIER + 2)) * (0.23 + 2 * TIER / 100) +
        FRAGS * 250 +
        SPOT * 150 +
        Math.log(CAP + 1) / Math.log(1.732) * 150 +
        DEF * 150);

//        console.log("eff: " + (new Date() - start) + " ms (" + JSON.stringify(data).length + " bytes)");
        return res;
};

// normalized EFF
// MAX(MIN(6,17*10^(-9)*eff^3 - 1,975*10^(-5)*eff^2 + 0,08125*eff - 31,04 ; 100) ; 0)
exports.calculateNEFF = function(value) {
    var res = Math.round(Math.max(0, Math.min(100,
        0.00000000617*Math.pow(value, 3) - 0.00001975*Math.pow(value, 2) + 0.08125*value - 31.04)));
    return res == 100 ? "XX" : (res < 10 ? "0" : "") + res;
};

// WN rating
// Current: WN6
// http://forum.worldoftanks.com/index.php?/topic/184017-/page__st__1080__pid__3542824#entry3542824
// WN6 formula:
// (1240-1040/(MIN(TIER,6))^0.164)*FRAGS
// +DAMAGE*530/(184*e^(0.24*TIER)+130)
// +SPOT*125
// +MIN(DEF,2.2)*100
// +((185/(0.17+e^((WINRATE-35)*-0.134)))-500)*0.45
// +(6-MIN(TIER,6))*-60
exports.calculateWN = function(data) {
    if (!data || !data.b || data.b <= 0)
        return 0;

    var TIER = data.lvl;
    var TIER_N = Math.min(6, TIER);
    var FRAGS = data.frg / data.b;
    var DAMAGE = data.dmg / data.b;
    var SPOT = data.spo / data.b;
    var DEF = Math.min(2.2, data.def / data.b);
    var WINRATE = data.w / data.b * 100;

    return Math.max(1, Math.round(
        (1240 - 1040 / Math.pow(TIER_N, 0.164)) * FRAGS +
        DAMAGE * 530 / (184 * Math.exp(0.24 * TIER) + 130) +
        SPOT * 125 +
        DEF * 100 +
        ((185 / (0.17 + Math.exp((WINRATE - 35) * -0.134))) - 500) * 0.45 +
        (6 - TIER_N) * -60)) || 0;
};

// normalized WN6
// MAX(MIN(4,116*10^(-9)*wn6^3 - 8,189*10^(-6)*wn6^2 + 0,048*WN6-3,146 ; 100) ; 0)
exports.calculateNWN = function(value) {
    var res = Math.round(Math.max(0, Math.min(100,
        0.000000004116*Math.pow(value, 3) - 0.000008189 * Math.pow(value, 2) + 0.048*value - 3.146)));
    return res == 100 ? "XX" : (res < 10 ? "0" : "") + res;
};

exports.getVehicleType = function(vclass) {
    switch(vclass.toLowerCase()) {
        case "lighttank":       return "LT";
        case "mediumtank":      return "MT";
        case "heavytank":       return "HT";
        case "at-spg":          return "TD";
        case "spg":             return "SPG";
        default:                return "unknown";
    }
};

// deep-copy of object (only simple type values supported)
var clone = exports.clone = function(obj) {
    // TODO: use FASTER implementation
    return JSON.parse(JSON.stringify(obj));
};

// log
var log = exports.log = function(str) {
    var now = new Date();
    var s = now.getFullYear() + "-" +
        (now.getMonth() < 9 ? "0" : "") + (now.getMonth() + 1) + "-" +
        (now.getDate() < 10 ? "0" : "") + now.getDate() + " " +
        now.toLocaleTimeString();
    console.log(s + ": " + str);
};

// debug
exports.debug = function(str) {
    log("DEBUG: " + str);
};

// Filter vehicle data
exports.filterVehicleData = function(item, vname) {
    if (!vname || !item.v)
        return null;

    if (item.v instanceof Array) {
        // TODO: remove legacy code
        for(var i in item.v) {
            try {
                if (item.v[i].name.toUpperCase() == vname)
                    return item.v[i];
            } catch (e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
        // [/TODO]
    } else {
        // NEW
        for (var vn in item.v) {
            try {
                if (vn == vname) {
                    var res = item.v[vn];
                    res["name"] = vn;
                    return res;
                }
            } catch (e) {
                log("[ERROR]>  " + e + " id=" + item._id + " " + JSON.stringify(item));
            }
        }
    }
    return null;
};
