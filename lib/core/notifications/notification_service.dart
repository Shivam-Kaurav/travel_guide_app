abstract class NotificationService {
  //Initialize notification services(FCM+local)
  Future<void> init();

  //show a local notification
  Future<void> show({required String title, required String body});
}
