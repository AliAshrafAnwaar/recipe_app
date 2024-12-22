import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GoogleFacebookSign extends StatelessWidget {
  const GoogleFacebookSign({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        InkWell(
          onTap: () {},
          child: SvgPicture.asset(
            'assets/images/google.svg',
            width: 30,
            height: 30,
          ),
        ),
        const Icon(
          Icons.facebook,
          color: Colors.blue,
          size: 38,
        ),
        const SizedBox(),
      ],
    );
  }
}
