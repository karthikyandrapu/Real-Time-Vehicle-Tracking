import 'package:firebase_messaging/firebase_messaging.dart';

class FireBaseApi {
  //create an instance of firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  //function to initialize notificaations
  Future<void> initNotifications() async {
    //request  permission from user

    //fetch the FCM token for this device
    final fCMToken = await _firebaseMessaging.getToken();

    //print the token(normally you would send this to yout server)
    print('Token: $fCMToken');
  }
  //function to handle received messages

  //function to inititalize foreground and background settings
}
