import 'package:equatable/equatable.dart';
import 'package:kombee_task/core/utils/helpers/api_status.dart';
import 'package:kombee_task/data/models/bottom_repo_model.dart';
import 'package:kombee_task/data/models/middle_repo_model.dart';
import 'package:kombee_task/data/models/top_repo_model.dart';

class HomepageState extends Equatable {
  String? message;
  ApiStatus topApiStatus;
  ApiStatus middleApiStatus;
  ApiStatus bottomApiStatus;
  TopRepoModel? topRepoModel;
  MiddleRepoModel? middleRepoModel;
  BottomRepoModel? bottomRepoModel;
  int? selectedIndex;

  HomepageState({
    this.message,
    this.topApiStatus = ApiStatus.initial,
    this.middleApiStatus = ApiStatus.initial,
    this.bottomApiStatus = ApiStatus.initial,
    this.topRepoModel,
    this.selectedIndex = 0,
    this.bottomRepoModel,
    this.middleRepoModel,
  });

  HomepageState copyWith({
    String? message,
    ApiStatus? topApiStatus,
    ApiStatus? middleApiStatus,
    ApiStatus? bottomApiStatus,
    TopRepoModel? topRepoModel,
    MiddleRepoModel? middleRepoModel,
    BottomRepoModel? bottomRepoModel,
    int? selectedIndex,
  }) {
    return HomepageState(
      topApiStatus: topApiStatus ?? this.topApiStatus,
      middleApiStatus: middleApiStatus ?? this.middleApiStatus,
      bottomApiStatus: bottomApiStatus ?? this.bottomApiStatus,
      message: message ?? this.message,
      topRepoModel: topRepoModel ?? this.topRepoModel,
      middleRepoModel: middleRepoModel ?? this.middleRepoModel,
      bottomRepoModel: bottomRepoModel ?? this.bottomRepoModel,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }

  @override
  List<Object?> get props => [
    topApiStatus,
    middleApiStatus,
    bottomApiStatus,
    message,
    topRepoModel,
    selectedIndex,
    middleRepoModel,
    bottomRepoModel,
  ];
}
