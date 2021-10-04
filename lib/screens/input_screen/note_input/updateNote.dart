import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moor_flutter/moor_flutter.dart' hide Column;
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/home_screen/Home.dart';
import 'package:intl/intl.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class UpdateNote extends StatefulWidget {
  final Note itemNote;

  const UpdateNote({Key key, this.itemNote}) : super(key: key);
  @override
  _UpdateNoteState createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final itemNote = widget.itemNote;
    titleController = TextEditingController(text: itemNote.title);
    notesController = TextEditingController(text: itemNote.notes);
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  Widget title() {
    return CustomTextField(
      readOnly: false,
      controller: titleController,
      textInputType: TextInputType.text,
      textCapitalization: TextCapitalization.words,
      label: "Title of note",
      validator: (title) {
        if (title.isEmpty || title == null)
          return 'Title required!';
        else
          return null;
      },
      textInputAction: TextInputAction.next,
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
                onPressed: updateDataToMoor,
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

  void updateDataToMoor() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      final DateTime now = DateTime.now();
      String currentDate = DateFormat('yyyy-MM-dd').format(now);
      String currentTime = DateFormat.jm().format(DateTime.now());

      setState(() {
        final noteDao = Provider.of<NoteDao>(context);
        final itemNote = widget.itemNote;
        final note = NotesCompanion(
          id: Value(itemNote.id),
          title: Value(titleController.text),
          notes: Value(notesController.text),
          date: Value(currentDate),
          time: Value(currentTime),
        );
        noteDao.updateNote(note);
      });
      int count = 0;
      Navigator.popUntil(context, (route) {
        return count++ == 2;
      });
    }
  }
}
