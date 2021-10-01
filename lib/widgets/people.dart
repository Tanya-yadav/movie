import 'package:flutter/material.dart';
import 'package:cinemo/utils/text.dart';


class LatestPeople extends StatelessWidget {
  final List people;

  const LatestPeople({Key key, this.people}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          modified_text(
            text: 'Popular People',
            size: 26,
          ),
          SizedBox(height: 10),
          Container(
              height: 270,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: people.length,
                  itemBuilder: (context, index) {
                    Transform.rotate(angle: 60);

                    return Container(
                      padding: EdgeInsets.all(5),
                        width: 140,
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(seconds: 2),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          people[index]['profile_path']),
                                ),
                              ),
                              height: 170,
                            ),
                      SizedBox(height: 4),
                            Container(
                              child: modified_text(
                                  size: 15,
                                  text: people[index]['name'] != null
                                      ? people[index]['name']
                                      : 'Loading'),
                            )
                    ],
                    ),
                    );
                  }))
        ],
      ),
    );
  }
}
