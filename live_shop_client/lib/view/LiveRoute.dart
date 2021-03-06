import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liveshop/common/AppConstants.dart';
import 'package:liveshop/widget/BeautifulButton.dart';
import 'package:liveshop/widget/CardWidget.dart';
import 'package:liveshop/util/EventBus.dart';
/// 直播列表界面
class LiveLobby extends StatefulWidget {

  int _selectedIndex = 0;

  LiveLobby(this._selectedIndex);

  @override
  LiveLobbyState createState() {
    // TODO: implement createState
    return LiveLobbyState();
  }

}

class LiveLobbyState extends State<LiveLobby> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget._selectedIndex);
    return
//      TabBarView(
//        children: <Widget>[
//          Center(
//            child: Text("Tab")
//          )
//        ],
//      );

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: LiveList(0),
            ),
          ],
        ),
    );
  }

}


class LiveList extends StatefulWidget {

  int selectedIndex = 0;

  LiveList(int selectedIndex) {
    this.selectedIndex = selectedIndex;
  }

  @override
  State<StatefulWidget> createState() => _LiveListState();


}

class _LiveListState extends State {

  List<Widget> _cards = new List();

  var bus = EventBus();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     bus.on("tab", (args) {
      print(args);
    });
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //  bus.on("tab", (args) {
    //   print(args);
    // });
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(children: <Widget>[
          GestureDetector(
            child: ListView(
              shrinkWrap: true,
              physics:  NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20.0),
              children: _cards
            ),
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            print(details);
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomPaintRoute();
            }));
          })
      ]
    ));
  }

  void _getData() {
    for (int i = 0; i < 8; i++) {
      _cards.add(
          Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(child: CardWidget(Image.asset(AppConstants.NATIVE_IMAGE_PATH + "room0.png", width: 400.0,), "小喵的直播间"), flex: 1),
                Expanded(child: CardWidget(Image.asset(AppConstants.NATIVE_IMAGE_PATH + "room0.png", width: 400.0,), "小喵的直播间"), flex: 1),
              ]
          )
      );
    }
  }
}