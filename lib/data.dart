import 'package:hive/hive.dart';

// part 'user.g.dart';

@HiveType(typeId: 1)
class IPData extends HiveObject {
  String? status;
  @HiveField(0)
  String? country;
  String? countryCode;
  String? region;
  @HiveField(1)
  String? regionName;
  @HiveField(2)
  String? city;
  String? zip;
  @HiveField(3)
  double? lat;
  @HiveField(4)
  double? lon;
  @HiveField(5)
  String? timezone;
  String? isp;
  String? org;
  String? dataAs;
  String? query;

  IPData({
    this.status,
    this.country,
    this.countryCode,
    this.region,
    this.regionName,
    this.city,
    this.zip,
    this.lat,
    this.lon,
    this.timezone,
    this.isp,
    this.org,
    this.dataAs,
    this.query,
  });

  factory IPData.fromJson(Map<String, dynamic> json) => IPData(
        status: json["status"],
        country: json["country"],
        countryCode: json["countryCode"],
        region: json["region"],
        regionName: json["regionName"],
        city: json["city"],
        zip: json["zip"],
        lat: json["lat"]?.toDouble(),
        lon: json["lon"]?.toDouble(),
        timezone: json["timezone"],
        isp: json["isp"],
        org: json["org"],
        dataAs: json["as"],
        query: json["query"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "country": country,
        "countryCode": countryCode,
        "region": region,
        "regionName": regionName,
        "city": city,
        "zip": zip,
        "lat": lat,
        "lon": lon,
        "timezone": timezone,
        "isp": isp,
        "org": org,
        "as": dataAs,
        "query": query,
      };
}

class IPDataAdapter extends TypeAdapter<IPData> {
  @override
  final int typeId = 0;

  @override
  IPData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, String>{};
    for (var i = 0; i < 6; i++) {
      final key = reader.readByte();
      final value = reader.read();
      fields[key] = value;
    }
    return IPData(country: fields[0] as String, regionName: fields[1] as String, city: fields[2] as String,
        lat: fields[3] as double, lon: fields[4] as double, timezone: fields[5] as String);
  }

  @override
  void write(BinaryWriter writer, IPData obj) {
    writer.writeByte(6);
    writer.writeByte(0);
    writer.write(obj.country);
    writer.writeByte(1);
    writer.write(obj.regionName);
    writer.writeByte(2);
    writer.write(obj.city);
    writer.writeByte(3);
    writer.write(obj.lat);
    writer.writeByte(4);
    writer.write(obj.lon);
    writer.writeByte(5);
    writer.write(obj.timezone);
  }
}
