import 'dart:io';

import 'package:fashion_dashboard/features/notification/domain/entities/notification_entity.dart';
import 'package:uuid/uuid.dart';

class NotificationModel {
  final String descriptioninEnglish;
  final File image;
  final String imageUrl;
  final DateTime date;
  final String descriptioninArabic;
  final String notificationId;
  final String code;

  NotificationModel({
    required this.code,

    required this.notificationId,
    required this.descriptioninEnglish,
    required this.descriptioninArabic,
    required this.imageUrl,

    required this.image,
    required this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': code,

      'notificationId': notificationId,
      'descriptionEnglish': descriptioninEnglish,
      'descriptionArabic': descriptioninArabic,
      'image': imageUrl,
      'date': date,
    };
  }

  factory NotificationModel.fromEntity(NotificationEntity notificationEntity) {
    return NotificationModel(
      code: notificationEntity.code,

      notificationId: const Uuid().v4(),
      descriptioninArabic: notificationEntity.descriptionInArabic,
      imageUrl: notificationEntity.imageUrl ?? '',
      descriptioninEnglish: notificationEntity.descriptioninEnglish,

      image: notificationEntity.image,
      date: notificationEntity.date,
    );
  }
}
