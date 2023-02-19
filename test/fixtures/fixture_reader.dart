import 'dart:io';

String readFixture({required String fileName}) => File("test/fixtures/$fileName").readAsStringSync();


