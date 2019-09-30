import 'dart:async';

import 'package:flutter/services.dart';

enum DeviceClassType {
  Phone,
  Tablet,
  Tv,
  Stb
}

class DeviceExtInfo {
  static const MethodChannel _channel =
      const MethodChannel('device_ext_info');

  static Future<String> get deviceName async {
    return await _channel.invokeMethod('getDeviceName');
  }

  static Future<double> get screenSizeInches async {
    return await _channel.invokeMethod('getScreenSizeInches');
  }

  static Future<DeviceClassType> get deviceClass async {
    final String deviceClassString = await _channel.invokeMethod('getDeviceClass');
    return DeviceClassType.values.firstWhere((e)=>e.toString().split('.')[1].toUpperCase() == deviceClassString.toUpperCase());
  }
}
