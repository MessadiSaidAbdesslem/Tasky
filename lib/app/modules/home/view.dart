import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/values/colors.dart';
import 'package:task_app/app/data/models/task.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';
import 'package:task_app/app/modules/home/widgets/add_card.dart';
import 'package:task_app/app/modules/home/widgets/add_dialog.dart';
import 'package:task_app/app/modules/home/widgets/task_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Text(
              'My List',
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Obx(
            () => GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.tasks
                    .map((task) => LongPressDraggable<Task>(
                        data: task,
                        onDragEnd: (_) => controller.changeDeleting(false),
                        onDraggableCanceled: (_, __) =>
                            controller.changeDeleting(false),
                        onDragStarted: () => controller.changeDeleting(true),
                        feedback:
                            Opacity(opacity: 0.8, child: TaskCard(task: task)),
                        child: TaskCard(task: task)))
                    .toList(),
                AddCard()
              ],
            ),
          )
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted successfully');
        },
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
                onPressed: () =>
                    Get.to(() => AddDialog(), transition: Transition.downToUp),
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                child: Obx(
                  () => Icon(controller.deleting.value == true
                      ? Icons.delete
                      : Icons.add),
                )),
          );
        },
      ),
    );
  }
}
