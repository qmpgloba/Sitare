import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/profile%20screen/widgets/update_profile_textfeild_widget.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  

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
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: PRIMARY_COLOR,
        title: const Text('Update Profile',style: TextStyle(color: whiteColor,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
                padding: EdgeInsets.all(size.width / 16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
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
                                width:size.width *.25,
                                child: const Text(
                                  'Gender',
                                  style: TextStyle(color: blackColor),
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              width: size.width *.55,
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
                                  width: size.width *.25,
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
                                width: size.width *.55,
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
                                      //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('dd-MM-yyyy')
                                              .format(pickedDate);
                                      //formatted date output using intl package =>  2021-03-16
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
                                  width: size.width *.25,
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
                                width: size.width *.55,
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
                                width: size.width *.25,
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
                              width:size.width *.55,
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
                            }
                          },
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: redColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: const Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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