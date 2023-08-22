import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_list.dart';
import 'package:movie_app/model/response_model.dart';

import 'overview_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchKey = TextEditingController();
  dynamic _searchedData;
  List<dynamic> results = [];
  List<dynamic> finalData = [];
  Future<ResponseModel> getSearchData() async {
    _searchedData = await getMovieList();

    return _searchedData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextFormField(
          autofocus: true,
          controller: _searchKey,
          textInputAction: TextInputAction.search,
          onFieldSubmitted: (value) {
            setState(() {});
          },
        ),
        actions: [
          TextButton(
              onPressed: () {
                setState(() {});
              },
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.amber),
              ))
        ],
      ),
      body: FutureBuilder(
          future: getSearchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic _moviesdatas = snapshot.data!;
              if (_searchKey.text != '') {
                results = _moviesdatas.data;
                for (int i = 0; i < _moviesdatas.data.length; i++) {
                  if (results[i]['original_title']
                      .toString()
                      .toLowerCase()
                      .contains(_searchKey.text.toLowerCase())) {
                    finalData.add(results[i]);
                  }
                }
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.45,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 15.0),
                  itemCount: finalData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OverViewPage(moviedata: finalData[index])));
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
                                    'https://image.tmdb.org/t/p/w185${finalData[index]['poster_path']}',
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
                                finalData[index]['original_title'],
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
                                    '${finalData[index]['vote_average']}/10 IMDb',
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
            ));
          }),
    );
  }
}
