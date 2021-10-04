import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/screens/input_screen/note_input/updateNote.dart';
import 'package:secret_keeper/Widgets/customTextField.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class ShowNotesData extends StatefulWidget {
  final Note itemNote;

  const ShowNotesData({Key key, this.itemNote}) : super(key: key);

  @override
  _ShowNotesDataState createState() => _ShowNotesDataState();
}

class _ShowNotesDataState extends State<ShowNotesData> {
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
      controller: titleController,
      textInputType: null,
      textCapitalization: null,
      label: "Title of note",
      readOnly: true,
      textInputAction: null,
    );
  }

  Widget note() {
    return CustomNoteField(
      controller: notesController,
      label: "Note",
      readOnly: true,
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
            title: Text("Notes"),
            actions: [
              PopupMenuButton<String>(
                onSelected: (String value) {
                  setState(() {
                    final itemNote = widget.itemNote;
                    _handleClick(value, itemNote);
                  });
                },
                itemBuilder: (context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'Edit',
                    child: Container(
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'Delete',
                    child: Container(
                      child: Text(
                        "Delete",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(),
              child: Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
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
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleClick(String value, itemNote) {
    switch (value) {
      case 'Edit':
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (_) => UpdateNote(
                  itemNote: itemNote,
                )
            )
        );
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
      case 'Delete':
        final dao = Provider.of<NoteDao>(context);
        dao.deleteNote(itemNote);
        Navigator.of(context).pop();
        getIt<AutoLock>().syncValueStreamController.sink.add(null);
        break;
    }
  }

}
