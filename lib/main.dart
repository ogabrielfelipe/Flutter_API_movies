import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_movies/pages/viewMovies.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp( const ViewMovies());
}

class ViewMovies extends StatelessWidget {
  const ViewMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData(
      brightness: Brightness.dark
    );


    return MaterialApp(
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.red
        )
      ),
      home: MyViewMovies(),
      debugShowCheckedModeBanner: false,
    );
  }
}