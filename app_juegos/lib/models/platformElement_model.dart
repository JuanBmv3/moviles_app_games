
import 'package:flutter/rendering.dart';

import 'Platform_model.dart';

class PlatformElement {
  PlatformPlatform? platform;
  String? releasedAt;
  dynamic? requirementsRu;

  PlatformElement({
    this.platform,
    this.releasedAt,
    this.requirementsRu,
  });

  factory PlatformElement.fromMap(Map<String,dynamic> map){
    return PlatformElement(
     platform : map['platform'] == null ? null : PlatformPlatform.fromMap(map['platform']),
     releasedAt: map['releasedAt'],
     requirementsRu: map['requirements']
    );
  }
}