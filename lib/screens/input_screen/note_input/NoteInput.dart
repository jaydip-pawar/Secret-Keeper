import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:intl/intl.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class NoteInput extends StatefulWidget {
  @override
  _NoteInputState createState() => _NoteInputState();
}

class _NoteInputState extends State<NoteInput> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  Widget title() {
    return CustomTextField(
      readOnly: false,
      controller: titleController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Title of note",
      textInputAction: TextInputAction.next,
      validator: (title) {
        if (title.isEmpty || title == null)
          return 'Title required!';
        else
          return null;
      },
    );
  }

  Widget note() {
    return CustomNoteField(
      controller: notesController,
      label: "Notes",
      readOnly: false,
      validator: (note) {
        if (note.isEmpty || note == null)
          return 'Note required!';
        else
          return null;
      },
    );
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Listener(
        onPointerDown: restartTimer,
        onPointerMove: restartTimer,
        onPointerUp: restartTimer,
        behavior: HitTestBehavior.translucent,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              new IconButton(
                icon: Icon(Icons.check),
                onPressed: addDataToMoor,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      title(),
                      SizedBox(
                        height: 15,
                      ),
                      note(),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addDataToMoor() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      final DateTime now = DateTime.now();
      String currentDate = DateFormat('yyyy-MM-dd').format(now);
      String currentTime = DateFormat.jm().format(DateTime.now());
      setState(() {
        final noteDao = Provider.of<NoteDao>(context);
        final note = NotesCompanion(
          title: Value(titleController.text),
          notes: Value(notesController.text),
          date: Value(currentDate),
          time: Value(currentTime),
        );
        noteDao.insertNote(note);
      });
      Navigator.pop(context);
    }
  }
}
