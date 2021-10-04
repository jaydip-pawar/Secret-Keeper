import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';
import 'package:secret_keeper/Widgets/customPopupMenu.dart';
import 'package:secret_keeper/Widgets/customTitleBar.dart';
import 'package:secret_keeper/screens/home_screen/search/cusBankSearch.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class BanksNavigation extends StatefulWidget {
  final User user;

  const BanksNavigation({Key key, this.user}) : super(key: key);
  @override
  _BanksNavigationState createState() => _BanksNavigationState();
}

class _BanksNavigationState extends State<BanksNavigation> {

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
                      delegate: CustomBankDelegate(),
                    );
                  },
                ),
                CustomPopupMenu()
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildBankList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Bank>> _buildBankList(BuildContext context) {
    final dao = Provider.of<BankDao>(context);
    return StreamBuilder(
      stream: dao.watchAllBanks(),
      builder: (context, AsyncSnapshot<List<Bank>> snapshot) {
        final banks = snapshot.data ?? List();
        return BuildListBank(banks: banks);
      },
    );
  }
}
