import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/utils/extensions.dart';
import 'package:task_app/app/core/values/colors.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';

class AddDialog extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: homeController.formKey,
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.all(3.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                      homeController.editController.clear();
                      homeController.changeTask(null);
                    },
                    icon: const Icon(Icons.close)),
                TextButton(
                    style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    onPressed: () {
                      if (homeController.formKey.currentState!.validate()) {
                        if (homeController.task.value == null) {
                          EasyLoading.showError('Please select a task type');
                        } else {
                          var success = homeController.updateTask(
                              homeController.task.value!,
                              homeController.editController.text);

                          if (success) {
                            EasyLoading.showSuccess(
                                'Todo item added successfully');
                            Get.back();
                            homeController.changeTask(null);
                          } else {
                            EasyLoading.showError('Todo item already exists');
                          }
                          homeController.editController.clear();
                        }
                      }
                    },
                    child: Text(
                      'Done',
                      style: TextStyle(color: blue, fontSize: 14.sp),
                    ))
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Text(
              'New Task',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: TextFormField(
              controller: homeController.editController,
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!))),
              autofocus: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your todo item';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: 5.w, left: 5.w, right: 5.w, bottom: 2.w),
            child: Text(
              'Add to',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),
          ...homeController.tasks
              .map((task) => InkWell(
                    onTap: () => homeController.changeTask(task),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 3.w, horizontal: 5.w),
                      child: Obx(
                        () => Row(
                          children: [
                            Icon(
                              IconData(task.icon, fontFamily: 'MaterialIcons'),
                              color: HexColor.fromHex(task.color),
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              task.title,
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            if (homeController.task.value == task)
                              const Icon(Icons.check, color: blue)
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList()
        ]),
      ),
    );
  }
}
