import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:sitare/constants/ui_constants.dart';
import 'package:sitare/screens/update%20profile%20screen/update_profile_screen.dart';

class UserDetailsDrawerHeader extends StatelessWidget {
  const UserDetailsDrawerHeader({
    super.key,
    required this.size,
    required this.fullName,
    required this.email,
    required this.phoneNumber,  this.profileImageUrl,

  });

  final Size size;
  final String fullName;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
             CircleAvatar(
              radius: 30,
              backgroundImage:(profileImageUrl != '')? NetworkImage(profileImageUrl!): const AssetImage('assets/images/profile_image.png') as ImageProvider,
            ),
            Positioned(
                // height: 25,
                // width: 20,
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => UpdateProfileScreen(
                        email: email,
                      ),
                    ));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor.withOpacity(0.4)),
                      child: const Icon(
                        Icons.edit,
                        size: 30,
                      )),
                )),
          ],
        ),
        Container(
          padding: EdgeInsets.all(size.width / 60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  fullName,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(color: blackColor, fontSize: 13),
                  // maxFontSize: 14,
                ),
              ),
              AutoSizeText(
                email,
                maxLines: 1,
                maxFontSize: 14,
              ),
              AutoSizeText(
                phoneNumber,
                maxLines: 1,
                maxFontSize: 14,
              ),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
             
            },
            icon: const Icon(Icons.arrow_forward_ios_outlined))
      ],
    ));
  }
}
