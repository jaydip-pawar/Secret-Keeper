import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';

class CustomPasswordDelegate extends SearchDelegate {

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
    final dao = Provider.of<PasswordDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllPasswords(),
        builder: (context, AsyncSnapshot<List<Password>> snapshot) {
          final passwords = snapshot.data ?? List();
          return BuildListPassword(passwords: passwords);
        },
      );
    }
    return StreamBuilder <List<Password>> (
      stream: dao.watchSearchedPasswords(query),
      builder: (context, AsyncSnapshot<List<Password>> snapshot) {
        final passwords = snapshot.data ?? List();
        return BuildListPassword(passwords: passwords);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dao = Provider.of<PasswordDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllPasswords(),
        builder: (context, AsyncSnapshot<List<Password>> snapshot) {
          final passwords = snapshot.data ?? List();
          return BuildListPassword(passwords: passwords);
        },
      );
    }
    return StreamBuilder <List<Password>> (
      stream: dao.watchSearchedPasswords(query),
      builder: (context, AsyncSnapshot<List<Password>> snapshot) {
        final passwords = snapshot.data ?? List();
        return BuildListPassword(passwords: passwords);
      },
    );
  }
}
