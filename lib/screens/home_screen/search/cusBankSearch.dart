import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';

class CustomBankDelegate extends SearchDelegate {
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
    final dao = Provider.of<BankDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllBanks(),
        builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
          final banks = snapshot.data ?? List();
          return BuildListBank(banks: banks);
        },
      );
    }
    return StreamBuilder(
      stream: dao.watchSearchedBanks(query),
      builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
        final banks = snapshot.data ?? List();
        return BuildListBank(banks: banks);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dao = Provider.of<BankDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllBanks(),
        builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
          final banks = snapshot.data ?? List();
          return BuildListBank(banks: banks);
        },
      );
    }
    return StreamBuilder(
      stream: dao.watchSearchedBanks(query),
      builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
        final banks = snapshot.data ?? List();
        return BuildListBank(banks: banks);
      },
    );
  }
}
