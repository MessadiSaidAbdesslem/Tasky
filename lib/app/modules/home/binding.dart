import 'package:get/get.dart';
import 'package:tasky/app/data/providers/task/provider.dart';
import 'package:tasky/app/data/services/storage/repository.dart';
import 'package:tasky/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
