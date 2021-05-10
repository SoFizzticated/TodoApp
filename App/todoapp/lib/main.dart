import 'package:flutter/material.dart';
import 'package:todoapp/logging.dart';
import 'package:todoapp/models/global.dart';
import 'package:todoapp/reorderable_view_page.dart';

void main() {
  initRootLogger();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'ToDo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.yellow,
      // Don't overlap Mobile UI
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: [
              // Main swipeable screens
              TabBarView(
                children: [
                  new Container(
                    color: Colors.grey,
                    child: ReorderableViewPage(),
                    // child: IntrayPage(),
                  ),
                  new Container(
                    color: Colors.orange,
                  ),
                  new Container(
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              /*
              // Intray holder
              Container(
                padding: EdgeInsets.only(left: 50), // 50 left initial padding
                height: 160,
                // color: Colors.white, // If Container has BoxDecoration, color goes inside BoxDecoration
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                  color: Colors.white,
                ),

                // Title and button holder
                child: Row(
                  // Maximize space between elements
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Intray", style: intrayTitleStyle),
                    Container(),
                  ],
                ),
              ),

              // Button holder
              Container(
                height: 80,
                width: 80,
                margin: EdgeInsets.only(
                  // Vertical offset, horizontal centered
                  top: 120,
                  left: (MediaQuery.of(context).size.width / 2) - 40,
                ),
                child: FloatingActionButton(
                  elevation: 10,
                  child: Icon(Icons.add, size: 70),
                  backgroundColor: redColor,
                  onPressed: () {},
                ),
              )
              */
            ]),
            // Navbar overlay
            appBar: AppBar(
              elevation: 0, // Remove shadows
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGreyColor,
                unselectedLabelColor: Colors.blue[900],
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
