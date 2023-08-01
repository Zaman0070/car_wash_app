import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class SliderBox extends StatefulWidget {
  const SliderBox({
    super.key,
  });

  @override
  State<SliderBox> createState() => _SliderBoxState();
}

class _SliderBoxState extends State<SliderBox> {
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  List<String> imageBanner = [
    'assets/icons/Group 2220.png',
    'assets/icons/Group 2221.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.18,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Swiper(
                  autoplay: true,
                  outer: false,
                  indicatorLayout: PageIndicatorLayout.NONE,
                  itemBuilder: (context, index) {
                    return Image.asset(imageBanner[index], fit: BoxFit.cover);
                  },
                  onIndexChanged: (value) {
                    setState(() {
                      _current = value;
                    });
                  },
                  layout: SwiperLayout.DEFAULT,
                  itemCount: imageBanner.length,
                  pagination: const SwiperPagination(
                      builder: SwiperPagination(
                    builder: DotSwiperPaginationBuilder(
                        color: Colors.transparent,
                        activeColor: Colors.transparent,
                        size: 10,
                        activeSize: 10),
                  )),
                  control: SwiperControl(
                    color: Colors.black.withOpacity(0.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(imageBanner, (value, url) {
            return Container(
              width: _current == value ? 35.0 : 35,
              height: _current == value ? 4.0 : 4,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              decoration: BoxDecoration(
                border: Border.all(color: appColor),
                borderRadius: BorderRadius.circular(20),
                color: _current == value ? appColor : Colors.transparent,
              ),
            );
          }),
        ),
      ],
    );
  }
}
