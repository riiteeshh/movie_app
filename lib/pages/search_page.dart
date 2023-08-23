import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_app/api/movie_list.dart';
import 'package:movie_app/components/error_icon.dart';
import 'package:movie_app/components/loading_page.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/model/response_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchKey = TextEditingController();
  dynamic _searchedData;
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
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: TextFormField(
            cursorColor: Colors.amber,
            style: const TextStyle(fontSize: 14),
            autofocus: true,
            decoration: const InputDecoration(
                hintText: '#The Godfather', border: InputBorder.none),
            controller: _searchKey,
            textInputAction: TextInputAction.search,
            onFieldSubmitted: (value) {
              setState(() {}); //to refresh page to get the search results.
            },
          ),
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
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.hasError) {
              return AlertDialog(
                title: const ErrorIcon(),
                elevation: 0,
                actions: [
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Try Again')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: () {
                        SystemNavigator.pop();
                      },
                      child: const Text('Exit')),
                ],
              );
            } else if (snapshot.hasData) {
              dynamic _moviesdatas = snapshot.data!;
              if (_searchKey.text != '') {
                finalData = [];
                for (int i = 0; i < _moviesdatas.data.length; i++) {
                  if (_moviesdatas.data[i]['original_title']
                      .toString()
                      .toLowerCase()
                      .contains(_searchKey.text.toLowerCase())) {
                    finalData.add(_moviesdatas.data[i]);
                  }
                }
              }
              return MovieCard(finalData: finalData);
            } else {
              return const LoadingPage();
            }
          }),
    );
  }
}
