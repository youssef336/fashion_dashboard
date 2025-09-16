import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/notification_entity.dart';

abstract class NotificationRepo {
  Future<Either<Failure, void>> addNotification({
    required NotificationEntity notificationEntity,
  });
}
