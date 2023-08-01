import 'package:brush/screen/gifts/widget/gitt_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReceivedGift extends StatelessWidget {
  ReceivedGift({super.key});
  final List<String> images = [
    'assets/icons/Group 2220.png',
    'assets/icons/Group 2221.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: SizedBox(
        height: 1.sh,
        child: ListView.builder(
            itemCount: images.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GiftBox(
                onTap: () {},
                totalLength: images.length,
                index: index,
                image: 'assets/icons/Group 2220.png',
                title: 'ارسل اليك احمد هدية بخصم 100%',
                giftCode: '#123456',
              );
            }),
      ),
    );
  }
}
