package me.sokolov.device_ext_info;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.os.Build;
import android.provider.Settings;
import android.util.DisplayMetrics;
import android.view.Display;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** DeviceExtInfoPlugin */
public class DeviceExtInfoPlugin implements MethodCallHandler {
  private final Context context;

  public DeviceExtInfoPlugin(Context context) {
    this.context = context;
  }

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "device_ext_info");
    channel.setMethodCallHandler(new DeviceExtInfoPlugin(registrar.activity()));
  }


  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getDeviceName")) {
      String deviceName = Settings.Secure.getString(context.getContentResolver(), "bluetooth_name");
      result.success(deviceName);
    }
    else if (call.method.equals("getScreenSizeInches")) {
      double screenSize = getScreenSizeInches();
      result.success(screenSize);
    }
    else if (call.method.equals("getDeviceClass"))
    {
      String deviceClass = getDeviceClass();
      result.success(deviceClass);
    } else {
      result.notImplemented();
    }
  }

  private double getScreenSizeInches(){
    Display display = ((Activity) context).getWindowManager().getDefaultDisplay();
    DisplayMetrics metrics = new DisplayMetrics();
    display.getMetrics(metrics);

    float widthInches = metrics.widthPixels / metrics.xdpi;
    float heightInches = metrics.heightPixels / metrics.ydpi;
    double diagonalInches = Math.sqrt(Math.pow(widthInches, 2) + Math.pow(heightInches, 2));

    return  diagonalInches;
  }

  private  String getDeviceClass(){

    //https://stackoverflow.com/questions/27657850/how-to-check-the-device-is-tablet-mobile-or-android-tv-in-android

    if (checkIsTelevision()) return "tv";

    double diagonalInches = getScreenSizeInches();

    return diagonalInches >= 7.0 ? "tablet" : "phone";
  }

  /**
   * Checks if the device is Android TV.
   */
  @TargetApi(Build.VERSION_CODES.HONEYCOMB_MR2)
  private boolean checkIsTelevision() {
    int uiMode = context.getResources().getConfiguration().uiMode;
    return (uiMode & Configuration.UI_MODE_TYPE_MASK) == Configuration.UI_MODE_TYPE_TELEVISION;
  }
}
