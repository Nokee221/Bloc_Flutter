import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_apiexample/resources/api_repository.dart';

import '../../models/covid_model.dart';

part 'covid_bloc_event.dart';
part 'covid_bloc_state.dart';

class CovidBlocBloc extends Bloc<CovidBlocEvent, CovidBlocState> {
  CovidBlocBloc() : super(CovidBlocInitial()) {
    final ApiRepostory _apiRepository = ApiRepostory();

    on<CovidBlocEvent>((event, emit) async{
      try{
        emit(CovidBlocLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(CovidBlocLoaded(mList));
        if(mList.error != null)
        {
          emit(CovidBlocError(mList.error));
        }
      } on NetworkError{
        emit(const CovidBlocError("Failed to fetch data. is your device online?"));
      }
    });
  }
}
