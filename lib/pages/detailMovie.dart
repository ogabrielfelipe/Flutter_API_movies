import 'package:flutter/material.dart';
import 'package:flutter_movies/model/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyDetailMovie extends StatefulWidget{
  MyDetailMovie({Key? key, required this.idMovie});
  
  int idMovie;

  @override
    _MyDetailMovieState createState() => _MyDetailMovieState();
} 


class _MyDetailMovieState extends State<MyDetailMovie>{

  late Future<Movie> futureMovie;


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

    futureMovie = fetchMovie(widget.idMovie);

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Wrap(
          children: [
            Expanded(
            child: FutureBuilder<Movie>(
              future: futureMovie,
              builder:
                (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500'+snapshot.data!.backdrop_path,
                          ),
                        ),
                          

                        
                          Wrap(
                            direction: Axis.horizontal,
                            spacing: 20,
                            children: [
                              Padding(padding: EdgeInsets.only(top: 20, bottom: 10, left: 5, right: 5),
                              child: Text(
                                snapshot.data!.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  ),

                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10), 
                                child: Text(
                                snapshot.data!.overview
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                                child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Voltar'),
                                ),
                              ),

                              )
                              
                              
                            ],
                          ),
                      ],
                    );                  
                    
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } 
              ),
            ),
          ],
        ),);

  }
}
