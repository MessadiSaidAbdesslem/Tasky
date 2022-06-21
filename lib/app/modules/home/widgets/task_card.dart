import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasky/app/core/utils/extensions.dart';
import 'package:tasky/app/data/models/task.dart';
import 'package:tasky/app/modules/details/view.dart';
import 'package:tasky/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';

class TaskCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  final Task task;
  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    var squareWidth = Get.width - 12.w;
    return GestureDetector(
      onTap: () {
        homeController.changeTask(task);
        homeController.changeTodos(task.todos ?? []);
        Get.to(() => DetailsPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.w),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey[300]!,
                blurRadius: 7,
                offset: const Offset(0, 7)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps:
                  homeController.isTodosEmpty(task) ? 1 : task.todos!.length,
              currentStep: homeController.isTodosEmpty(task)
                  ? 0
                  : homeController.getDoneTodoCount(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withOpacity(0.5), Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.w),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.sp),
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 2.0.w),
                  Text(
                    '${task.todos?.length ?? 0} Task(s)',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
