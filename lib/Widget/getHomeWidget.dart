import 'package:flutter/material.dart';

class getHomeWidget extends StatelessWidget {
  const getHomeWidget({
    Key? key, 
    required this.text, 
    required this.img, 
    required this.onTap
  }) : super(key: key);

  final String text;
  final String img;
  final String onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 225),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      height: 130,
      width: 130,
      margin: const EdgeInsets.all(10),
      child: Expanded(
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: () {
            Navigator.pushNamed(context, onTap);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(img),
                height: 80,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
