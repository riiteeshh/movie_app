import 'package:flutter/material.dart';

//db0dcf6a517e0074f03f43ddc49031b4 api key
class ResponseModel {
  final dynamic data;

  const ResponseModel({
    required this.data,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    debugPrint('json: $json');
    return ResponseModel(
      data: json['results'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
