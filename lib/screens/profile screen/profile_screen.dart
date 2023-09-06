import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/profile%20screen/widgets/astroleger_profile_details_widget.dart';
import 'package:sitare/screens/profile%20screen/widgets/contact_icons_widget.dart';
import 'package:sitare/screens/profile%20screen/widgets/update_profile_textfeild_widget.dart';

import 'widgets/next_availability_widget.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  num walletBalnce = 0;

  TextEditingController nameTextController = TextEditingController();

  TextEditingController emailTextController = TextEditingController();

  TextEditingController placeOfBirthTextController = TextEditingController();

  TextEditingController problemTextController = TextEditingController();

  TextEditingController dateInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  TimeOfDay timeOfDay = TimeOfDay.now();

  String? genderDropDownValue;
  String? martialDropDownValue;
 final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var genders = [
    'Male',
    'Female',
    'Other',
  ];

  var martialStatus = [
    'Single',
    'Married',
    'Divorced',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: whiteColor),
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            'Profile',
            style: TextStyle(fontWeight: FontWeight.bold, color: whiteColor),
          ),
          actions: [
            ElevatedButton.icon(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    backgroundColor: MaterialStatePropertyAll(PRIMARY_COLOR),
                    elevation: MaterialStatePropertyAll(0)),
                onPressed: () {},
                icon: const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: greyColor,
                ),
                label: Text(
                  '₹$walletBalnce',
                  style: const TextStyle(fontSize: 18, color: greyColor),
                )),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share_outlined,
                  color: greyColor,
                ))
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 80,
                // color: ,
                child:  DrawerHeader(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(color: greyColor.withOpacity(.3 )),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Update Profle',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(size.width / 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      UpdateProfileTextFeildWidgets(
                          size: size,
                          controller: nameTextController,
                          hintText: 'Full Name',
                          feildName: 'Name',
                          keyboardType: TextInputType.name),
                          const SizedBox(height: 10,),
                      UpdateProfileTextFeildWidgets(
                        size: size,
                        controller: emailTextController,
                        hintText: 'Email',
                        feildName: 'Email',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      Row(
                        children: [
                          SizedBox(
                              width: size.width / 4.5,
                              child: const Text(
                                'Gender',
                                style: TextStyle(color: blackColor),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: size.width / 2.8,
                            height: 50,
                            child: DropdownButtonFormField(
                              hint: const Text('Gender',),
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder()),
                              // value: 'Male',
                              items: genders
                                  .map(
                                    (String items) => DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                genderDropDownValue = value;
                                // setState(() {
                                //   // dropDownValue = value!;
                                //   // category = value;
                                // });
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width / 4.5,
                                child: const AutoSizeText(
                                  'Date of Birth',
                                  maxLines: 1,
                  maxFontSize: 14,
                                  style: TextStyle(color: blackColor),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width / 2.8,
                              height: 35,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Date of Birth',
                                    hintStyle: TextStyle(color: greyColor)),
                                controller: dateInput,
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));
                
                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                          const SizedBox(height: 10,),

                      UpdateProfileTextFeildWidgets(
                          size: size,
                          controller: placeOfBirthTextController,
                          hintText: 'Place of Birth',
                          feildName: 'Place of Birth',
                          keyboardType: TextInputType.name),
                          

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: size.width / 4.5,
                                child: const AutoSizeText(
                                  'Time of Birth',
                                  maxLines: 1,
                  maxFontSize: 14,
                                  style: TextStyle(color: blackColor),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width / 2.8,
                              height: 35,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    hintText: 'Time of Birth',
                                    hintStyle: TextStyle(color: greyColor)),
                                controller: timeInput,
                                readOnly: true,
                                onTap: () async {
                                  displayTimePicker(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                              width: size.width / 4.5,
                              child: const AutoSizeText(
                                'Martial Status',
                                maxLines: 1,
                  maxFontSize: 14,
                                style: TextStyle(color: blackColor),
                              )),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            width: size.width / 2.8,
                            height: 50,
                            child: DropdownButtonFormField(
                              hint: const AutoSizeText(
                                'Martial status',
                                maxLines: 1,
                                maxFontSize: 14,
                              ),
                              decoration: const InputDecoration(
                                  border: UnderlineInputBorder()),
                              // value: 'Male',
                              items: martialStatus
                                  .map(
                                    (String items) => DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (value) {
                                martialDropDownValue = value;
                              },
                            ),
                          ),
                        ],
                      ),
                          const SizedBox(height: 12,),

                      UpdateProfileTextFeildWidgets(
                          size: size,
                          controller: problemTextController,
                          hintText: 'Problem',
                          feildName: 'Problem',
                          keyboardType: TextInputType.text),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                            print('done');
                          }
                        },
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(3)),
                          child: const Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            child: AutoSizeText(
                              'UPDATE',
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(size.width / 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: size.width,
                  height: size.width * .5,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            'https://shreepng.com/img/OutSide/Celebrities/SmritiMandhana/Smriti%20Mandhana.png',
                          ),
                          fit: BoxFit.contain)),
                ),
                AstrologerProfileDetailsWidget(
                    size: size,
                    name: 'Smrithi Mandhana',
                    department: 'Tarot,Numerology',
                    languages: 'English,Hindi,Punjabi',
                    rating: 5,
                    yearsOfExperience: 15,
                    rupees: 95),
                const Column(
                  children: [
                    TabBar(
                        indicatorColor: redColor,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: TextStyle(fontWeight: FontWeight.bold),
                        tabs: [
                          Tab(
                            text: 'About',
                          ),
                          Tab(
                            text: 'Articles',
                          ),
                          Tab(
                            text: 'Reviews',
                          ),
                        ]),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: Padding(
                    padding: EdgeInsets.all(size.width / 16),
                    child: const TabBarView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Center(
                              child: Text(
                            """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                          Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum
                          """,
                            textAlign: TextAlign.center,
                          )),
                        ),
                        Center(child: Text('data')),
                        Center(child: Text('data')),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: size.width * .14,
                      child: Row(
                        children: [
                          Container(
                            height: double.maxFinite,
                            width: size.width * .55,
                            decoration: BoxDecoration(border: Border.all()),
                            child: const Center(
                                child: AutoSizeText(
                              'TALK TO SMRITHI MANDHANA NOW',
                              maxLines: 1,
                              minFontSize: 8,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                          ),
                          Expanded(
                            child: Container(
                              height: double.maxFinite,
                              decoration: const BoxDecoration(
                                  color: redColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(5),
                                      bottomRight: Radius.circular(5))),
                              child: const Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ContactIconWidgetWithText(
                                        icon: Icons.chat_outlined,
                                        text: 'Chat'),
                                    ContactIconWidgetWithText(
                                        icon: Icons.call_outlined,
                                        text: 'Call'),
                                    ContactIconWidgetWithText(
                                        icon: Icons.video_call_outlined,
                                        text: 'Video')
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.width / 20,
                    ),
                    NextAvailabilityWidget(size: size),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: timeOfDay);

    if (time != null) {
      setState(() {
        timeInput.text = "${time.hour}:${time.minute}";
      });
    }
  }
}
