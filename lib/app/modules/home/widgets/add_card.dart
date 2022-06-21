import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:tasky/app/core/utils/extensions.dart';
import 'package:tasky/app/core/values/colors.dart';
import 'package:tasky/app/data/models/task.dart';
import 'package:tasky/app/modules/home/controller.dart';
import 'package:tasky/app/widgets/icons.dart';
import 'package:sizer/sizer.dart';

class AddCard extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  AddCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.w;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.w),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
              titlePadding: EdgeInsets.symmetric(vertical: 5.0.w),
              radius: 5,
              title: 'Task Type',
              content: Form(
                key: homeController.formKey,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                      controller: homeController.editController,
                      decoration: const InputDecoration(
                          floatingLabelStyle: TextStyle(
                              color: blue, fontWeight: FontWeight.bold),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: blue, width: 2)),
                          border: OutlineInputBorder(),
                          labelText: 'Title'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.w),
                    child: Wrap(
                      spacing: 2.0.w,
                      children: icons
                          .map((e) => Obx(() {
                                final index = icons.indexOf(e);
                                return ChoiceChip(
                                  selectedColor: Colors.grey[200],
                                  pressElevation: 0,
                                  backgroundColor: Colors.white,
                                  label: e,
                                  selected:
                                      index == homeController.chipIndex.value,
                                  onSelected: (selected) {
                                    homeController.chipIndex.value =
                                        selected ? index : 0;
                                  },
                                );
                              }))
                          .toList(),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 40)),
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          int icon = icons[homeController.chipIndex.value]
                              .icon!
                              .codePoint;
                          String color = icons[homeController.chipIndex.value]
                              .color!
                              .toHex();
                          var task = Task(
                              title: homeController.editController.text,
                              color: color,
                              icon: icon);
                          Get.back();
                          homeController.addTask(task)
                              ? EasyLoading.showSuccess('Create success')
                              : EasyLoading.showError('Duplicated Task');
                        }
                      },
                      child: const Text('Confirm'))
                ]),
              ));
          homeController.editController.clear();
          homeController.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(Icons.add, size: 10.w, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
