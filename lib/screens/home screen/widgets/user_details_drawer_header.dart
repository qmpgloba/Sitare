
import 'package:flutter/material.dart';

class UserDetailsDrawerHeader extends StatelessWidget {
  const UserDetailsDrawerHeader({
    super.key,
    required this.size, required this.fullName, required this.email, required this.phoneNumber,
  });

  final Size size;
  final String fullName;
  final String email;
  final String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: size.width * .1,
          backgroundColor: Colors.grey,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fullName),
            Text(email),
            Text(phoneNumber),
          ],
        ),
        IconButton(onPressed: () {
          
        }, icon: Icon(Icons.arrow_forward_ios_outlined))
      ],
    ));
  }
}
