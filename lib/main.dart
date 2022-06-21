import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:task_app/app/data/services/storage/services.dart';
import 'package:task_app/app/modules/home/binding.dart';
import 'package:task_app/app/modules/home/view.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo List Using GetX',
        home: const HomePage(),
        initialBinding: HomeBinding(),
        theme: ThemeData(scaffoldBackgroundColor: Colors.white),
        builder: EasyLoading.init(),
      ),
    );
  }
}
