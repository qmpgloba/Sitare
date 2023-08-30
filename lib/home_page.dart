import 'package:flutter/material.dart';

import 'constants/ui_constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int length = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController pobController = TextEditingController();
  TextEditingController tobController = TextEditingController();
  TextEditingController martialController = TextEditingController();
  TextEditingController problemController = TextEditingController();
  List<String> optionalField = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 50),
              Center(
                child: Text(
                  "ENTER DETAILS",
                  style: TextStyle(
                      color: FONT_COLOR,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: TextFormField(
                  controller: nameController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: emailController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: genderController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Gender",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: dobController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: pobController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Place of Birth",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: tobController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Time of Birth",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: martialController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Marital Status",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                  onChanged: (v) {},
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                child: TextFormField(
                  controller: problemController,
                  style: TextStyle(
                    color: FONT_COLOR,
                  ),
                  decoration: InputDecoration(
                    hintText: "Problem",
                    hintStyle: TextStyle(
                      color: FONT_COLOR,
                    ),
                  ),
                  onChanged: (v) {},
                ),
              ),
              ListView.builder(
                padding: EdgeInsets.only(top: 35),
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (context, index) {
                  if (optionalField.length <= index) {
                    optionalField.add('');
                  }

                  return Padding(
                    padding: EdgeInsets.only(left: 60, right: 60, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                        color: FONT_COLOR,
                      ),
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          hintText: "Partner Details (Optional)",
                          hintStyle: TextStyle(
                            color: FONT_COLOR,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: FONT_COLOR, width: 1),
                          ),
                          suffixIcon: index == 0
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      ++length;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: FONT_COLOR,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      --length;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: FONT_COLOR,
                                  ),
                                )),
                      onChanged: (v) {
                        optionalField[index] = v;
                        print(v);
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: [
                      Text(
                        "SKIP FOR NOW",
                        style: TextStyle(
                            color: FONT_COLOR, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: FONT_COLOR,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
