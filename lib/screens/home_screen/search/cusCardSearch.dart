import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';

class CustomCardDelegate extends SearchDelegate {
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
    final dao = Provider.of<CardDetailDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllCards(),
        builder: (context, AsyncSnapshot<List<CardDetail>> snapshot) {
          final cardDetails = snapshot.data ?? List();
          return BuildListCard(cardDetails: cardDetails);
        },
      );
    }
    return StreamBuilder(
      stream: dao.watchSearchedCards(query),
      builder: (context, AsyncSnapshot<List<CardDetail>> snapshot) {
        final cardDetails = snapshot.data ?? List();
        return BuildListCard(cardDetails: cardDetails);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final dao = Provider.of<CardDetailDao>(context);
    if(query.length == 0){
      return StreamBuilder(
        stream: dao.watchAllCards(),
        builder: (context, AsyncSnapshot<List<CardDetail>> snapshot) {
          final cardDetails = snapshot.data ?? List();
          return BuildListCard(cardDetails: cardDetails);
        },
      );
    }
    return StreamBuilder(
      stream: dao.watchSearchedCards(query),
      builder: (context, AsyncSnapshot<List<CardDetail>> snapshot) {
        final cardDetails = snapshot.data ?? List();
        return BuildListCard(cardDetails: cardDetails);
      },
    );
  }
}
