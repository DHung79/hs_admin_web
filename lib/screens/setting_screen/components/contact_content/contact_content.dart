import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../../widgets/joytech_components/joytech_components.dart';
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
  final _contactBloc = ContactBloc();
  @override
  void initState() {
    _contactBloc.fetchAllData({});
    super.initState();
  }

  @override
  void dispose() {
    _contactBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _contactBloc.allData,
        builder:
            (context, AsyncSnapshot<ApiResponse<ListContactInfo?>> snapshot) {
          if (snapshot.hasData) {
            final contactInfo = snapshot.data!.model!.data.first;

            return widget.isEdit
                ? ContactInfo(
                    route: widget.route,
                    contactInfo: contactInfo,
                  )
                : EditContact(
                    contactBloc: _contactBloc,
                    route: widget.route,
                    contactInfo: contactInfo,
                  );
          }
          return const JTIndicator();
        });
  }
}
