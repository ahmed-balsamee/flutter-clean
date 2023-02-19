import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {

  Future<NumberTrivia> getNumberTrivia(int number);
  Future<NumberTrivia> getRandomNumberTrivia();

}