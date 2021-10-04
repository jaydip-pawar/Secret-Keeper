import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';
import 'package:secret_keeper/Widgets/customPopupMenu.dart';
import 'package:secret_keeper/Widgets/customTitleBar.dart';
import 'package:secret_keeper/screens/home_screen/search/cusNoteSearch.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class NotesNavigation extends StatefulWidget {
  final User user;

  const NotesNavigation({Key key, this.user}) : super(key: key);
  @override
  _NotesNavigationState createState() => _NotesNavigationState();
}

class _NotesNavigationState extends State<NotesNavigation> {

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Listener(
          onPointerDown: restartTimer,
          onPointerMove: restartTimer,
          onPointerUp: restartTimer,
          behavior: HitTestBehavior.translucent,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: cusTitleBar(),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: CustomNoteDelegate(),
                    );
                  },
                ),
                CustomPopupMenu()
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildNoteList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Note>> _buildNoteList(BuildContext context) {
    final dao = Provider.of<NoteDao>(context);
    return StreamBuilder(
      stream: dao.watchAllNotes(),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        final notes = snapshot.data ?? List();
        return BuildListNote(notes: notes);
      },
    );
  }
}
