import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/news_card.dart';
import 'widgets/news_shimmer_card.dart';
import '../../bloc/news_bloc.dart';
import '../../bloc/news_event.dart';
import '../../bloc/news_state.dart';

class NewsFeed extends StatelessWidget {
  const NewsFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
        NewsBloc(RepositoryProvider.of(context))..add(FetchNews()),
        child: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoading) {
              return ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const NewsShimmerCard();
                },
              );
            } else if (state is NewsLoaded) {
              return ListView.builder(
                itemCount: state.news.length,
                itemBuilder: (context, index) {
                  final news = state.news[index];
                  return NewsCard(
                    imageUrl: news.urlToImage,
                    title: news.title,
                    authors: news.author,
                    date: news.publishedAt,
                    description: news.description,
                    content: news.content,
                    articleUrl: news.articleUrl,
                  );
                },
              );
            } else if (state is NewsError) {
              return Center(child: Text("There was some error loading the news. Please check if you are connected to the internet."));
            }
            return const Center(child: Text('No news available.'));
          },
        ),
      ),
    );
  }
}
