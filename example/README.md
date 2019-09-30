# DeviceExtInfo 

Extended device info flutter plugin


##Usage:

```dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:device_ext_info/device_ext_info.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String deviceName;
  double screenSizeInches;
  DeviceClassType deviceClass;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final deviceName =  await DeviceExtInfo.deviceName;
    final deviceClass =  await DeviceExtInfo.deviceClass;
    final screenSizeInches =  await DeviceExtInfo.screenSizeInches;


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      this.deviceName = deviceName;
      this.deviceClass = deviceClass;
      this.screenSizeInches = screenSizeInches;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Device name:: $deviceName \n'),
              Text('Device class: $deviceClass\n'),
              Text('Screen size: $screenSizeInches\n')
            ],
          )
        ),
      ),
    );
  }
}

```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Hacker-CB/flutter-device-ext-info/issues



