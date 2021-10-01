
import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

import 'genres_view.dart';
import 'model/trailer_model.dart';
import 'package:cinemo/bloc/trailer.dart';
import 'package:cinemo/bloc/detail_provider.dart';
import 'package:cinemo/model/change_notifiers.dart';
import 'package:provider/provider.dart';

class Movie extends StatelessWidget {
  final String name, description, bannerurl, posterurl, vote, launch_on, lang;
  final int movieId;
  List<int> genreIds;

   Movie(
      {Key key,
        this.name,
        this.description,
        this.bannerurl,
        this.posterurl,
        this.vote,
        this.launch_on,
        this.lang,
        this.movieId,
        this.genreIds,
      })
      : super(key: key);

  void didChangeDependencies() {
    bloc.fetchTrailersById(movieId);

  }

  @override
  void dispose() {
    bloc.dispose();
  }

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(

      genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: ListView(children: [
          Container(
              height: 300,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    height: 300,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Image.network(
                      bannerurl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],),),

          Container(
              padding: EdgeInsets.all(10),
              child: modified_text(
                  text: name != null ? name : 'Not Loaded', size: 24)),

        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Card(
                color: Colors.black87,
                  elevation: 5,
                child: Padding(
                    padding: EdgeInsets.only(left: 5),
                    child:Column(
                      children: <Widget>[
                      Icon(
                      Icons.star_outline_sharp,
                      size: 33,
                      color: Theme
                          .of(context)
                          .primaryColor,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                            modified_text(
                        text: 'Rating - ' + vote, size: 16)]
                    ))),
                    SizedBox(height: 14),

              Card(
                color: Colors.black87,
                elevation: 5,
                  child: Padding(
                   padding: EdgeInsets.only(left: 5),
                    child: Column(
                   children: <Widget>[
                Icon(
                  Icons.calendar_today_rounded,
                  size: 25,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                SizedBox(
                  height: 14,
                ),
                modified_text(text: 'Released On - ' + launch_on, size:16)
              ],
            ),
          ),
              ),
             Card(
               color: Colors.black87,
                elevation: 5,
             child: Padding(
             padding: EdgeInsets.only(left: 5),
             child: Column(
              children: <Widget>[
                Icon(
                  Icons.language_sharp,
                  size: 25,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                SizedBox(
                  height: 14,
                ),
                modified_text(text: 'Language - ' + lang, size: 16)
              ],
            ),
          ),
          ),
       ] ),


          Container(
            padding: EdgeInsets.symmetric(vertical: 40),
            child:
          Row(
            children: [
              Container(
                height: 200,
                width: 100,
                child: Image.network(posterurl),
              ),
              Flexible(
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: modified_text(text: description, size: 18)),
              ),
              SizedBox(height: 4),
            ],
          )
        ),




          Card(
            color: Colors.black87,
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Column(
                children: <Widget>[
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 25,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  modified_text(text: 'Genres- ' + 'genreIds', size:16)
                ],
              ),
            ),
          ),










      Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
      Text(
        "Trailer",
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      Container(margin: EdgeInsets.only(top: 8.0, bottom: 8.0)),
      StreamBuilder(
        stream: bloc.movieTrailers,
        builder:
            (context, AsyncSnapshot<Future<TrailerModel>> snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: snapshot.data,
              builder: (context,
                  AsyncSnapshot<TrailerModel> itemSnapShot) {
                if (itemSnapShot.hasData) {
                  if (itemSnapShot.data.results.length > 0)
                    return trailerLayout(itemSnapShot.data);
                  else
                    return noTrailer(itemSnapShot.data);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      ],
    ),
      ),
    );
    }

  Widget noTrailer(TrailerModel data) {
    return Center(
      child: Container(
        child: Text("No trailer available"),
      ),
    );
  }

  Widget trailerLayout(TrailerModel data) {
    if (data.results.length > 1) {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
//          trailerItem(data, 1),
        ],
      );
    } else {
      return Row(
        children: <Widget>[
          trailerItem(data, 0),
        ],
      );
    }
  }

  trailerItem(TrailerModel data, int index) {
    return Expanded(
      child: InkResponse(
        enableFeedback: true,
        child: Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.play_circle_filled),
              title: Text(
                data.results[index].name,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
//            Container(
//              margin: EdgeInsets.all(5.0),
//              height: 100.0,
//              color: Colors.grey,
//              child: Center(child: Icon(Icons.play_circle_filled)),
//            ),
//            Text(
//              data.results[index].name,
//              maxLines: 1,
//              overflow: TextOverflow.ellipsis,
//            ),
          ],
        ),
        onTap: () => _openYoutube(data.results[index].key),
      ),
    );
  }

  _openYoutube(String videoId) async {
    try {
      await launch(
        'https://www.youtube.com/watch?v=$videoId',
        option: new CustomTabsOption(
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: new CustomTabsAnimation.slideIn(),
          // or user defined animation.
//          animation: new CustomTabsAnimation(
//          startEnter: 'slide_up',
//          startExit: 'android:anim/fade_out',
//          endEnter: 'android:anim/fade_in',
//          endExit: 'slide_down',
//        ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
            'com.microsoft.emmx',
          ],
        ),
      );
    } catch (e) {
      // An exception is thrown if browser app is not installed on Android device.
      debugPrint(e.toString());
    }
  }}
