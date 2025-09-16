import 'dart:io';

class NotificationEntity {
  final String descriptioninEnglish;
  String? imageUrl;
  final File image;
  final String descriptionInArabic;
  final String code;

  final DateTime date;

  NotificationEntity({
    required this.code,

    required this.image,
    required this.descriptioninEnglish,
    required this.descriptionInArabic,
    this.imageUrl,
    required this.date,
  });
}
