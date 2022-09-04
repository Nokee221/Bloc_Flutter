import 'package:bloc_flutter/bloc/bloc_actions.dart';
import 'package:bloc_flutter/bloc/person.dart';
import 'package:bloc_flutter/bloc/persons_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

const mockedPersons1 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

const mockedPersons2 = [
  Person(name: 'Foo', age: 20),
  Person(name: 'Bar', age: 30),
];

Future<Iterable<Person>> mockGetPersons1(String _) =>
    Future.value(mockedPersons1);
Future<Iterable<Person>> mockGetPersons2(String _) =>
    Future.value(mockedPersons2);

void main() {
  group('Testing bloc', () {
    //write our test
    late PersonsBloc bloc;

    setUp(() {
      bloc = PersonsBloc();
    });

    blocTest<PersonsBloc, FetchResult?>(
      'Test inital state',
      build: () => bloc,
      verify: (bloc) => expect (bloc.state , null),
    );

    //Fetch  mock data (person1) and compare it with FetchResult
    blocTest<PersonsBloc, FetchResult?>(
      'Mock retriving persons from first iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(url: 'dummy_url_1', loader: mockGetPersons1),
        );
        bloc.add(
          const LoadPersonsAction(url: 'dummy_url_1', loader: mockGetPersons1),
        );
        expect: () => [
          const FetchResult(persons: mockedPersons1, isRetriveFromCache: false),
          const FetchResult(persons: mockedPersons1, isRetriveFromCache: true)
        ];
      },
    );

    //Fetch  mock data (person2) and compare it with FetchResult

     blocTest<PersonsBloc, FetchResult?>(
      'Mock retriving persons from second iterable',
      build: () => bloc,
      act: (bloc) {
        bloc.add(
          const LoadPersonsAction(url: 'dummy_url_2', loader: mockGetPersons2),
        );
        bloc.add(
          const LoadPersonsAction(url: 'dummy_url_2', loader: mockGetPersons2),
        );
        expect: () => [
          const FetchResult(persons: mockedPersons2, isRetriveFromCache: false),
          const FetchResult(persons: mockedPersons2, isRetriveFromCache: true)
        ];
      },
    );
  });
}
