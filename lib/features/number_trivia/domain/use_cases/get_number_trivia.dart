import 'package:equatable/equatable.dart';
import 'package:flutter_clean/core/use_cases/use_cases.dart';
import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetNumberTrivia implements UseCase<NumberTrivia, Params> {

  final NumberTriviaRepository repository;

  GetNumberTrivia(this.repository);

  @override
  Future<NumberTrivia> call(Params params) async {

    return await repository.getNumberTrivia(params.number);
  }

}

class Params extends Equatable {

  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];

}