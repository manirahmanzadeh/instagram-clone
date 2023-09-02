import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instagram_clone/src/components/post/display/image_display.dart';
import 'package:instagram_clone/src/components/post/share_list/share_list_bottomsheet.dart';
import 'package:instagram_clone/src/models/media_model.dart';
import 'package:vrouter/vrouter.dart';

import '../../../models/users/user_model.dart';
import '../indicators/post_indicators.dart';
import 'video_display.dart';

class PostDisplay extends StatefulWidget {
  const PostDisplay({
    Key? key,
    required this.medias,
    required this.muteUnMute,
    required this.soundOpen,
    required this.indicatorsDisplayed,
    required this.displayIndicators,
    required this.likeUnlikePost,
    required this.liked,
    required this.saved,
    required this.saveUnSavePost,
    required this.refreshUsers,
    required this.usersPagingController,
    required this.postId, required this.postAspectRatio,
  }) : super(key: key);
  final String postId;
  final List<MediaModel> medias;
  final void Function() muteUnMute;
  final bool soundOpen;
  final bool liked;
  final bool saved;
  final bool indicatorsDisplayed;
  final Future<void> Function() displayIndicators;
  final Future<void> Function() likeUnlikePost;
  final Future<void> Function() saveUnSavePost;
  final void Function() refreshUsers;
  final PagingController<int, UserModel> usersPagingController;
  final double postAspectRatio;

  @override
  State<PostDisplay> createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay>
    with SingleTickerProviderStateMixin {
  int _current = 0;

  final CarouselController carouselController = CarouselController();

  late AnimationController _likeAnimationController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _likeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _likeAnimationController,
      curve: Curves.bounceOut,
    ));
    _likeAnimationController.addListener(() {
      setState(() {});
    });

    _likeAnimationController.addStatusListener((status) {
      switch (status) {
        case AnimationStatus.forward:
          break;
        case AnimationStatus.completed:
          _likeAnimationController.reverse();
          break;
        case AnimationStatus.reverse:
          break;
        case AnimationStatus.dismissed:
          break;
      }
    });
    super.initState();
  }

  void like() {
    if (!widget.liked) {
      _likeAnimationController.forward();
    }
    widget.likeUnlikePost();
  }

  @override
  void dispose() {
    _likeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                GestureDetector(
                  onDoubleTap: like,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enlargeCenterPage: false,

                      aspectRatio: widget.postAspectRatio,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                        widget.displayIndicators();
                      },
                    ),
                    carouselController: carouselController,
                    items: widget.medias.map((e) {
                      if (e.fileType == FileType.image) {
                        return ImageDisplay(image: e.file.file);
                      } else {
                        return VideoDisplay(
                          video: e.file.file,
                          muteUnMute: widget.muteUnMute,
                          soundOpen: widget.soundOpen,
                          displayIndicators: widget.displayIndicators,
                          soundIndicatorDisplay: widget.indicatorsDisplayed,
                        );
                      }
                    }).toList(),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/post/like_filled_white.svg',
                  width: _likeAnimation.value * 100,
                  height: _likeAnimation.value * 100,
                ),
              ],
            ),
            if (widget.medias.length > 1)
              PostIndicators(
                totalPages: widget.medias.length,
                currentPageIndex: _current,
                soundOn: widget.soundOpen,
                displayed: widget.indicatorsDisplayed,
              ),
          ],
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: like,
                    child: widget.liked
                        ? SvgPicture.asset(
                            'assets/icons/post/like_filled.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/post/like_outlined.svg',
                          ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: openComments,
                    child: SvgPicture.asset(
                      'assets/icons/post/comment.svg',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () => send(context),
                    child: SvgPicture.asset(
                      'assets/icons/post/send.svg',
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  InkWell(
                    onTap: widget.saveUnSavePost,
                    child: widget.saved
                        ? SvgPicture.asset(
                            'assets/icons/post/save_filled.svg',
                          )
                        : SvgPicture.asset(
                            'assets/icons/post/save_outlined.svg',
                          ),
                  ),
                ],
              ),
              if (widget.medias.length > 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.medias
                      .map(
                        (e) => Container(
                          height: 5,
                          width: 5,
                          margin: const EdgeInsets.symmetric(horizontal: 1),
                          decoration: BoxDecoration(
                            color: _current == widget.medias.indexOf(e)
                                ? Colors.blue
                                : Colors.black38,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }

  void send(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => ShareListBottomSheet(
        usersPagingController: widget.usersPagingController,
        refreshUsers: widget.refreshUsers,
      ),
    );
  }

  void openComments() {
    context.vRouter.to('comments/${widget.postId}');
  }
}
