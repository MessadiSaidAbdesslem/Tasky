import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasky/app/core/values/colors.dart';
import 'package:tasky/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var createdTasks = homeController.getTotalTask();
        var completedTasks = homeController.getTotalDoneTask();
        var liveTasks = createdTasks - completedTasks;
        var percent =
            ((completedTasks / createdTasks) * 100).toStringAsFixed(0);
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Text(
                'My Report',
                style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 4.w),
              child: const Divider(thickness: 2),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 5.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatus(Colors.green, liveTasks, 'Live Tasks'),
                  _buildStatus(
                      Colors.orange, completedTasks, 'Completed Tasks'),
                  _buildStatus(Colors.blue, createdTasks, 'Created Tasks')
                ],
              ),
            ),
            SizedBox(
              height: 8.w,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 70.w,
                height: 70.w,
                child: CircularStepProgressIndicator(
                  padding: 0,
                  width: 150,
                  height: 150,
                  stepSize: 20,
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: completedTasks,
                  // gradientColor: SweepGradient(
                  //     center: Alignment.center,
                  //     transform: const GradientRotation(-pi / 2),
                  //     colors: [green.withOpacity(0.5), green]),
                  selectedColor: green,
                  unselectedColor: Colors.grey[200],
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${createdTasks == 0 ? 0 : percent} %',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                      SizedBox(height: 1.w),
                      Text(
                        'Efficiency',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    ));
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 1.3.w),
          height: 3.w,
          width: 3.w,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 0.5.w, color: color)),
        ),
        SizedBox(width: 3.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
            SizedBox(height: 2.w),
            Text(
              text,
              style: TextStyle(fontSize: 10.sp, color: Colors.grey),
            )
          ],
        )
      ],
    );
  }
}
