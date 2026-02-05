import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_articles_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.newsRepository) : super(SearchState());
  final TextEditingController searchTextEditingController = TextEditingController();
  final BaseNewsRepository newsRepository;

  getEverything() async {
    try {
      emit(
        state.copyWith(
          newsEverythingList: await newsRepository.getEverything(
            query: searchTextEditingController.text,
          ),
          everythingStatus: RequestStatusEnum.loaded,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString(), everythingStatus: RequestStatusEnum.error));
    }
  }
}
