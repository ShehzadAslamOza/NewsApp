import 'package:flutter_bloc/flutter_bloc.dart';
import '../repositories/news_repository.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc(this.newsRepository) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final news = await newsRepository.fetchNews();
        emit(NewsLoaded(news));
      } catch (e) {
        emit(NewsError('Failed to fetch news: $e'));
      }
    });
  }
}
