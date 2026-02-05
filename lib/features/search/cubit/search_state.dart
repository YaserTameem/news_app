part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<NewsArticlesModel> newsEverythingList;

  final String? errorMessage;
  final RequestStatusEnum everythingStatus;

  const SearchState({
    this.newsEverythingList = const [],
    this.errorMessage,
    this.everythingStatus = RequestStatusEnum.loading,
  });

  SearchState copyWith({
    List<NewsArticlesModel>? newsEverythingList,
    String? errorMessage,
    RequestStatusEnum? everythingStatus,
  }) {
    return SearchState(
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      errorMessage: errorMessage,
      everythingStatus: everythingStatus ?? this.everythingStatus,
    );
  }

  @override
  List<Object?> get props => [newsEverythingList, errorMessage, everythingStatus];
}
