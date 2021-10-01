import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';
import 'package:cinemo/widgets/top_rated.dart';
import 'package:cinemo/widgets/trending.dart';
import 'package:cinemo/widgets/tv.dart';
import 'package:cinemo/widgets/upcoming.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:cinemo/widgets/people.dart';
import 'package:cinemo/description.dart';
import 'package:cinemo/profile.dart';
import 'widgets/coomigsoon.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
      theme: ThemeData(brightness: Brightness.dark, primaryColor: Colors.deepPurpleAccent),

    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //int _selectedTabIndex = 0;

 // List _pages = [
 //   Text("Home"),
 //   Text("Search"),
 //   Text("Account"),
 // ];
 //
 // _changeIndex(int index) {
 //   setState(() {
 //     _selectedTabIndex = index;
 //   });
  //}
  bool isSearching = false;
  final String apikey = 'fe168ad14b61cb918f97fb01c263356b';
  final String readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZTE2OGFkMTRiNjFjYjkxOGY5N2ZiMDFjMjYzMzU2YiIsInN1YiI6IjYwYTY4OTg5OWE5ZTIwMDA0MDg5NWJlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Rn8J3zjbHvKpxxP9ViBvmGs2XGj84eFhAbn1wTNIk_4';
  List trendingmovies = [];
  List topratedmovies = [];
  List tv = [];
  List upcoming = [];
  List people = [];
  @override
  void initState() {
    super.initState();
    loadmovies();
  }

  loadmovies() async {
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    Map trendingresult = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvresult = await tmdbWithCustomLogs.v3.tv.getPouplar();
    Map upcomingresult = await tmdbWithCustomLogs.v3.movies.getUpcoming();
    Map peopleresult = await tmdbWithCustomLogs.v3.people.getPopular();
    print((trendingresult));
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      tv = tvresult['results'];
      upcoming= upcomingresult['results'] ;
      people= peopleresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),

        title: !isSearching ?
        modified_text( text: ('Cinemo'))
            : TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                  icon: Icon(Icons.search),
                  hintText: "Search movie here",
                  hintStyle: TextStyle(color: Colors.white)
                )),
        actions: <Widget>[
          isSearching ?
          IconButton(icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
              });
            },
          )
              : IconButton(icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
          )


        ],
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
            children: [
          TV(tv: tv),
          TrendingMovies(
            trending: trendingmovies,
          ),
          TopRatedMovies(
            top_rated: topratedmovies,
          ),
          UpcomingMovies(
            upcoming: upcoming,
          ),
              LatestPeople(people: people,),

        ],
      ),
      // new

     // child: coomingsoon(upcoming: upcoming,),
      bottomNavigationBar: BottomAppBar(
        color: Colors.deepPurple[300],
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home,size: 40,color: Colors.deepPurple,), onPressed: () {
          //    Navigator.push(
          //        context,
          //        MaterialPageRoute(
          //            builder: (context) => ( )));
            },),
            IconButton(icon: Icon(Icons.movie_filter,size: 40,color: Colors.deepPurple,), onPressed: () {
              coomingsoon(upcoming: upcoming,);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => coomingsoon( )));
            },),
            IconButton(icon: Icon(Icons.account_circle,size: 40,color: Colors.deepPurple,),

              onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile( )));

            },)
          ],
        ),
      ),
 // bottomNavigationBar: BottomNavigationBar(
 //   currentIndex: _selectedTabIndex,
 //   onTap: _changeIndex,
 //   items: [
 //     BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home"),
 //         backgroundColor: Colors.deepPurpleAccent),
 //     BottomNavigationBarItem(
 //         icon: Icon(Icons.movie_filter), title: Text("Coming Soon"),
 //         backgroundColor: Colors.deepPurpleAccent),
 //     BottomNavigationBarItem(
 //         icon: Icon(Icons.account_circle), title: Text("My Account"),
 //         backgroundColor: Colors.deepPurpleAccent),
 //   ],
 // ),
    );
    //    items: const <BottomNavigationBarItem>[
    //      BottomNavigationBarItem(
    //          icon: Icon(Icons.home_outlined),
    //          // ignore: deprecated_member_use
    //          title: Text('Home'),
    //          backgroundColor: Colors.deepPurpleAccent
    //      ),
    //      BottomNavigationBarItem(
    //        icon: Icon(Icons.movie_filter),
    //        // ignore: deprecated_member_use
    //        title: Text('Coming soon'),
    //          //color: Colors.deepPurple,
    //      ),
    //      BottomNavigationBarItem(
    //        icon: Icon(Icons.person),
    //        // ignore: deprecated_member_use
    //        title: Text('Profile'),
    //      ),
    //    ],
    //    iconSize: 30,
    //    elevation: 3

  }
}


