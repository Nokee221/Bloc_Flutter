part of 'covid_bloc_bloc.dart';

abstract class CovidBlocState extends Equatable {
  const CovidBlocState();
  
  @override
  List<Object> get props => [];
}

class CovidBlocInitial extends CovidBlocState {}
class CovidBlocLoading extends CovidBlocState {}

class CovidBlocLoaded extends CovidBlocState {
  final CovidModel covidModel;

  const CovidBlocLoaded(this.covidModel);
}

class CovidBlocError extends CovidBlocState {
  final String? message;

  const CovidBlocError(this.message);
}
