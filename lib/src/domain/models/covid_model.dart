import 'dart:convert';

CovidModel covidModelFromJson(String str) =>
    CovidModel.fromJson(json.decode(str));

String covidModelToJson(CovidModel data) => json.encode(data.toJson());

class CovidModel {
  final String? objectIdFieldName;
  final UniqueIdField? uniqueIdField;
  final String? globalIdFieldName;
  final String? geometryType;
  final SpatialReference? spatialReference;
  final List<Field>? fields;
  final List<Feature>? features;

  CovidModel({
    this.objectIdFieldName,
    this.uniqueIdField,
    this.globalIdFieldName,
    this.geometryType,
    this.spatialReference,
    this.fields,
    this.features,
  });

  factory CovidModel.fromJson(Map<String, dynamic> json) => CovidModel(
        objectIdFieldName: json["objectIdFieldName"],
        uniqueIdField: json["uniqueIdField"] == null
            ? null
            : UniqueIdField.fromJson(json["uniqueIdField"]),
        globalIdFieldName: json["globalIdFieldName"],
        geometryType: json["geometryType"],
        spatialReference: json["spatialReference"] == null
            ? null
            : SpatialReference.fromJson(json["spatialReference"]),
        fields: json["fields"] == null
            ? []
            : List<Field>.from(json["fields"]!.map((x) => Field.fromJson(x))),
        features: json["features"] == null
            ? []
            : List<Feature>.from(
                json["features"]!.map((x) => Feature.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "objectIdFieldName": objectIdFieldName,
        "uniqueIdField": uniqueIdField?.toJson(),
        "globalIdFieldName": globalIdFieldName,
        "geometryType": geometryType,
        "spatialReference": spatialReference?.toJson(),
        "fields": fields == null
            ? []
            : List<dynamic>.from(fields!.map((x) => x.toJson())),
        "features": features == null
            ? []
            : List<dynamic>.from(features!.map((x) => x.toJson())),
      };
}

class Feature {
  final Attributes? attributes;

  Feature({
    this.attributes,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        attributes: json["attributes"] == null
            ? null
            : Attributes.fromJson(json["attributes"]),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes?.toJson(),
      };
}

class Attributes {
  final int? lastUpdate;
  final int? recovered;
  final int? deaths;
  final int? confirmed;

  Attributes({
    this.lastUpdate,
    this.recovered,
    this.deaths,
    this.confirmed,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        lastUpdate: json["Last_Update"],
        recovered: json["Recovered"],
        deaths: json["Deaths"],
        confirmed: json["Confirmed"],
      );

  Map<String, dynamic> toJson() => {
        "Last_Update": lastUpdate,
        "Recovered": recovered,
        "Deaths": deaths,
        "Confirmed": confirmed,
      };
}

class Field {
  final String? name;
  final String? type;
  final String? alias;
  final String? sqlType;
  final int? length;
  final dynamic domain;
  final dynamic defaultValue;

  Field({
    this.name,
    this.type,
    this.alias,
    this.sqlType,
    this.length,
    this.domain,
    this.defaultValue,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        name: json["name"],
        type: json["type"],
        alias: json["alias"],
        sqlType: json["sqlType"],
        length: json["length"],
        domain: json["domain"],
        defaultValue: json["defaultValue"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "alias": alias,
        "sqlType": sqlType,
        "length": length,
        "domain": domain,
        "defaultValue": defaultValue,
      };
}

class SpatialReference {
  final int? wkid;
  final int? latestWkid;

  SpatialReference({
    this.wkid,
    this.latestWkid,
  });

  factory SpatialReference.fromJson(Map<String, dynamic> json) =>
      SpatialReference(
        wkid: json["wkid"],
        latestWkid: json["latestWkid"],
      );

  Map<String, dynamic> toJson() => {
        "wkid": wkid,
        "latestWkid": latestWkid,
      };
}

class UniqueIdField {
  final String? name;
  final bool? isSystemMaintained;

  UniqueIdField({
    this.name,
    this.isSystemMaintained,
  });

  factory UniqueIdField.fromJson(Map<String, dynamic> json) => UniqueIdField(
        name: json["name"],
        isSystemMaintained: json["isSystemMaintained"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "isSystemMaintained": isSystemMaintained,
      };
}
