import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tales/model/tale.dart';
import 'package:tales/modelview/player_model_view.dart';
import 'package:tales/view/home_page.dart';
import 'package:tales/view/search_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedIndex = 0;
  List<Widget> pages;
  PageStorageKey<String> keyMainPage, keySearchPage;

  @override
  void initState() {
    keyMainPage = PageStorageKey("keyMainPage");
    keySearchPage = PageStorageKey("keySearchPage");
    pages = [HomePage(keyMainPage), SearchPage(keySearchPage)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          selectedIndex == 0 ? "Ana Sayfa" : "Ara",
          style: Theme.of(context).textTheme.subtitle1,
        ),
        /*  actions: [
          IconButton(
            icon: Container(
                child: Text(
              "?",
              style: TextStyle(color: Colors.pink.shade300),
            )),
            onPressed: () => Navigator.of(context).pushNamed(
              '/informationPage',
            ),
          )
        ], */
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  bottomNavigationBar() => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          playerField(),
          BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: "Ana Sayfa"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Ara"),
            ],
            iconSize: 28,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: selectedIndex,
            selectedItemColor: Theme.of(context).focusColor,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ],
      );

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  playerField() {
    final playerModelView = Provider.of<PlayerModelView>(context, listen: true);
    Tale tale = playerModelView.currentTale;
    return playerModelView.currentTale != null
        ? GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed('/playerPage', arguments: tale),
            child: Column(
              children: [
                Container(
                    color: Theme.of(context).canvasColor,
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Hero(
                              tag: tale.taleID,
                              child: Image.asset(tale.taleProfileUrl),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AutoSizeText(
                                  tale.taleName,
                                  style: Theme.of(context).textTheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                                AutoSizeText(
                                  tale.voicingName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: GestureDetector(
                              onTap: () async {
                                await playAndPauseSound();
                              },
                              child: CircleAvatar(
                                  radius: 20.h,
                                  backgroundColor: Theme.of(context).focusColor,
                                  child: Icon(
                                    playerModelView.playerStateGet ==
                                            PlayerState.PLAYING
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    size: 20.h,
                                  ))),
                        )
                      ],
                    )),
                StreamBuilder(
                    stream: playerModelView.getDuration(),
                    builder: (context, asyncSnapshot) {
                      Duration duration = asyncSnapshot.data;
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 5.h,
                          width: duration == null
                              ? 0
                              : duration.inSeconds *
                                  ScreenUtil().screenWidth /
                                  tale.taleLength,
                          color: Theme.of(context).focusColor,
                        ),
                      );
                    })
              ],
            ),
          )
        : Container();
  }

  Future<void> playAndPauseSound() async {
    final playerModelView =
        Provider.of<PlayerModelView>(context, listen: false);
    if (playerModelView.playerStateGet == PlayerState.PLAYING) {
      await playerModelView.pauseTale();
    } else {
      playerModelView.playTale(playerModelView.currentTale);
    }
  }
}
