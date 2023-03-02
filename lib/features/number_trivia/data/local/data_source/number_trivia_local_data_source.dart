import 'package:flutter_clean/core/error/exceptions.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/models/number_trivia_model.dart';

abstract class NumberTriviaLocalDataSource {
  /// Gets the cached [NumberTriviaModel] which was gotten last time
  /// the user had an internet connection
  ///
  /// Throws [CacheException] if no cached data is present
  Future<NumberTriviaModel> getLastNumberTrivia(int number);


  Future<NumberTriviaModel> getRandomNumberTrivia();



  Future<void> cacheNumberTrivia(NumberTriviaModel numberTriviaModel);
}