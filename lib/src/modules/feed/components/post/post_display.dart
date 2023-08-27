import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/src/modules/feed/components/post/image_display.dart';
import '../../../../models/post/post_file_model.dart';
import 'video_display.dart';

class PostDisplay extends StatefulWidget {
  const PostDisplay({Key? key, required this.images, required this.muteUnMute, required this.soundOpen,}) : super(key: key);
  final List<PostFileModel> images;
  final void Function() muteUnMute;
  final bool soundOpen;

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
                },
              ),
              carouselController: carouselController,
              items: widget.images
                  .map(
                    (e) {
                      if(e.fileType == FileType.image){
                        return ImageDisplay(image: e.file.file);
                      } else {
                        return VideoDisplay(video: e.file.file, muteUnMute: widget.muteUnMute, soundOpen: widget.soundOpen,);
                      }
                    }
                  )
                  .toList(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black54,
              ),
              child: Text(
                '${_current + 1}/${widget.images.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            )
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images
                    .map(
                      (e) => Container(
                        height: 5,
                        width: 5,
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        decoration: BoxDecoration(
                          color: _current == widget.images.indexOf(e)
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
