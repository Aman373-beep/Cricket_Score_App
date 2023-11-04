class Datum {
    Datum({
        required this.id,
        required this.dateTimeGmt,
        required this.matchType,
        required this.status,
        required this.ms,
        required this.t1,
        required this.t2,
        required this.t1S,
        required this.t2S,
        this.t1Img,
        this.t2Img,
    });

    String id;
    DateTime dateTimeGmt;
    MatchType matchType;
    String status;
    Ms ms;
    String t1;
    String t2;
    String t1S;
    String t2S;
    String? t1Img;
    String? t2Img;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        dateTimeGmt: DateTime.parse(json["dateTimeGMT"]),
        matchType: matchTypeValues.map[json["matchType"]]!,
        status: json["status"],
        ms: msValues.map[json["ms"]]!,
        t1: json["t1"],
        t2: json["t2"],
        t1S: json["t1s"],
        t2S: json["t2s"],
        t1Img: json["t1img"],
        t2Img: json["t2img"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateTimeGMT": dateTimeGmt.toIso8601String(),
        "matchType": matchTypeValues.reverse[matchType],
        "status": status,
        "ms": msValues.reverse[ms],
        "t1": t1,
        "t2": t2,
        "t1s": t1S,
        "t2s": t2S,
        "t1img": t1Img,
        "t2img": t2Img,
    };
}

enum MatchType { T20, ODI, TEST }

final matchTypeValues = EnumValues({
    "odi": MatchType.ODI,
    "t20": MatchType.T20,
    "test": MatchType.TEST
});

enum Ms { FIXTURE, RESULT, LIVE }

final msValues = EnumValues({
    "fixture": Ms.FIXTURE,
    "live": Ms.LIVE,
    "result": Ms.RESULT
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
