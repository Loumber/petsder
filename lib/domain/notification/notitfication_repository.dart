import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:petsder/common/utils/logger/logger.dart';

class NotificationRepository {
  final _firebaseMessaging = FirebaseMessaging.instance;

  late final String? fCMToken;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    fCMToken = await _firebaseMessaging.getToken();

    if(fCMToken != null) AppLogger.info(fCMToken!);
  }

  void handleMessage(RemoteMessage? message){
    if(message == null) return;


  }

  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  }

}