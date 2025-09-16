import 'package:dartz/dartz.dart';
import 'package:fashion_dashboard/core/services/main/database_service.dart';
import 'package:fashion_dashboard/core/utils/backendpoints.dart';
import 'package:fashion_dashboard/features/notification/data/models/notification_model.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final DatabaseService databaseServies;
  NotificationRepoImpl(this.databaseServies);

  @override
  Future<Either<Failure, void>> addNotification({
    required NotificationEntity notificationEntity,
  }) async {
    try {
      var orderModel = NotificationModel.fromEntity(notificationEntity);
      await databaseServies.addData(
        path: BackEndEndpoints.addNotification,
        data: orderModel.toJson(),
        documentId: orderModel.notificationId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
