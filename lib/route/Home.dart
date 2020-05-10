import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ioa/route/InfoRoute.dart';
import 'package:ioa/route/LiveLobby.dart';
import 'package:ioa/route/MsgRoute.dart';
import 'package:ioa/ui/ListOptionsItem.dart';
import 'package:ioa/ui/OASwiper.dart';
import 'package:ioa/ui/SkuHomeList.dart';
import 'package:ioa/util/EventBus.dart';

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute>
    with SingleTickerProviderStateMixin {
  //当前选中的导航
  int _selectedIndex = 0;

  TabController _tabController;

  List tabs = ['最新', '热门', '精选'];

  List<Widget> mainMenu = [HomeMenuGridView(), LiveLobby(0), InfoRoute(), MsgRoute(), InfoRoute()];

  var bus = EventBus();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child:
          Text("主页"),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              });
        }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
        bottom: this._selectedIndex == 1
            ? TabBar(
                controller: _tabController,
                tabs: tabs.map((e) => Tab(text: e)).toList())
            : null,
      ),
      drawer: MyDrawer(),
      body: Container(
        child: this._selectedIndex != 1 ? mainMenu[_selectedIndex] : LiveList(this._tabController.index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 14.0,
        unselectedFontSize: 14.0,
        selectedFontSize: 14.0,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页",)),
          BottomNavigationBarItem(icon: Icon(Icons.videocam), title: Text("直播",)),
          BottomNavigationBarItem(icon: Icon(Icons.people), title: Text("广场")),
          BottomNavigationBarItem(icon: Icon(Icons.chat), title: Text("消息",)),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), title: Text("购物车")),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      // 浮动按钮
      floatingActionButton: FloatingActionButton(
        onPressed: _onAdd,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onAdd() {}

 
  @override
  void dispose() {
    super.dispose();
    bus.off("tab");
  }

  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 1:
          bus.send("tab", 1);
          break;
        case 2:
          break;
        case 3:
          break;
        default:
      }
    });
  }
}

class HomeMenuGridView extends StatefulWidget {
  @override
  _HomeMenuGridViewState createState() => _HomeMenuGridViewState();
}

class _HomeMenuGridViewState extends State<HomeMenuGridView> {
  List<Widget> menu = [
    SizedBox(
      width: 150.0,
      height: 100.0,
      child: Column(
        children: <Widget>[
          Icon(Icons.group),
          Text("我的团队"),
        ],
      ),
    ),
    SizedBox(
      width: 150.0,
      height: 100.0,
      child: Column(
        children: <Widget>[
          Icon(Icons.work),
          Text("我的工作"),
        ],
      ),
    ),
    SizedBox(
      width: 150.0,
      height: 100.0,
      child: Column(
        children: <Widget>[
          Icon(Icons.assistant_photo),
          Text("打卡"),
        ],
      ),
    ),
  ]; //保存Icon数据

  void initState() {
    // _retrieveIcons();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: <Widget>[
          Container(
            height: 150.0,
            child: SwiperPage(title: "热点新闻"),
          ),
          Flex(direction: Axis.horizontal, children: <Widget>[
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.mobile_screen_share),
                      Text("充值中心"),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.fastfood),
                      Text("美食"),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.card_travel),
                      Text("旅行"),
                    ],
                  ),
                )),
            Expanded(
                flex: 1,
                child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Icon(Icons.mic),
                      Text("娱乐"),
                    ],
                  ),
                ))
          ]),
          Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.videogame_asset),
                        Text("游戏"),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.accessibility),
                        Text("生活"),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.local_hospital),
                        Text("健康"),
                      ],
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.school),
                        Text("学习"),
                      ],
                    ),
                  )),
            ],
          ),
          Container(
            child: SkuHomeList(),
          )
        ]));
//    ListView(
//      shrinkWrap: true,
//      children: <Widget>[CardWidgetList()],
//    );

//      ListView(
//      shrinkWrap: true,
//      children: <Widget>[
//        Container(
//          child: SwiperPage(title: "热点新闻"),
//          height: 150.0,
//        ),
//        Container(
//          color: Colors.white,
//          child: Row(
//            children: menu,
//          ),
//        ),
//        Flex(
//          direction: Axis.horizontal,
//          children: <Widget>[
//            Expanded(child:  CardWidget(), flex: 1),
//            Expanded(child:  CardWidget(), flex: 1)
//          ],
//        ),
//      ],
//    );
  }
}

/**
 * 侧边栏
 */
class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: MediaQuery.removePadding(
        context: context,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.lightBlueAccent),
                child:
                Center(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                          "images/me.jpg",
                          width: 80,
                        ),
                      ),
                      Text("杨小前"),
                    ],
                  )
                ))),
            ListOptionItem(Icons.settings, "设置"),

            ListOptionItem(Icons.info, "信息"),

            ListOptionItem(Icons.local_laundry_service, "服务"),

            ListOptionItem(Icons.collections, "收藏"),

          ],
        ),

//        Column(
//          children: <Widget>[
//            Padding(
//              padding: const EdgeInsets.only(top: 38.0),
//              child: Row(
//                children: <Widget>[
//                  Center(
//                    child:  Padding(
//                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                      child: ClipOval(
//                        child: Image.asset(
//                          "images/me.jpg",
//                          width: 80,
//                        ),
//                      ),
//                    ),
//                  )
//                ],
//              ),
//            ),
//          ],
//        ),
      ),
    );
  }
}