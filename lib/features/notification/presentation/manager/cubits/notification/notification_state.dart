sealed class NotificationState {
  const NotificationState();
}

class NotificationInitial extends NotificationState {
  const NotificationInitial();
}

class NotificationLoading extends NotificationState {
  const NotificationLoading();
}

class NotificationSuccess extends NotificationState {
  const NotificationSuccess();
}

class NotificationFailure extends NotificationState {
  final String message;
  const NotificationFailure({required this.message});
}
