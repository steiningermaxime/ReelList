class ApiConfig {
  static const String supabaseUrl = 'http://127.0.0.1:54321';
  static const String supabaseApiKey = 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';
  
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbApiKey = 'c6e88af50b3d59713d8c208052d8bfd7';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
}

class ApiEndpoints {
  static const String favorites = '/rest/v1/favorites';
  
  static const String tmdbSearchMovie = '/search/movie';
  static const String tmdbMovieDetails = '/movie';
}
