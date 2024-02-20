import 'package:device_imei/device_imei.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_get_device_info/components/TextItem.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mac_address/mac_address.dart';

class DeviceInfoScreen extends StatefulWidget {
  const DeviceInfoScreen({super.key});

  @override
  State<DeviceInfoScreen> createState() => _DeviceInfoScreenState();
}

class _DeviceInfoScreenState extends State<DeviceInfoScreen> {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> deviceData = <String, dynamic>{};
  String message = "Please allow permission request!";
  DeviceInfo? deviceInfo;
  bool getPermission = false;
  String? deviceImei;
  String macAddress = 'Unknown';
  final _deviceImeiPlugin = DeviceImei();

 //Get android device info
  Future<void> _getDeviceInfo () async {
    try{
    final result  = _readAndroidBuildData(await _deviceInfoPlugin.androidInfo);
    setState(() {
      deviceData=result;
    });
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'board': build.board ,
      'brand': build.brand ,
      'device': build.device ,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware ,
      'id': build.id ,
      'model': build.model ,
      'product': build.product ,
    };
  }

  //Handle permission to get device IMEI
  _getImei() async {
    try{
    var permission = await Permission.phone.status;
      if (permission.isGranted) {
        String? imei = await _deviceImeiPlugin.getDeviceImei();
        if (imei != null) {
          setState(() {
            getPermission = true;
            deviceImei = imei;
          });
        }
      } else {
        PermissionStatus status = await Permission.phone.request();
        if (status == PermissionStatus.granted) {
          setState(() {
            getPermission = false;
          });
          _getImei();
        } else {
          setState(() {
            getPermission = false;
            message = "Permission not granted, please allow permission";
          });
        }
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  //Get MAC Address
  _getMacAddress() async {
    try{
      String mac = await GetMac.macAddress;
      setState(() {
        macAddress = mac;
      });
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  //Error dialog
  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
    _getImei();
    _getMacAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Android device Info"),
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...deviceData.entries.map((entry) => TextItem(label: entry.key, value: entry.value.toString())).toList(),
          getPermission ? TextItem(label: "Imei", value: deviceImei ?? "") : Text(message),
          TextItem(label: "MAC address", value: macAddress),

        ],
      ),
      ),
    );
  }
}
