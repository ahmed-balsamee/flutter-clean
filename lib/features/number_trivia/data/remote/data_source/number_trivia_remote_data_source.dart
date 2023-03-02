import 'package:flutter_clean/core/error/exceptions.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  /// calls http://numbersapi.com/{number} endpoint
  ///
  /// Throws [ServerException] for all error codes
  Future<NumberTriviaModel> getNumberTrivia(int number);


  /// calls http://numbersapi.com/random endpoint
  ///
  /// Throws [ServerException] for all error codes
  Future<NumberTriviaModel> getRandomNumberTrivia();
}