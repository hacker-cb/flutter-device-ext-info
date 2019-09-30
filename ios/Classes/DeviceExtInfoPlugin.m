#import "DeviceExtInfoPlugin.h"

@implementation DeviceExtInfoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"device_ext_info"
            binaryMessenger:[registrar messenger]];
  DeviceExtInfoPlugin* instance = [[DeviceExtInfoPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getDeviceName" isEqualToString:call.method])
  {
    result([[UIDevice currentDevice] name]);
  }
  else if ([@"getScreenSizeInches" isEqualToString:call.method])
  {
      float scale = [[UIScreen mainScreen] scale];

      float ppi = scale * ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 132 : 163);

      float width = ([[UIScreen mainScreen] bounds].size.width * scale);
      float height = ([[UIScreen mainScreen] bounds].size.height * scale);

      float horizontal = width / ppi, vertical = height / ppi;

      float diagonal = sqrt(pow(horizontal, 2) + pow(vertical, 2));

      result(@(diagonal));
  }
  else if ([@"getDeviceClass" isEqualToString:call.method])
  {
      UIUserInterfaceIdiom userInterfaceIdiom = [UIDevice currentDevice].userInterfaceIdiom;
      if ( userInterfaceIdiom == UIUserInterfaceIdiomPad ) {
          result(@"tablet");
      }
      else if ( userInterfaceIdiom == UIUserInterfaceIdiomPhone ) {
          result(@"phone");
      }
      else if (@available(iOS 9.0, *)) {
          if ( userInterfaceIdiom == UIUserInterfaceIdiomTV ) {
              result(@"stb");
          }
          else {
              @throw [NSException exceptionWithName:@"Exception on getDeviceClass"
                                             reason:@"Cannot detect device class"
                                           userInfo:nil];
          }
      } else {
          // Fallback on earlier versions
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
