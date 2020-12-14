import 'package:flutter/material.dart';

class CategoryDataSource {
  List<String> categoryName = [
    "Student Details",
    "Parent Profile",
    "Online Classes",
    "Attendace",
    "Homework",
    "Circular",
    "Diary Notes",
    "Assignment",
    "Live Class",
    // "Notice",
    // "Newsletter",
    "Gallery",
    "Fees Invoice",
    "Report Card",
    "Bus Details",
    "Change Password",
    "Customer Care",
    "Contact Us"
  ];
  List<IconData> iconSrc = [
    Icons.account_circle,
    Icons.group,
    Icons.computer_outlined,
    Icons.view_list,
    Icons.edit,
    Icons.pageview,
    Icons.note,
    Icons.assignment,
    Icons.ondemand_video,
    // Icons.notifications,
    // Icons.line_weight,
    Icons.image,
    Icons.monetization_on,
    Icons.receipt,
    Icons.directions_bus,
    Icons.phonelink_lock,
    Icons.call,
    Icons.contact_phone
  ];

  List<String> categoryNameForTeacher = [
    "Teacher's Profile",
    "Class Attd",
    "Online Classes",
    "Homework",
    "Circular",
    "Diary Notes",
    "Assignment",
    "Add Marks",
    "Live Class",
    // "Live Class"
    "Salary Slip",
    "Time Table",
    "Change Password",
    "Customer Care",
    "Gallery",
    // "Contact Us"
  ];

  List<IconData> iconSrcForTeacher = [
    Icons.account_circle,
    Icons.school,
    Icons.computer_outlined,
    Icons.edit,
    Icons.pageview,
    Icons.note,
    Icons.assignment_ind,
    Icons.my_library_books,
    Icons.ondemand_video,
    Icons.receipt_long_outlined,
    Icons.timelapse,
    Icons.phonelink_lock,
    Icons.call,
    Icons.image,
    // Icons.contact_phone
  ];
}
