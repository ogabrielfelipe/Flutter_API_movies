class Movie{
  final int id;
  final String overview;
  final String title;
  final String poster_path;
  final String backdrop_path;

  Movie({
    required this.id,
    required this.backdrop_path,
    required this.overview,
    required this.poster_path,
    required this.title
  });

  factory Movie.fromJson(Map<String, dynamic> json){
    return Movie(
      id: json['id'],
      backdrop_path: json['backdrop_path'], 
      overview: json['overview'], 
      poster_path: json['poster_path'], 
      title: json['title']
      );
  }

}