import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_list.dart';
import 'package:movie_app/model/response_model.dart';
import 'package:movie_app/pages/overview_page.dart';
import 'package:movie_app/routes/routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic list;
  Future<ResponseModel> getMovieData() async {
    list = await getMovieList();

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.1),
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.amber),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteManager.searchPage);
              },
              icon: const Icon(
                Icons.search_outlined,
                color: Colors.grey,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
              )),
        ],
      ),
      body: FutureBuilder<ResponseModel>(
          future: getMovieData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic _moviesdatas = snapshot.data!;

              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.45,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 15.0),
                  itemCount: _moviesdatas.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OverViewPage(
                                    moviedata: _moviesdatas.data[index])));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              color: Colors.transparent,
                              elevation: 5,
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.37,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15)),
                                  child: Image.network(
                                    'https://image.tmdb.org/t/p/w185${_moviesdatas.data[index]['poster_path']}',
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
                                _moviesdatas.data[index]['original_title'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.01,
                                  ),
                                  Text(
                                    '${_moviesdatas.data[index]['vote_average']}/10 IMDb',
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
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          }),
    );
  }
}
