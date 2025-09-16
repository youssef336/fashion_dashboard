import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/features/notification/domain/entities/notification_entity.dart';
import 'package:fashion_dashboard/features/notification/domain/repo/notification_repo.dart';
import 'package:fashion_dashboard/features/notification/presentation/manager/cubits/notification/notification_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit(this.imageRepo, this.notificationRepo)
    : super(const NotificationInitial());
  final AddImageRepo imageRepo;
  final NotificationRepo notificationRepo;

  Future<void> addNotification(
    NotificationEntity addNotificationInputEntity,
  ) async {
    emit((const NotificationLoading()));
    var result = await imageRepo.addImage(addNotificationInputEntity.image);
    result.fold(
      (failure) => emit(NotificationFailure(message: failure.message)),
      (url) async {
        addNotificationInputEntity.imageUrl = url;
        var result = await notificationRepo.addNotification(
          notificationEntity: addNotificationInputEntity,
        );
        result.fold(
          (failure) => emit(NotificationFailure(message: failure.message)),
          (r) {
            emit(const NotificationSuccess());
          },
        );
      },
    );
  }
}
