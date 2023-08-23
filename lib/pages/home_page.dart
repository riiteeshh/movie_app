import 'package:flutter/material.dart';
import 'package:movie_app/api/movie_list.dart';
import 'package:movie_app/components/error_icon.dart';
import 'package:movie_app/components/loading_page.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/components/search_bar.dart';
import 'package:movie_app/model/response_model.dart';
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () =>
                      Navigator.pushNamed(context, RouteManager.searchPage),
                  child: const SearchingBar()),
            ],
          ),
          title: const Text(
            'Home',
            style: TextStyle(color: Colors.amber),
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_outlined,
                  color: Colors.grey,
                )),
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.amber,
                child: LoadingPage(),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<ResponseModel>(
          future: getMovieData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.hasError) {
              return const ErrorIcon();
            } else if (snapshot.hasData) {
              dynamic _moviesdatas = snapshot.data!;

              return MovieCard(finalData: _moviesdatas.data);
            }
            return const LoadingPage();
          }),
    );
  }
}
