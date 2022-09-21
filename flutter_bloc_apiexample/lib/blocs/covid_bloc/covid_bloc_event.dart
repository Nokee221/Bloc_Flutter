part of 'covid_bloc_bloc.dart';

abstract class CovidBlocEvent extends Equatable {
  const CovidBlocEvent();

  @override
  List<Object> get props => [];
}

class GetCovidList extends CovidBlocEvent{}
