import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';

class CustomNoteDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final dao = Provider.of<NoteDao>(context);
    if(query.length == 0){
      return StreamBuilder <List<Note>>(
        stream: dao.watchAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          final notes = snapshot.data ?? List();
          return BuildListNote(notes: notes);
        },
      );
    }
    return StreamBuilder <List<Note>>(
      stream: dao.watchSearchedNotes(query),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        final notes = snapshot.data ?? List();
        return BuildListNote(notes: notes);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dao = Provider.of<NoteDao>(context);
    if(query.length == 0){
      return StreamBuilder <List<Note>>(
        stream: dao.watchAllNotes(),
        builder: (context, AsyncSnapshot<List<Note>> snapshot) {
          final notes = snapshot.data ?? List();
          return BuildListNote(notes: notes);
        },
      );
    }
    return StreamBuilder <List<Note>>(
      stream: dao.watchSearchedNotes(query),
      builder: (context, AsyncSnapshot<List<Note>> snapshot) {
        final notes = snapshot.data ?? List();
        return BuildListNote(notes: notes);
      },
    );
  }
}
