import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
   static Future<bool> storagePermissionsGranted() async {
    PermissionStatus storagePermissionStatus = await getStoragePermission();

    if (storagePermissionStatus == PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          storagePermissionStatus);
      return false;
    }
  }

  static Future<PermissionStatus> getStoragePermission() async {
 
    final status = await Permission.storage.request();
 
    if (status == PermissionStatus.granted) {
      debugPrint('Permission Granted');
    } else if (status == PermissionStatus.denied) {
      debugPrint('Permission denied');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Permission Permanently Denied');
      await openAppSettings();
    }

    return status;
  }

  static void _handleInvalidPermissions(
    [PermissionStatus? cameraPermissionStatus,
    PermissionStatus? microphonePermissionStatus,]
  ) {
    if (cameraPermissionStatus == PermissionStatus.denied &&
        microphonePermissionStatus == PermissionStatus.denied) {
      throw  PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied &&
        microphonePermissionStatus == PermissionStatus.permanentlyDenied) {
      throw  PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
  
}