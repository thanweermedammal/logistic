import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget bannerSlider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.easeInOutCirc,
        enableInfiniteScroll: true,
        // enlargeCenterPage: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 400),
        viewportFraction: 0.75,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              clipBehavior: Clip.antiAlias,
              width: MediaQuery.of(context).size.width,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/banner.jpg',
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    ),
  );
}
