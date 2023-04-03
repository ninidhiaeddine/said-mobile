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
  bool _isLiked = false;

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
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  decoration: const BoxDecoration(
                    color: ColorConstants.secondaryColor,
                  ),
                ),
                Text(
                  widget.postContent,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    _isLiked = !_isLiked;
                  });
                },
                icon: _isLiked
                    ? const Icon(Icons.favorite_rounded)
                    : const Icon(Icons.favorite_border)),
          ],
        ));
  }
}
