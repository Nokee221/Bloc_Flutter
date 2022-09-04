import 'package:bloc_flutter/bloc/bloc_actions.dart';
import 'package:bloc_flutter/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart';

extension IsEqualToIgnoringOrdering<T> on Iterable<T> {
  bool isEqualToIgnoringOrdering(Iterable<T> other) =>
      length == other.length &&
      {...this}.intersection({...other}).length == length;
}

@immutable
class FetchResult {
  final Iterable<Person> persons;
  final bool isRetriveFromCache;

  const FetchResult({required this.persons, required this.isRetriveFromCache});

  @override
  String toString() =>
      'FetchResult (isRetrivedFromCache = $isRetriveFromCache, person = $persons)';

  
  @override bool operator == (covariant FetchResult other) => persons.isEqualToIgnoringOrdering(other.persons) && isRetriveFromCache == other.isRetriveFromCache;

  @override int get hashCode => Object.hash(persons, isRetriveFromCache);
}



class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, Iterable<Person>> _cache = {};
  PersonsBloc() : super(null) {
    on<LoadPersonsAction>(
      (event, emit) async {
        final url = event.url;
        if (_cache.containsKey(url)) {
          final cachedPersons = _cache[url]!;
          final result =
              FetchResult(persons: cachedPersons, isRetriveFromCache: true);
          emit(result);
        } else {
          final loader = event.loader;
          final persons = await loader(url);
          _cache[url] = persons;
          final result =
              FetchResult(persons: persons, isRetriveFromCache: false);
          emit(result);
        }
      },
    );
  }
}