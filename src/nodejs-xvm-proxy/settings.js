module.exports = (function()
{
    // exports
    return {
        host: "127.0.0.1",
        port: <port>,
        maxSockets: 100, // per client
        cacheTtl: 7 * 24 * 60 * 60 * 1000, // 7 days
        lastErrorTtl: 6 * 1000, // in msec
        usageStatShowPeriod: 60 * 1000, // in msec
        dbName: "<dbname>",
        collectionName: "<collection>",
        missedCollectionName: "<missed_collection>",
        usersCollectionName: "<users_collection>",
        statHostMaxConnections: 100,
        statHosts: [
            "worldoftanks.ru",      // RU:           0 ..  49999999
            "worldoftanks.eu",      // EU:    50000000 ..  99999999
            "worldoftanks.com",     // NA:   100000000 .. 149999999
            "worldoftanks-sea.com", // ???: 1500000000 .. 199999999
            "worldoftanks-sea.com", // SEA: 2000000000 .. 249999999
            "wot.go.vn"             // VTC: 2500000000 .. 299999999
        ],
        statHostsTimeouts: [
            5000,      // RU
            5000,      // EU
            5000,      // NA
            6000,      // ???
            6000,      // SEA
            19000      // VTC
        ],
        wotApiVersion: "1.5",
        info: {
            RU: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            EU: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            NA: {
                ver: "<version>",
                message: [
                    "<msg line 1>",
                    "<msg line N"
                ].join("\n")
            },
            SEA: { ver: "<version>", message: "" },
            VTC: { ver: "<version>", message: "" },
            CT: {  ver: "<version>", message: "" }
        }
    }
})();
