import 'package:flutter/material.dart';

class CategoryDataSource {
  List<String> categoryName = [
    "Student Details",
    "Parent Profile",
    "E-learning",
    "Attendace",
    "Homework",
    "Circular",
    "Diary Notes",
    // "Notice",
    // "Newsletter",
    "Gallery",
    "Fees Invoice",
    "Report Card",
    "Bus Details",
    "Change Password",
    "Customer Care"
  ];
  List<IconData> iconSrc = [
    Icons.account_circle,
    Icons.group,
    Icons.computer_outlined,
    Icons.view_list,
    Icons.edit,
    Icons.pageview,
    Icons.note,
    // Icons.notifications,
    // Icons.line_weight,
    Icons.image,
    Icons.monetization_on,
    Icons.receipt,
    Icons.directions_bus,
    Icons.phonelink_lock,
    Icons.call
  ];

  List<String> categoryNameForTeacher = [
    "Teacher's Profile",
    "Class Attd",
    "E-learning",
    "Homework",
    "Circular",
    "Diary Notes",
    "Add Marks",
    "Salary Slip",
    "Time Table",
    "Change Password",
    "Customer Care",
    "Gallery"

  ];

  List<IconData> iconSrcForTeacher = [
    Icons.account_circle,
    Icons.school,
    Icons.computer_outlined,
    Icons.edit,
    Icons.pageview,
    Icons.note,
    Icons.my_library_books,
    Icons.receipt_long_outlined,
    Icons.timelapse,
      Icons.phonelink_lock,
      Icons.call,
      Icons.image
  ];
}
