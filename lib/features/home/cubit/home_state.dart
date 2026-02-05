part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.everythingStatus = RequestStatusEnum.loading,
    this.topHeadLineStatus = RequestStatusEnum.loading,
    this.newsTopHeadLineList = const [],
    this.newsEverythingList = const [],
    this.errorMessage,
    this.selectedCategories,
  });

  final List<NewsArticlesModel> newsTopHeadLineList;
  final List<NewsArticlesModel> newsEverythingList;
  final RequestStatusEnum everythingStatus;

  final RequestStatusEnum topHeadLineStatus;

  final String? errorMessage;
  final String? selectedCategories;

  HomeState copyWith({
    List<NewsArticlesModel>? newsTopHeadLineList,
    List<NewsArticlesModel>? newsEverythingList,
    RequestStatusEnum? everythingStatus,
    RequestStatusEnum? topHeadLineStatus,
    String? errorMessage,
    String? selectedCategories,
  }) {
    return HomeState(
      newsTopHeadLineList: newsTopHeadLineList ?? this.newsTopHeadLineList,
      newsEverythingList: newsEverythingList ?? this.newsEverythingList,
      everythingStatus: everythingStatus ?? this.everythingStatus,
      topHeadLineStatus: topHeadLineStatus ?? this.topHeadLineStatus,
      errorMessage: errorMessage ,
      selectedCategories: selectedCategories ?? this.selectedCategories,
    );
  }

  @override
  List<Object?> get props => [
    newsTopHeadLineList,
    newsEverythingList,
    everythingStatus,
    topHeadLineStatus,
    errorMessage,
    selectedCategories,
  ];
}
