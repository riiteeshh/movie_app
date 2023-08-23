// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:movie_app/pages/overview_page.dart';

class MovieCard extends StatefulWidget {
  dynamic finalData;
  MovieCard({super.key, required this.finalData});

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.45,
            crossAxisSpacing: 12,
            mainAxisSpacing: 15.0),
        itemCount: widget.finalData.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          OverViewPage(moviedata: widget.finalData[index])));
            },
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Card(
                    color: Colors.transparent,
                    elevation: 5,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.37,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w185${widget.finalData[index]['poster_path']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  SizedBox(
                    child: Text(
                      widget.finalData[index]['original_title'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 16,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        Text(
                          '${widget.finalData[index]['vote_average']}/10 IMDb',
                          style: const TextStyle(
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
