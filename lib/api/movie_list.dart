import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app/model/response_model.dart';

Future<ResponseModel?> getMovieList() async {
  const String apiUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=db0dcf6a517e0074f03f43ddc49031b4';

  final response = await http.get(Uri.parse(apiUrl));
  print(response.statusCode);

  return ResponseModel.fromJson(jsonDecode(response.body));
}
