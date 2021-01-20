import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:random_quote/repositories/repository.dart';
import 'package:random_quote/models/models.dart';
import 'package:random_quote/bloc/bloc.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final QuoteRepository repository;

  QuoteBloc({@required this.repository})
      : assert(repository != null),
        super(QuoteEmpty());

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    if (event is FetchQuote) {
      yield QuoteLoading();
      try {
        final Quote quote = await repository.fetchQuote();
        yield QuoteLoaded(quote: quote);
      } catch (_) {
        yield QuoteError();
      }
    }
  }
}
