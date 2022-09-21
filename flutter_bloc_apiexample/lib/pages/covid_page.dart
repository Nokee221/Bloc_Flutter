import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_apiexample/blocs/covid_bloc/covid_bloc_bloc.dart';
import 'package:flutter_bloc_apiexample/models/covid_model.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);

  @override
  State<CovidPage> createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBlocBloc _newsBloc = CovidBlocBloc();

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Covid-19 List'),
      ),
      body: _buildListCovid(),
    );
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CovidBlocBloc, CovidBlocState>(
          listener: (context, state) {
            if (state is CovidBlocError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message!)));
            }
          },
          child: BlocBuilder<CovidBlocBloc, CovidBlocState>(
            builder: (context, state) {
              if (state is CovidBlocInitial) {
                return _buildLoading();
              } else if (state is CovidBlocLoading) {
                return _buildLoading();
              } else if (state is CovidBlocLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidBlocError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildCard(BuildContext context, CovidModel covidModel) {
    return ListView.builder(
      itemCount: covidModel.countries!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Country: ${covidModel.countries![index].country}"),
                  Text(
                      "Total Confirmed: ${covidModel.countries![index].totalConfirmed}"),
                  Text(
                      "Total Deaths: ${covidModel.countries![index].totalDeaths}"),
                  Text(
                      "Total Recovered: ${covidModel.countries![index].totalRecovered}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
