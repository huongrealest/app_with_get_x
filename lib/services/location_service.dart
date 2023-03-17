import 'dart:developer';

import 'package:app_with_getx/widgets/dialogs/open_setting_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationService extends GetxService with WidgetsBindingObserver {
  bool _openedSetting = false;

  bool _shouldToShowDialog = true;

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    super.onInit();
  }

  checkServiceAndPermission() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (serviceEnabled == false) {
      Get.dialog(
        OpenSettingDialog(
          title:
              'Location services are disabled. Please enable to using my service.',
          onAffirmativeBtnPressed: () {
            Get.back(); // Close dialog after open setting
            _openedSetting = true;
            Geolocator.openLocationSettings();
          },
        ),
      );
      return;
    }
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      final permissionAfterRequest = await Geolocator.requestPermission();
      if (permissionAfterRequest == LocationPermission.denied) {
        return;
      } else if (permissionAfterRequest == LocationPermission.deniedForever) {
        if (_shouldToShowDialog == false) return;
        _shouldToShowDialog = false;
        Get.dialog(
          OpenSettingDialog(
            title:
                'Location permissions are denied. Please enable to using my service.',
            onAffirmativeBtnPressed: () {
              Get.back(); // Close dialog after open setting
              _openedSetting = true;
              Geolocator.openAppSettings();
            },
          ),
        );
        return;
      }
    }
    _getPosition();
  }

  _getPosition() async {
    final result = await Geolocator.getCurrentPosition();
    _log(result.toString());
  }

  _log(String value) => log(value, name: 'LocationService');

  _onResume() {
    if (_openedSetting) {
      _openedSetting = false;
      checkServiceAndPermission();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        _onResume();
        break;
      default:
    }
  }
}
