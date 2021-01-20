import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:random_quote/bloc/bloc.dart';
import 'package:random_quote/repositories/quote_api_client.dart';
import 'package:random_quote/repositories/repository.dart';
import 'package:random_quote/views/home_page.dart';

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

void main() {
  Bloc.observer = SimpleBlocDelegate();

  final QuoteRepository repository = QuoteRepository(
    quoteApiClient: QuoteApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(MyApp(
    repository: repository,
  ));
}

class MyApp extends StatelessWidget {
  final QuoteRepository repository;

  MyApp({Key key, @required this.repository})
      : assert(repository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quote App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Quote'),
        ),
        body: BlocProvider(
          create: (context) => QuoteBloc(repository: repository),
          child: HomePage(),
        ),
      ),
    );
  }
}
