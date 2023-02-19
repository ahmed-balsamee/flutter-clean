import 'package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_clean/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_clean/features/number_trivia/domain/use_cases/get_number_trivia.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

class MockNumberTriviaRepository extends Mock implements NumberTriviaRepository {

  @override
  Future<NumberTrivia> getNumberTrivia(int number) async {
    return await super.noSuchMethod(Invocation.method(#getNumberTrivia, [number]),returnValue: const NumberTrivia(number: 1, text: 'test'));
  }
}

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
          when(mockNumberTriviaRepository!.getNumberTrivia(tNumber))
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