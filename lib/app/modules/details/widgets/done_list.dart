import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_app/app/core/values/colors.dart';
import 'package:task_app/app/modules/home/controller.dart';
import 'package:sizer/sizer.dart';

class DoneList extends StatelessWidget {
  final homeController = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeController.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.w, horizontal: 5.w),
                child: Text(
                  'Completed (${homeController.doneTodos.length})',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              ...homeController.doneTodos
                  .map((element) => Dismissible(
                        onDismissed: (_) {
                          homeController.deleteDoneTodo(element);
                        },
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.w),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.w, horizontal: 9.w),
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 20,
                                height: 20,
                                child: Icon(Icons.done, color: blue),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.w),
                                child: Text(
                                  element['title'],
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList()
            ],
          )
        : Container());
  }
}
