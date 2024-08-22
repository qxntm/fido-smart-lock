import 'package:fido_smart_lock/component/atoms/background.dart';
import 'package:fido_smart_lock/component/atoms/capsule.dart';
import 'package:fido_smart_lock/component/atoms/label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LockLocationCustomize extends StatelessWidget {
  const LockLocationCustomize({super.key});
  static const List<String> lockLocation = [
    "Home",
    "Office",
    "Airbnbbbbb",
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      appBar: AppBar(title: MainHeaderLabel(label: '')),
      disabledTopPadding: true,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                HeaderLabel(
                  label: 'Customize Location',
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LockLocationCustomize()),
                    );
                  },
                  child: Icon(
                    CupertinoIcons.trash,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const Gap(10),
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: lockLocation.map((location) {
                return LocationCapsule(
                  location: location,
                  isCustomized: true,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}