import 'dart:typed_data';

// model class for getting details of apps which is already installed
class DeviceApp {
  final Uint8List icon;
  final bool isInstalled;

  DeviceApp(this.icon, this.isInstalled);
}
