import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spotify_flutter/screen/search.dart';

void main() {
  runApp(
    // MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(create: (context) => PlaylistState()),
    //   ],
    //   child: MyApp(),
    // ),
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final pageNavList = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: "Playlist",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: "Search",
    ),
  ];

  int pageIndex = 0;

  updateTabPage(index) {
    setState(() {
      pageIndex = index;
    });
  }

  getPage() {
    if (pageIndex == 0) {
      return SearchPage();
    } else if (pageIndex == 1) {
      // return FavouritePage();
    } else {
      // return CartPage();
    }
  }

  void initState() {
    super.initState();
    // final productState = Provider.of<PlaylistState>(context, listen: false);
    // playlistState.fetchPlaylist();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: getPage(),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: pageIndex,
      //   type: BottomNavigationBarType.fixed,
      //   items: pageNavList,
      //   onTap: (index) {
      //     return updateTabPage(index);
      //   },
      // ),
    );
  }
}
