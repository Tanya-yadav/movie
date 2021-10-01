import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';
import 'package:cinemo/description.dart';

class TopRatedMovies extends StatelessWidget {
  final List top_rated;

  const TopRatedMovies({Key key, this.top_rated}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          modified_text(
            text: 'Top Rated Movies',
            size: 26,
          ),

          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: top_rated.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Movie(
                                name: top_rated[index]['title'],
                                bannerurl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        top_rated[index]['backdrop_path'],
                                    posterurl:
                                    'https://image.tmdb.org/t/p/w500' +
                                        top_rated[index]['poster_path'],
                                  description: top_rated[index]['overview'],
                                   vote: top_rated[index]['vote_average']
                                    .toString(),
                                  launch_on: top_rated[index]
                                         ['release_date'],
                              lang: top_rated[index]['original_language'],

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
                                     top_rated[index]['poster_path']),
                              ),
                            ),

                            height: 200,
                          ),
                          SizedBox(height: 5),
                          Container(
                            child: modified_text(
                                size: 15,
                                text: top_rated[index]['title'] != null
                                    ? top_rated[index]['title']
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
