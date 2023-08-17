import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wiseki/database/database_helper.dart';
import 'package:wiseki/model/note.dart';
import 'package:wiseki/provider/home_provider.dart';
import 'package:wiseki/utils/app_assets.dart';


class AddNote extends ConsumerStatefulWidget {
  static const routeName = '/add_farm';

  const AddNote({
    super.key,
  });
  @override
  ConsumerState<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final GlobalKey<FormState> _addNoteFormKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Notes"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(Assets.saveIcon),
          )
        ],
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Enter note title',
            ),
            // style: TextStyle(
            //     fontSize: 14.sp,
            //     letterSpacing: -0.02.sp,
            //     color: Colors.black,
            //     height: 22.sp),
            validator: (text) {
              if (!(text!.length > 5) && text.isNotEmpty) {
                return "Enter valid name of more then 5 characters!";
              }
              return null;
            },
          ),
          TextFormField(
            maxLines: null,
            controller: _descriptionController,
            decoration: const InputDecoration(
              
              hintText: 'DESCRIPTION',
            ),
            validator: (text) {
              if (!(text!.length > 5) && text.isNotEmpty) {
                return "Enter valid name of more then 5 characters!";
              }
              return null;
            },
            // style: TextStyle(
            //     fontSize: 14.sp,
            //     letterSpacing: -0.02.sp,
            //     color: Colors.black,
            //     height: 22.sp),
          ),
          // PopupMenuButton(
          //   itemBuilder: (BuildContext context) {
          //     return [
          //       PopupMenuItem<String>(
          //         value: 'option1',
          //         child: Text('Option 1'),
          //       ),
          //       PopupMenuItem<String>(
          //         value: 'option2',
          //         child: Text('Option 2'),
          //       ),
          //     ];
          //   },
          // ),
          ElevatedButton(
            onPressed: () {
              if (_addNoteFormKey.currentState!.validate()) {
                ref.read(homeStateProvider.notifier).addNotes(Notes(
                    title: _titleController.text,
                    description: _descriptionController.text));
              }
              Navigator.pop(context);
            },
            child: Text('ADD NOTE'),
          )
        ],
      ),
    );
  }
}
