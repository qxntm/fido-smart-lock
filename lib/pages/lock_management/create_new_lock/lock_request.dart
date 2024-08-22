import 'package:fido_smart_lock/component/atoms/background.dart';
import 'package:fido_smart_lock/component/atoms/button.dart';
import 'package:fido_smart_lock/component/atoms/label.dart';
import 'package:fido_smart_lock/component/atoms/people.dart';
import 'package:fido_smart_lock/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class RequestAccess extends StatelessWidget {
  const RequestAccess({super.key});

  static final List<Map<String, String>> data = [
    {
      'img': 'https://i.postimg.cc/1tD3M3D2/front-Door.png',
      'name': 'Front Door',
      'role': 'Admin',
    },
    {
      'img': 'https://i.postimg.cc/BbMswLbY/living-Room.png',
      'name': 'Living Room',
      'role': 'Admin'
    },
    // Add more data as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      appBar: AppBar(
        title: MainHeaderLabel(label: 'Request Access'),
      ),
      disabledTopPadding: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Label(
            label:
                'By proceeding, this request will notify the admin of the lock in the following list',
          ),
          const Gap(20),
          SizedBox(
            height: 550.0, // Set the height of the ListView
            child: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 15);
              },
              itemBuilder: (BuildContext context, int index) {
                final item = data[index];
                return Person(
                  name: item['name']!,
                  img: item['img']!,
                  role: item['role']!,
                );
              },
            ),
          ),
          Gap(20),
          Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  SubLabel(
                    label:
                        'You can only have an access to the lock as an ‘invited guest’ if you want to be a ‘member’ please contact the admin of the lock directly.',
                    color: Colors.grey,
                    isCenter: true,
                  ),
                  Gap(15),
                  Button(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestSend(),
                        ),
                      );
                    },
                    label: 'Proceed',
                    color: Colors.green,
                  )
                ],
              ))
        ],
      ),
    );
  }
}

class RequestSend extends StatelessWidget {
  const RequestSend({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
        appBar: AppBar(
          title: MainHeaderLabel(label: 'Request Access'),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Gap(130),
              Transform.scale(
                  scale: 2.3,
                  child: Lottie.network(
                    'https://lottie.host/47234022-509e-409a-a8c9-e6da53f5ca3b/B1wGjwm0U4.json',
                  )),
              HeaderLabel(label: 'Request Send!'),
              Gap(250),
              Button(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(initialIndex: 0),
                      ),
                    );
                  },
                  label: 'Woohoo!')
            ],
          ),
        ));
  }
}