import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:device_ext_info/device_ext_info.dart';

void main() {
  const MethodChannel channel = MethodChannel('device_ext_info');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      switch(methodCall.method){
        case 'getDeviceName':
          return "Test device";
          break;
        case 'getScreenSizeInches':
          return 10.4;
          break;
        case 'getDeviceClass':
          return "phone";
          break;
      }
      throw ArgumentError("Unknown method: ${methodCall.method}");
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getDeviceName', () async {
    expect(await DeviceExtInfo.deviceName, "Test device");
  });
  test('getScreenSizeInches', () async {
    expect(await DeviceExtInfo.screenSizeInches, 10.4);
  });
  test('getDeviceClass', () async {
    expect(await DeviceExtInfo.deviceClass, DeviceClassType.Phone);
  });


}
