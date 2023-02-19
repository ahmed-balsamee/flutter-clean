import "dart:convert";

import "package:flutter_clean/features/number_trivia/data/remote/models/number_trivia_model.dart";
import "package:flutter_clean/features/number_trivia/domain/entities/number_trivia.dart";
import "package:flutter_test/flutter_test.dart";

import "../../../../../fixtures/fixture_reader.dart";






void main (){
  const numberTriviaModel = NumberTriviaModel(text: "Test Text", number: 1);

  test("Should be a subclass of number trivia entity", () async {
    expect(numberTriviaModel, isA<NumberTrivia>());
  } );

group("fromJson", () {
  test("should return a valid model when the json number is an integer", () async {
    final Map<String, dynamic> jsonMap = jsonDecode(readFixture(fileName: "number_trivia.json"));
    final result = NumberTriviaModel.fromJson(jsonMap);
    expect(result, numberTriviaModel);
  });

  test("should return a valid model when the json number is regarded as double", () async {
    final Map<String, dynamic> jsonMap = jsonDecode(readFixture(fileName: "number_trivia_double.json"));
    final result = NumberTriviaModel.fromJson(jsonMap);
    expect(result, numberTriviaModel);
  });


});


}