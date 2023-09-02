import 'dart:async';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/src/core/safe_provider.dart';
import 'package:instagram_clone/src/models/users/user_model.dart';
import 'package:instagram_clone/src/modules/story/api/stories_api.dart';
import 'package:vrouter/vrouter.dart';
import '../../../utils/error_handler.dart';
import '../../../utils/error_template.dart';

class StoriesProvider extends SafeProvider with ErrorHandler {
  final BuildContext context;
  final String userId;
  late final UserModel user;
  bool isLoadingStories = true;
  bool indicatorsVisible = true;

  void showIndicators (LongPressEndDetails details) {
    indicatorsVisible = true;
    notifyListeners();
    resumeStoryTimer();
  }

  void hideIndicators (LongPressStartDetails details) {
    indicatorsVisible = false;
    notifyListeners();
    storyTimer?.cancel();
  }

  final _storiesApi = StoriesApiMock();

  StoriesProvider({required this.context, required this.userId}) {
    initComments();
  }

  Future<void> initComments() async {
    fetchStories();
  }

  Future<void> fetchStories() async {
    isLoadingStories = true;
    notifyListeners();
    try {
      user = await _storiesApi.getUserStories(
        userId,
      );
    } on ApiError catch (e) {
      showError(context, e);
    }
    isLoadingStories = false;
    user.stories.first.seen = true;
    notifyListeners();
    startStoryTimer();
  }

  int storyIndex = 0;
  void onStoryChanged(int index, CarouselPageChangedReason reason) {
    storyIndex = index;
    user.stories[index].seen = true;
    notifyListeners();
    storyTimer!.cancel();
    startStoryTimer();
  }

  final CarouselController storiesController = CarouselController();

  Timer? storyTimer;
  double storyProgressValue = 0;
  void startStoryTimer(){
    storyProgressValue = 0;
    notifyListeners();
    storyTimer?.cancel();
     storyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
       if (storyProgressValue < 1) {
         storyProgressValue += 1/15;
         notifyListeners();
         if(storyProgressValue >= 1){
           if(storyIndex + 1 < user.stories.length){
             storyTimer!.cancel();
             storiesController.nextPage();
           } else {
             storyTimer!.cancel();
             context.vRouter.pop();
           }
         }
       }
     });
  }

  void resumeStoryTimer(){
    storyProgressValue += 1/15;
    storyTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
       if (storyProgressValue < 1) {
         storyProgressValue += 1/15;
         notifyListeners();
         if(storyProgressValue >= 1){
           if(storyIndex + 1 < user.stories.length){
             storyTimer!.cancel();
             storiesController.nextPage();
           } else {
             storyTimer!.cancel();
             context.vRouter.pop();
           }
         }
       }
     });
  }

  @override
  void dispose() {
    storyTimer?.cancel();
    super.dispose();
  }


  void nextStory() {
    if(storyIndex + 1 < user.stories.length){
      storyTimer!.cancel();
      storiesController.nextPage();
    } else {
      storyTimer!.cancel();
      context.vRouter.pop();
    }
  }
}
