import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  VoidCallback isDenied;
  VoidCallback isUndetermined;
  VoidCallback isGranted;
  VoidCallback isRestricted;
  VoidCallback isPermanentlyDenied;

  PermissionHelper(
      {@required this.isDenied,
      @required this.isUndetermined,
      @required this.isGranted,
      @required this.isRestricted,
      @required this.isPermanentlyDenied});

  /// This method will call to set call back of methods.
  setStoragePermissionCallBack() async {
    if (Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      _getStatus(statuses[Permission.storage]);
    } else {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
      ].request();
      _getStatus(statuses[Permission.photos]);
    }
  }

  /// this method will set callback status.
  _getStatus(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.denied:
        {
          isDenied();
          break;
        }
      case PermissionStatus.granted:
        {
          isGranted();
          break;
        }
      case PermissionStatus.undetermined:
        {
          isUndetermined();
          break;
        }
      case PermissionStatus.permanentlyDenied:
        {
          isPermanentlyDenied();
          break;
        }
      case PermissionStatus.restricted:
        {
          isRestricted();
          break;
        }
      case PermissionStatus.limited:
        break;
    }
  }
}
