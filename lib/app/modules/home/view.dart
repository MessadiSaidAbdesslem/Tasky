import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tasky/app/core/values/colors.dart';
import 'package:tasky/app/data/models/task.dart';
import 'package:tasky/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';
import 'package:tasky/app/modules/home/widgets/add_card.dart';
import 'package:tasky/app/modules/home/widgets/add_dialog.dart';
import 'package:tasky/app/modules/home/widgets/task_card.dart';
import 'package:tasky/app/modules/report/view.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(index: controller.tabIndex.value, children: [
          SafeArea(
              child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Text(
                  'My List',
                  style:
                      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
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
                            onDragStarted: () =>
                                controller.changeDeleting(true),
                            feedback: Opacity(
                                opacity: 0.8, child: TaskCard(task: task)),
                            child: TaskCard(task: task)))
                        .toList(),
                    AddCard()
                  ],
                ),
              )
            ],
          )),
          ReportPage()
        ]),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: DragTarget<Task>(
        onAccept: (task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess('Deleted successfully');
        },
        builder: (_, __, ___) {
          return Obx(
            () => FloatingActionButton(
                onPressed: () {
                  if (controller.tasks.isNotEmpty) {
                    Get.to(() => AddDialog(), transition: Transition.downToUp);
                  } else {
                    EasyLoading.showInfo('Please create a task first');
                  }
                },
                backgroundColor: controller.deleting.value ? Colors.red : blue,
                child: Obx(
                  () => Icon(controller.deleting.value == true
                      ? Icons.delete
                      : Icons.add),
                )),
          );
        },
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: Obx(
          () => BottomNavigationBar(
            selectedItemColor: blue,
            onTap: (index) {
              controller.changeTabIndex(index);
            },
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                  label: 'Home',
                  icon: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: const Icon(Icons.apps),
                  )),
              BottomNavigationBarItem(
                  label: 'Report',
                  icon: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: const Icon(Icons.data_usage),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
