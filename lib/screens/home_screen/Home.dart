import 'package:flutter/material.dart';
import 'package:secret_keeper/screens/home_screen/banks/banksNavigation.dart';
import 'package:secret_keeper/screens/home_screen/cards/cardsNavigation.dart';
import 'package:secret_keeper/screens/home_screen/notes/notesNavigation.dart';
import 'package:secret_keeper/screens/home_screen/passwords/passwordsNavigation.dart';
import 'package:secret_keeper/screens/input_screen/bank_input/BankInput.dart';
import 'package:secret_keeper/screens/input_screen/card_input/CardInput.dart';
import 'package:secret_keeper/screens/input_screen/note_input/NoteInput.dart';
import 'package:secret_keeper/screens/input_screen/password_input/PasswordInput.dart';
import 'package:secret_keeper/screens/settings/auto_lock.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //Properties

  int currentTab = 0;
  final List<Widget> screens = [
    PasswordsNavigation(),
    CardsNavigation(),
    BanksNavigation(),
    NotesNavigation(),
  ];

  //Active Page (Tab)

  Widget currentScreen = PasswordsNavigation();
  final PageStorageBucket bucket = PageStorageBucket();

  void checkNavigation() {
    if (currentTab == 0)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PasswordInput()));
    else if (currentTab == 1)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CardInput()));
    else if (currentTab == 2)
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BankInput()));
    else
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NoteInput()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  void setup() {
    bool isRegistered = getIt.isRegistered<AutoLock>();
    if (!isRegistered) {
      getIt.registerSingleton<AutoLock>(AutoLock(context));
    }
  }

  void restartTimer(PointerEvent details) {
    /// Reset the timer by tapping anywhere on the screen.
    getIt<AutoLock>().syncValueStreamController.sink.add(null);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    getIt<AutoLock>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Listener(
            onPointerDown: restartTimer,
            onPointerMove: restartTimer,
            onPointerUp: restartTimer,
            behavior: HitTestBehavior.translucent,
            child: PageStorage(
              child: currentScreen,
              bucket: bucket,
            ),
          ),

          //FAB Button

          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              getIt<AutoLock>().syncValueStreamController.sink.add(null);
              checkNavigation();
            },
          ),

          //FAB Position

          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

          //Bottom App Bar

          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          getIt<AutoLock>().syncValueStreamController.sink.add(null);
                          setState(() {
                            currentScreen = PasswordsNavigation();
                            currentTab = 0;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.paste_sharp,
                              color:
                                  currentTab == 0 ? Colors.orange : Colors.grey,
                            ),
                            Text(
                              'Logins',
                              style: TextStyle(
                                color:
                                    currentTab == 0 ? Colors.orange : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          getIt<AutoLock>().syncValueStreamController.sink.add(null);
                          setState(() {
                            currentScreen = CardsNavigation();
                            currentTab = 1;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.credit_card_rounded,
                              color:
                                  currentTab == 1 ? Colors.orange : Colors.grey,
                            ),
                            Text(
                              'Cards',
                              style: TextStyle(
                                color:
                                    currentTab == 1 ? Colors.orange : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          getIt<AutoLock>().syncValueStreamController.sink.add(null);
                          setState(() {
                            currentScreen = BanksNavigation();
                            currentTab = 2;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.food_bank,
                              color:
                                  currentTab == 2 ? Colors.orange : Colors.grey,
                            ),
                            Text(
                              'Banks',
                              style: TextStyle(
                                color:
                                    currentTab == 2 ? Colors.orange : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        minWidth: 40,
                        onPressed: () {
                          getIt<AutoLock>().syncValueStreamController.sink.add(null);
                          setState(() {
                            currentScreen = NotesNavigation();
                            currentTab = 3;
                          });
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.notes,
                              color:
                                  currentTab == 3 ? Colors.orange : Colors.grey,
                            ),
                            Text(
                              'Notes',
                              style: TextStyle(
                                color:
                                    currentTab == 3 ? Colors.orange : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
