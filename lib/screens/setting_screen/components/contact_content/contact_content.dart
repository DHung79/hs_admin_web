import 'package:flutter/material.dart';
import 'components/contact_info.dart';
import 'components/edit_contact.dart';
import '/core/contact/contact.dart';

class ContactContent extends StatefulWidget {
  final String route;
  final bool isEdit;
  const ContactContent({
    Key? key,
    required this.route,
    this.isEdit = false,
  }) : super(key: key);

  @override
  State<ContactContent> createState() => _ContactContentState();
}

class _ContactContentState extends State<ContactContent> {
  final listContactInfo = ListContactInfo.fromJson({
    "data": [
      {
        "contacts": [
          {"name": "Hotline 1", "description": "0868963156"},
          {"name": "Hotline 1", "description": "0868223156"},
          {"name": "Email", "description": "admin@gmail.com"},
          {
            "name": "Địa chỉ",
            "description": "358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa"
          }
        ]
      },
      {
        "contacts": [
          {"name": "Hotline 1", "description": "0868963156"},
          {"name": "Hotline 1", "description": "0868223156"},
          {"name": "Email", "description": "admin@gmail.com"},
          {
            "name": "Địa chỉ",
            "description": "358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa"
          }
        ]
      }
    ]
  });
  @override
  Widget build(BuildContext context) {
    return widget.isEdit
        ? ContactInfo(
            route: widget.route,
            listContactInfo: listContactInfo.data,
          )
        : EditContact(
            route: widget.route,
            listContactInfo: listContactInfo.data,
          );
  }
}
