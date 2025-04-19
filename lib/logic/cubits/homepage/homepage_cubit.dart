import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kombee_task/core/utils/helpers/api_status.dart';
import 'package:kombee_task/data/repositories/homepage_repo/home_repo.dart';
import 'package:meta/meta.dart';

import 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomeRepo repo;

  HomepageCubit({required this.repo}) : super(HomepageState());

  updateSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  fetchTopItems() async {
    emit(state.copyWith(topApiStatus: ApiStatus.loading));
    try {
      var response = await repo.fetchTopItems();
      if (response.status == "18") {
        emit(
          state.copyWith(
            topApiStatus: ApiStatus.success,
            topRepoModel: response,
          ),
        );
      } else {
        emit(state.copyWith(topApiStatus: ApiStatus.failed));
      }
    } catch (e) {
      print("Error in fetchTopItems: $e");
      emit(state.copyWith(topApiStatus: ApiStatus.failed));
    }
  }

  fetchMiddleItems() async {
    emit(state.copyWith(middleApiStatus: ApiStatus.loading));
    try {
      var response = await repo.fetchMiddleItems();
      if (response.status == "14") {
        emit(
          state.copyWith(
            middleApiStatus: ApiStatus.success,
            middleRepoModel: response,
          ),
        );
      } else {
        emit(state.copyWith(middleApiStatus: ApiStatus.failed));
      }
    } catch (e) {
      print("Error in fetchTopItems: $e");
      emit(state.copyWith(middleApiStatus: ApiStatus.failed));
    }
  }

  fetchBottomItems() async {
    emit(state.copyWith(bottomApiStatus: ApiStatus.loading));
    try {
      var response = await repo.fetchBottomItems();
      if (response.status == "18") {
        emit(
          state.copyWith(
            bottomApiStatus: ApiStatus.success,
            bottomRepoModel: response,
          ),
        );
      } else {
        emit(state.copyWith(bottomApiStatus: ApiStatus.failed));
      }
    } catch (e) {
      print("Error in fetchTopItems: $e");
      emit(state.copyWith(bottomApiStatus: ApiStatus.failed));
    }
  }
}
