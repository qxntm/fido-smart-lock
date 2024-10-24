import 'package:fido_smart_lock/component/button.dart';
import 'package:fido_smart_lock/component/date_picker.dart';
import 'package:fido_smart_lock/component/label.dart';
import 'package:fido_smart_lock/component/time_picker.dart';
import 'package:fido_smart_lock/helper/datetime.dart';
import 'package:fido_smart_lock/helper/size.dart';
import 'package:fido_smart_lock/helper/word.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

class Person extends StatelessWidget {
  final String? img;
  final String name;
  final String? role;
  final String? button;
  final String lockName;
  final String? date;
  final String? time;

  const Person({
    super.key,
    this.img,
    required this.name,
    this.role,
    this.button,
    required this.lockName,
    this.date,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, right: 15, top: 13, bottom: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.blueGrey[900], // Include color within BoxDecoration
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: responsive.radiusScale(23),
                backgroundImage: NetworkImage(img!),
              ),
              SizedBox(
                width: responsive.widthScale(7),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SubLabel(
                    label: truncateWithEllipsis(name, 20),
                    isBold: true,
                  ),
                  if (role != null && role != 'guest')
                    SmallLabel(
                      label: role!,
                      color: Colors.grey,
                    )
                  else if (role == 'guest')
                    XtraSmallLabel(
                      label: 'Exp: $date • $time',
                      color: Colors.grey,
                    )
                ],
              ),
            ],
          ),
          if (button == 'remove')
            CapsuleButton(
              label: 'Remove',
              onTap: () {
                WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) {
                    return [
                      WoltModalSheetPage(
                        hasTopBarLayer: false,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 80),
                          child: Column(children: [
                            SubLabel(
                              label:
                                  'Do you want to remove $name from $role of $lockName lock?',
                              isBold: true,
                              isCenter: true,
                            ),
                            if (role == 'member')
                              SmallLabel(
                                label: 'This action cannot be undone',
                                isCenter: true,
                                color: Colors.red,
                              )
                          ]),
                        ),
                        stickyActionBar: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: Navigator.of(context).pop,
                                  child: SmallLabel(label: 'Cancel')),
                              Gap(20),
                              CapsuleButton(
                                label: 'Proceed',
                                buttonColor: Colors.green,
                                labelColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ];
                  },
                  modalTypeBuilder: (context) {
                    return WoltModalType.dialog();
                  },
                );
              },
            )
          else if (button == 'invite')
            CapsuleButton(
              label: 'Invite',
              onTap: () {},
            )
        ],
      ),
    );
  }
}

class PersonRequest extends StatelessWidget {
  final String? img;
  final String name;
  final String? role;
  final String lockName;
  final String dateTime;

  const PersonRequest(
      {super.key,
      this.img,
      required this.name,
      this.role,
      required this.lockName,
      required this.dateTime});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);

    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 15, right: 20, top: 13, bottom: 13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(responsive.radiusScale(15)),
        color: Colors.blueGrey[900], // Include color within BoxDecoration
      ),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: responsive.radiusScale(23),
                  backgroundImage: NetworkImage(img!),
                ),
                const Gap(13),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubLabel(
                      label: name,
                      isBold: true,
                    ),
                    SmallLabel(
                      label: 'Request pending ${timeDifference(dateTime)}',
                      color: Colors.grey,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
                onTap: Navigator.of(context).pop,
                child: SmallLabel(
                  label: 'Decline',
                  color: Colors.red,
                )),
            Gap(20),
            CapsuleButton(
              label: 'Accept',
              buttonColor: Colors.green,
              labelColor: Colors.white,
              onTap: () {
                WoltModalSheet.show(
                  context: context,
                  pageListBuilder: (context) {
                    return [
                      WoltModalSheetPage(
                        hasTopBarLayer: false,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 30, 30, 80),
                          child: Column(
                            children: [
                              SubLabel(
                                label:
                                    'Do you want to accept $name request to unlock $lockName?',
                                isBold: true,
                                isCenter: true,
                              ),
                              SizedBox(
                                height: responsive.heightScale(5),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SubLabel(label: 'Expiration Date', color: Colors.white.withOpacity(0.75),),
                                        SizedBox(height: responsive.widthScale(3),),
                                        DatePickerWidget(),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SubLabel(label: 'Time', color: Colors.white.withOpacity(0.75)),
                                        SizedBox(height: responsive.widthScale(3),),
                                        TimePickerWidget(),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        stickyActionBar: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 30, 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                  onTap: Navigator.of(context).pop,
                                  child: SmallLabel(label: 'Cancel')),
                              Gap(20),
                              CapsuleButton(
                                label: 'Proceed',
                                buttonColor: Colors.green,
                                labelColor: Colors.white,
                              )
                            ],
                          ),
                        ),
                      )
                    ];
                  },
                  modalTypeBuilder: (context) {
                    return WoltModalType.dialog();
                  },
                );
              },
            )
          ],
        )
      ]),
    );
  }
}
