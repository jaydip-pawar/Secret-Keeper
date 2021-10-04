import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:secret_keeper/Database/Moor/moor_database.dart';
import 'package:secret_keeper/Widgets/customBuildListItem.dart';
import 'package:secret_keeper/Widgets/customTitleBar.dart';
import 'package:secret_keeper/Widgets/customPopupMenu.dart';
import 'package:secret_keeper/screens/home_screen/search/cusPasswordSearch.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class PasswordsNavigation extends StatefulWidget {
  final User user;

  const PasswordsNavigation({Key key, this.user}) : super(key: key);
  @override
  _PasswordsNavigationState createState() => _PasswordsNavigationState();
}

class _PasswordsNavigationState extends State<PasswordsNavigation> {

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
            resizeToAvoidBottomPadding: false,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: cusTitleBar(),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: (){
                    showSearch(
                      context: context,
                      delegate: CustomPasswordDelegate(),
                    );
                  },
                ),
                CustomPopupMenu()
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: _buildPasswordList(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<List<Password>> _buildPasswordList(BuildContext context) {
    final dao = Provider.of<PasswordDao>(context);
    return StreamBuilder(
      stream: dao.watchAllPasswords(),
      builder: (context, AsyncSnapshot<List<Password>> snapshot) {
        final passwords = snapshot.data ?? List();
        return BuildListPassword(passwords: passwords);
      },
    );
  }
}
