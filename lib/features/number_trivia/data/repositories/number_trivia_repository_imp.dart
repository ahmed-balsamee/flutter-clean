import 'package:flutter_clean/core/error/exceptions.dart';
import 'package:flutter_clean/core/error/failures.dart';
import 'package:flutter_clean/core/platform/network_info.dart';
import 'package:flutter_clean/features/number_trivia/data/local/data_source/number_trivia_local_data_source.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/data_source/number_trivia_remote_data_source.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/models/number_trivia_model.dart';
import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class NumberTriviaRepositoryImp implements NumberTriviaRepository {
  NumberTriviaRemoteDataSource remoteDataSource;
  NumberTriviaLocalDataSource localDataSource;
  NetworkInfo networkInfo;

  NumberTriviaRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<NumberTrivia> getNumberTrivia(int number) async {
    NumberTriviaModel remoteNumberTriviaData;
    if (await networkInfo.isConnected){

      try {
        remoteNumberTriviaData = await remoteDataSource.getNumberTrivia(number);
        localDataSource.cacheNumberTrivia(remoteNumberTriviaData);
      }
      on ServerException {
        throw ServerFailure();
      }
      return remoteNumberTriviaData;
    }
    else {
      return await localDataSource.getLastNumberTrivia(number);
    }


  }

  @override
  Future<NumberTrivia> getRandomNumberTrivia() {
    // TODO: implement getRandomNumberTrivia
    throw UnimplementedError();
  }

}