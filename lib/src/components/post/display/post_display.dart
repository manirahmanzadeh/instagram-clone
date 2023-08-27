import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/src/components/post/display/image_display.dart';
import 'package:instagram_clone/src/models/post/media_model.dart';
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
  }) : super(key: key);
  final List<MediaModel> medias;
  final void Function() muteUnMute;
  final bool soundOpen;
  final bool indicatorsDisplayed;
  final Future<void> Function() displayIndicators;

  @override
  State<PostDisplay> createState() => _PostDisplayState();
}

class _PostDisplayState extends State<PostDisplay> {
  int _current = 0;

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.topRight,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                height: 357,
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
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/feed/post-like.svg'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/feed/comment.svg'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/feed/send.svg'),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  InkWell(
                    onTap: () {},
                    child: SvgPicture.asset('assets/icons/feed/save.svg'),
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
}
