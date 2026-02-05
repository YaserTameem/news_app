import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.newsRepository) : super(HomeState()) {
    getTopHeadLine();
    getEverything();
  }

  final BaseNewsRepository newsRepository;

  getTopHeadLine({String? category}) async {
    try {
      emit(state.copyWith(topHeadLineStatus: RequestStatusEnum.loading));
      final articles = await newsRepository.getTopHeadLine(selectedCategories: state.selectedCategories);
      emit(
        state.copyWith(
          newsTopHeadLineList: articles,
          topHeadLineStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(topHeadLineStatus: RequestStatusEnum.error, errorMessage: e.toString()));
    }
  }

  getEverything() async {
    try {
      final articles = await newsRepository.getEverything();
      emit(
        state.copyWith(
          newsEverythingList: articles,
          everythingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), everythingStatus: RequestStatusEnum.error));
    }
  }

  void updateSelectedCategories(String category) {
    emit(state.copyWith(selectedCategories: category));
    getTopHeadLine(category: state.selectedCategories);
  }
}
