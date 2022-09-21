import 'package:flutter_bloc_apiexample/models/covid_model.dart';
import 'package:flutter_bloc_apiexample/resources/api_provider.dart';

class ApiRepostory{
  final _provider = ApiProvider();

  Future<CovidModel> fetchCovidList(){
    return _provider.fetchCovidList();
  }

}

class NetworkError extends Error{}