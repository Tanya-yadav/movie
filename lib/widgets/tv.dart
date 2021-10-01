
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';
import '../description.dart';

class TV extends StatelessWidget {
  final List tv;

  const TV({Key key, this.tv}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Popular TV Shows',
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
            // color: Colors.red,
              height: 480,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tv.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Movie(
                                  name: tv[index]['name'],
                                  bannerurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      tv[index]['backdrop_path'],
                                  posterurl:
                                  'https://image.tmdb.org/t/p/w500' +
                                      tv[index]['poster_path'],
                                  vote: tv[index]['vote_average']
                                      .toString(),
                                  description: tv[index]['overview'],
                                  launch_on: tv[index]
                                  ['first_air_date'],
                                  lang: tv[index]['original_language'],
                                )));
                      },
                      child: Container(
                        padding: EdgeInsets.all(5),
                        //colour:colours.green,
                        width: 380,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            tv[index]['poster_path']
                                    ),
                                    fit: BoxFit.cover
                                ),
                              ),
                              height: 420,
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: modified_text(
                                  size: 15,
                                  text: tv[index]['original_name'] != null
                                      ? tv[index]['original_name']
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
