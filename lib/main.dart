import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_energise/data.dart';
import 'dart:io';

import 'package:test_energise/first_view.dart';
import 'package:test_energise/localization.dart';
import 'package:test_energise/third_view.dart';
import 'second_view.dart';
import 'data.dart';


void main() async {
  // var path = Directory.current.path;
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // Hive.initFlutter(path);
  //
  // Hive.registerAdapter(IPDataAdapter());
  // // Hive.registerAdapter();
  // await Hive.openBox<IPData>('ipData');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('de', 'DE')
        ],
      debugShowCheckedModeBanner: false,
      home: SafeArea(child: MainTabBar())
    );
  }
}

class MainTabBar extends StatefulWidget {
  MainTabBar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainTabBar();
}

class _MainTabBar extends State<MainTabBar> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var _tabPages = <Widget>[FirstView(), SecondView(), ThirdView()];
  int _selectedTab = 0;
  List<Tab> _tabs = <Tab>[Tab(text: '1'), Tab(text: '2'), Tab(text: '3')];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: _tabPages.length,
        // animationDuration: const Duration(milliseconds: 3000),
        vsync: this,
        initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;

    return
    //   MaterialApp(
    //     debugShowCheckedModeBanner: false,
    // home:
    DefaultTabController(
        length: _tabs.length,
        animationDuration: const Duration(milliseconds: 300),
        child: Scaffold(
            body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: _tabPages,
            ),
            bottomNavigationBar: AnimatedContainer(
                duration: const Duration(milliseconds: 2340),
                child: 
                // Material( child: 
                    Container(
                        alignment: Alignment.topCenter,
                        height: 50,
                        color: Colors.red,
                        child: TabBar(
                            tabs: _tabs,
                            controller: _tabController,
                            labelColor: Colors.black,
                            indicatorSize: TabBarIndicatorSize.tab,
                            onTap: (int index) {
                              setState(() {
                                // _selectedTab = index;
                              });
                            })))));
  }
}
