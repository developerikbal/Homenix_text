import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// DeviceChecker class
/// Responsible for collecting device info for user verification,
/// fraud detection, and premium control logic.

class DeviceChecker {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  /// Returns a unique identifier for the device
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return androidInfo.id?.toString() ??
               androidInfo.androidId?.toString() ??
               "unknown_android_device";
      } else if (Platform.isWindows) {
        return "windows_${Platform.localHostname}";
      } else {
        return "unsupported_platform";
      }
    } catch (e) {
      return "device_id_error";
    }
  }

  /// Returns the device model like "Realme RMX2027"
  static Future<String> getDeviceModel() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        return "${androidInfo.manufacturer} ${androidInfo.model}";
      } else if (Platform.isWindows) {
        return "Windows PC (${Platform.localHostname})";
      } else {
        return "Unknown Device";
      }
    } catch (e) {
      return "model_error";
    }
  }

  /// Returns the app version like "1.0.0 (1)"
  static Future<String> getAppVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      return "${info.version} (${info.buildNumber})";
    } catch (e) {
      return "version_unknown";
    }
  }

  /// Save first install time once (used for fraud prevention)
  static Future<void> saveFirstInstallTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey("first_install_time")) {
        prefs.setString("first_install_time", DateTime.now().toIso8601String());
      }
    } catch (_) {
      // Do nothing on failure
    }
  }

  /// Retrieve saved first install time
  static Future<String?> getFirstInstallTime() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString("first_install_time");
    } catch (_) {
      return null;
    }
  }

  /// Check if device was previously registered to block fake trials
  static Future<bool> isDeviceRegisteredBefore() async {
    final installTime = await getFirstInstallTime();
    return installTime != null;
  }
}