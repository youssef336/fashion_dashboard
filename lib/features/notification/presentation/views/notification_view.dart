import 'package:fashion_dashboard/core/repo/add_image/add_image_repo.dart';
import 'package:fashion_dashboard/core/services/get_it_service.dart';
import 'package:fashion_dashboard/features/notification/domain/repo/notification_repo.dart';
import 'package:fashion_dashboard/features/notification/presentation/manager/cubits/notification/notification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/notification_view_body.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});
  static const String routeName = '/notification';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationCubit(
        getIt.get<AddImageRepo>(),
        getIt.get<NotificationRepo>(),
      ),
      child: Scaffold(
        appBar: AppBar(title: const Text('Notification')),
        body: const NotificationViewBody(),
      ),
    );
  }
}

class NotificationImageRepo {}
