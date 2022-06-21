import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tasky/app/core/utils/extensions.dart';
import 'package:tasky/app/core/values/colors.dart';
import 'package:tasky/app/modules/details/widgets/doing_list.dart';
import 'package:tasky/app/modules/details/widgets/done_list.dart';
import 'package:tasky/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';

class DetailsPage extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeController.task.value!;
    var color = HexColor.fromHex(task.color);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeController.formKey,
          child: ListView(children: [
            Padding(
              padding: EdgeInsets.all(3.0.w),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.editController.clear();
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        size: 12.sp,
                      ),
                      color: Colors.grey)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Icon(IconData(task.icon, fontFamily: 'MaterialIcons'),
                      color: color),
                  SizedBox(width: 3.w),
                  Text(
                    task.title,
                    style:
                        TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 3.w, right: 16.w),
              child: Obx(
                () {
                  var totalTodos = homeController.doingTodos.length +
                      homeController.doneTodos.length;
                  return Row(
                    children: [
                      Text(
                        '$totalTodos Task(s)',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Expanded(
                        child: StepProgressIndicator(
                          totalSteps: totalTodos == 0 ? 1 : totalTodos,
                          currentStep: homeController.doneTodos.length,
                          size: 5,
                          padding: 0,
                          selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [color.withOpacity(0.5), color]),
                          unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey[300]!.withOpacity(0.5),
                                Colors.grey[300]!
                              ]),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
              child: TextFormField(
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400]!,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          var success = homeController
                              .addTodo(homeController.editController.text);
                          if (success) {
                            EasyLoading.showSuccess(
                                'Todo item added sucessfully');
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          homeController.editController.clear();
                        }
                      },
                      icon: const Icon(Icons.done, color: blue),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[400]!))),
                controller: homeController.editController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList()
          ]),
        ),
      ),
    );
  }
}
