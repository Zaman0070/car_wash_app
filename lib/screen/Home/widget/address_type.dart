import 'package:brush/constant/app_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddressType extends StatefulWidget {
  int index;
  List<String> addressType;
  AddressType({super.key, required this.index, required this.addressType});

  @override
  State<AddressType> createState() => _AddressTypeState();
}

class _AddressTypeState extends State<AddressType> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        children: List.generate(
            widget.addressType.length,
            (index) => InkWell(
                  onTap: () {
                    setState(() {
                      widget.index = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              widget.index == index ? appColor : Colors.white,
                          border: Border.all(color: appColor, width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 14),
                        child: Text(
                          widget.addressType[index],
                          style: TextStyle(
                              color: widget.index == index
                                  ? Colors.white
                                  : appColor),
                        ),
                      ),
                    ),
                  ),
                )));
    // return Row(
    //   children: [
    //     InkWell(
    //       onTap: () {
    //         setState(() {
    //           widget.index = 0;
    //         });
    //       },
    //       child: Container(
    //         decoration: BoxDecoration(
    //             border: Border.all(color: appColor, width: 1.5),
    //             borderRadius: BorderRadius.circular(50)),
    //         child: Text(
    //           '1',
    //           style: TextStyle(color: appColor),
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
