import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissions() async {
  var status = await Permission.activityRecognition.status;

  if (!status.isGranted) {
    // Request permission
    status = await Permission.activityRecognition.request();
    
    if (status.isGranted) {
      print("Permission granted!");
      // Proceed with step detection
    } else if (status.isDenied) {
      print("Permission denied");
    } else if (status.isPermanentlyDenied) {
      openAppSettings(); // Open settings for the user
    }
  }
}