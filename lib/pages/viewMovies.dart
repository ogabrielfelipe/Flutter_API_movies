import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter_movies/model/movie.dart';
import 'package:flutter_movies/pages/detailMovie.dart';
import 'package:http/http.dart' as http;



class MyViewMovies extends StatefulWidget{
  const MyViewMovies({Key? key}) : super(key: key);
  
  @override
    _MyViewMoviesState createState() => _MyViewMoviesState();
} 


class _MyViewMoviesState extends State<MyViewMovies>{
  
  late Future<Movie> futureMovie;

  int VALORLISTA = 35;

  List<int> movies = [
    492282,
    9969,
    9746,
    17337,
    9812,
    3784,
    1884,
    473072,
    565310,
    20196,
    10479,
    11163,
    11948,
    13346,
    658751,
    3116,
    490594,
    606679,
    48838,
    9950,
    616037,
    610150,
    438148,
    585511,
    756999,
    539681,
    1008779,
    744276,
    718789,
    760161,
    634649,
    760104,
    675353,
    725201,
    758724,
  ];


  int intValue = -1;



  Future<Movie> fetchMovie(int movie) async{

    var _baseURL = 'https://api.themoviedb.org/3/movie/${movie.toString()}?api_key=[APIAQUI]&language=pt-BR';


    final response = await http.get(Uri.parse(_baseURL));

    if(response.statusCode == 200){
      
      return Movie.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load algum');
    }
  }

  @override
  void initState() {
    super.initState();


    intValue = Random().nextInt(VALORLISTA);


    futureMovie = fetchMovie(movies[intValue]);

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<Movie>(
              future: futureMovie,
              builder:
                (context, snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Wrap(
                        direction: Axis.vertical,
                        spacing: 20,
                        children: [
                          Image.network(
                            'https://image.tmdb.org/t/p/w300'+snapshot.data!.poster_path,
                          ),
                          
                          Text(
                            snapshot.data!.title,
                            style: const TextStyle(
                              fontSize: 20,
                              ),
                          ),
                            

                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 56,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push( 
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => MyDetailMovie(idMovie: snapshot.data!.id))
                                  );

                                }, 
                                child: const Text('Ver sinopse!')
                              ),

                              ElevatedButton(
                                onPressed: () {
                                  setState(() { 
                                    intValue = Random().nextInt(VALORLISTA);
                                    futureMovie = fetchMovie(movies[intValue]);
                                  });

                                }, 
                                child: const Text('Surpreenda-me!'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                  textStyle: const TextStyle(color: Colors.white)
                                ),
                              )
                            ],
                          )
                          
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator()
                    ],                  
                  );
                } 
              ),
            ),          
        ],
      )
    );
  }
}
