import 'package:flutter/material.dart';
import 'package:said/config/color_constants.dart';
import 'package:said/widgets/misc/said_avatar.dart';

class SaidUserPost extends StatefulWidget {
  const SaidUserPost(
      {super.key,
      this.profilePic,
      required this.fullName,
      required this.postContent});

  final NetworkImage? profilePic;
  final String fullName;
  final String postContent;

  @override
  State<SaidUserPost> createState() => _SaidUserPostState();
}

class _SaidUserPostState extends State<SaidUserPost> {
  String _extractNameInitials(String userFullName) {
    String nameInitials = "";

    var names = userFullName.toUpperCase().split(' ');
    for (var value in names) {
      if (nameInitials.length >= 2) {
        break;
      }

      nameInitials += value[0];
    }

    return nameInitials;
  }

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
                    nameInitials: _extractNameInitials(widget.fullName),
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
