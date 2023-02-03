import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:poimen/services/cloudinary_service.dart';

class AttendanceImageCarousel extends StatelessWidget {
  const AttendanceImageCarousel({
    Key? key,
    required this.membersPicture,
  }) : super(key: key);

  final List<String> membersPicture;

  @override
  Widget build(BuildContext context) {
    final numberOfPictures = membersPicture.length;
    final isSingle = numberOfPictures == 1;

    return CarouselSlider(
      options: CarouselOptions(
        height: MediaQuery.of(context).size.width > 500 ? 500.0 : 200.0,
        autoPlay: isSingle ? false : true,
        enableInfiniteScroll: isSingle ? false : true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      items: membersPicture.map((picture) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: const BoxDecoration(
                color: Color.fromARGB(112, 69, 49, 72),
              ),
              child: Image.network(
                CloudinaryImage(url: picture, size: ImageSize.fixedHeight).url,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }

                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
