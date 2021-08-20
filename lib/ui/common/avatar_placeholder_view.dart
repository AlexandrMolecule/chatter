import 'package:flutter/material.dart';

class AvatarPlaceholder extends StatelessWidget {
  const AvatarPlaceholder({Key? key, required this.onTap, required this.child}) : super(key: key);
  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ClipOval(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[100],
                ),
                child: child,
                height: 175,
                width: 175,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 10,
              child: GestureDetector(
                onTap: onTap,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.photo_camera_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
