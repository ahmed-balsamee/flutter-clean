import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean/features/number_trivia/domain/use_cases/get_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_number_trivia_test.mocks.dart';


void main(){
  GetNumberTrivia? useCase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;

  setUp((){
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetNumberTrivia(mockNumberTriviaRepository!);
  });
  const tNumber = 1;
  const tNumberTrivia = NumberTrivia(number: 1, text: 'test');

  test(
    'should get trivia for the number from the repository',
        () async {

      // Arrange
          when(mockNumberTriviaRepository!.getNumberTrivia(any))
              .thenAnswer((_) async => tNumberTrivia);
      //Act
      final result = await useCase!(const Params(number: tNumber));

      //Assert
      expect(result, tNumberTrivia);
      // Verify that the method has been called on the Repository
      verify(mockNumberTriviaRepository!.getNumberTrivia(tNumber));
      // Only the above method should be called and nothing more.
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );





}