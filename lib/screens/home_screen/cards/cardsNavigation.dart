import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';
import 'package:secret_keeper/Widgets/customPopupMenu.dart';
import 'package:secret_keeper/Widgets/customTitleBar.dart';
import 'package:secret_keeper/screens/home_screen/search/cusCardSearch.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class CardsNavigation extends StatefulWidget {
  final User user;

  const CardsNavigation({Key key, this.user}) : super(key: key);
  @override
  _CardsNavigationState createState() => _CardsNavigationState();
}

class _CardsNavigationState extends State<CardsNavigation> {

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
                      delegate: CustomCardDelegate(),
                    );
                  },
                ),
                CustomPopupMenu()
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildCardList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<CardDetail>> _buildCardList(BuildContext context) {
    final dao = Provider.of<CardDetailDao>(context);
    return StreamBuilder(
      stream: dao.watchAllCards(),
      builder: (context, AsyncSnapshot<List<CardDetail>> snapshot) {
        final cardDetails = snapshot.data ?? List();
        return BuildListCard(cardDetails: cardDetails);
      },
    );
  }
}
