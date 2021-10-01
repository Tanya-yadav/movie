import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';

import 'package:cinemo/description.dart';

class coomingsoon extends StatelessWidget {
  final List upcoming;

  const coomingsoon({Key key, this.upcoming}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Cooming Soon',
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: upcoming.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Movie(
                                  name: upcoming[index]['title'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      upcoming[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      upcoming[index]['poster_path'],
                                  description: upcoming[index]['overview'],
                                  vote: upcoming[index]['vote_average']
                                      .toString(),
                                  launch_on: upcoming[index]
                                  ['release_date'],
                                  lang: upcoming[index]['original_language'],
                                )));
                      },
                      child: Container(
                        width: 140,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          upcoming[index]['poster_path']),
                                ),
                              ),
                              height: 200,
                            ),
                            SizedBox(height: 5),
                            Container(
                              child: modified_text(
                                  size: 15,
                                  text: upcoming[index]['title'] != null
                                      ? upcoming[index]['title']
                                      : 'Loading'),
                            )
                          ],
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }
}
