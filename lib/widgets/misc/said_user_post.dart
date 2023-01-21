import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/widgets/misc/said_avatar.dart';

class UserPost extends StatefulWidget {
  const UserPost(
      {super.key,
      this.nameInitials,
      this.profilePic,
      required this.fullName,
      required this.postContent});

  final String? nameInitials;
  final NetworkImage? profilePic;
  final String fullName;
  final String postContent;

  @override
  State<UserPost> createState() => _UserPostState();
}

class _UserPostState extends State<UserPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            color: ColorConstants.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 3,
              )
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  SaidAvatar(
                    nameInitials: widget.nameInitials,
                    networkImg: widget.profilePic,
                    dimensions: 30,
                  ),
                  const Padding(padding: EdgeInsets.all(4)),
                  Text(widget.fullName)
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 150,
                      width: 360,
                      decoration: const BoxDecoration(
                        color: ColorConstants.secondaryColor,
                      ),
                    ),
                    Text(
                      widget.postContent,
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
            Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.mode_comment_outlined))
              ],
            ),
          ],
        ));
  }
}
