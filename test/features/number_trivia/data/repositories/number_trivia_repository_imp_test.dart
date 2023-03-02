import 'package:flutter_clean/core/error/exceptions.dart';
import 'package:flutter_clean/core/error/failures.dart';
import 'package:flutter_clean/core/platform/network_info.dart';
import 'package:flutter_clean/features/number_trivia/data/local/data_source/number_trivia_local_data_source.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/data_source/number_trivia_remote_data_source.dart';
import 'package:flutter_clean/features/number_trivia/data/remote/models/number_trivia_model.dart';
import 'package:flutter_clean/features/number_trivia/data/repositories/number_trivia_repository_imp.dart';
import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([
  MockSpec<NumberTriviaRemoteDataSource>(),
  MockSpec<NumberTriviaLocalDataSource>(),
  MockSpec<NetworkInfo>()
])
import "number_trivia_repository_imp_test.mocks.dart";


void main (){
  MockNumberTriviaRemoteDataSource? mockRemoteDataSource;
  MockNumberTriviaLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;
  NumberTriviaRepositoryImp? numberTriviaRepositoryImp;

  setUp(() {
    //Arrange
    mockRemoteDataSource = MockNumberTriviaRemoteDataSource();
    mockLocalDataSource = MockNumberTriviaLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    numberTriviaRepositoryImp = NumberTriviaRepositoryImp(
        remoteDataSource: mockRemoteDataSource!,
        localDataSource: mockLocalDataSource!,
        networkInfo: mockNetworkInfo!);
  });

  group("getConcreteNumberTrivia", () {
    //Arrange
    const int testNumber = 1;
    const testNumberTriviaModel = NumberTriviaModel(text: "test text", number:  testNumber);
    const NumberTrivia testNumberTrivia = testNumberTriviaModel;

    test("Test If network is connected", () async {
      when(mockNetworkInfo?.isConnected).thenAnswer((realInvocation) async => true);

      await numberTriviaRepositoryImp?.getNumberTrivia(testNumber);

      verify(mockNetworkInfo?.isConnected);

    });

    group("Device is online", () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      }
      );
      test("should return remote data when the call to remote data source is successful", () async {
        //Arrange
        when(mockRemoteDataSource!.getNumberTrivia(testNumber)).thenAnswer((_)  async => testNumberTriviaModel);
        //act
        NumberTrivia result = await numberTriviaRepositoryImp!.getNumberTrivia(testNumber);
        //assert
        verify(mockNetworkInfo?.isConnected);
        verify(mockRemoteDataSource!.getNumberTrivia(testNumber));
        expect(result, equals(testNumberTrivia));
      });
      test("should cache data locally when the call to remote data source is successful", () async {
        //Arrange
        when(mockRemoteDataSource!.getNumberTrivia(testNumber)).thenAnswer((_)  async => testNumberTriviaModel);
        //act
        await numberTriviaRepositoryImp!.getNumberTrivia(testNumber);
        //assert
        verify(mockNetworkInfo?.isConnected);
        verify(mockRemoteDataSource!.getNumberTrivia(testNumber));
        verify(mockLocalDataSource?.cacheNumberTrivia(testNumberTriviaModel));
      });

      test("should return server failure when call to remote data source is unsuccessful", () async {
        //Arrange
        when(mockRemoteDataSource!.getNumberTrivia(testNumber)).thenThrow(ServerException());

        verifyZeroInteractions(mockLocalDataSource);
        //assert
        expect(numberTriviaRepositoryImp?.getNumberTrivia(testNumber), throwsA(isA<ServerFailure>()));
      });

    });

    group("Device is offline", () {
      setUp(() {
        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
      }
      );

      test("Should return last locally cached data when the cached data is present", ()async{

        when(mockNetworkInfo!.isConnected).thenAnswer((_) async => false);
        when(mockLocalDataSource!.getLastNumberTrivia(testNumber)).thenAnswer((realInvocation) async => testNumberTriviaModel);

        final result = numberTriviaRepositoryImp?.getNumberTrivia(testNumber);

        verifyZeroInteractions(mockRemoteDataSource);
        verify(mockLocalDataSource?.getLastNumberTrivia(testNumber));

        expect(await mockNetworkInfo?.isConnected, false);
        expect(result, testNumberTrivia);

      });

    });
  });
}