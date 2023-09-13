import 'package:flutter/material.dart';
import 'package:predictex/example.dart';

class cards extends StatelessWidget {
  cards(
      {required this.img,
      required this.title,
      required this.subtitle,
      required this.height,
      required this.width,
      required this.colour,
      required this.wid});

  final String img;
  final String title;
  final String subtitle;
  final double height;
  final double width;
  final Color colour;
  final Widget wid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 6),
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => wid,
          ),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: colour,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45,
                      offset: Offset(0.0, 10.0),
                      blurRadius: 10.0)
                ],
              ),
            ),
            Container(
              alignment: FractionalOffset.topCenter,
              child: Image(
                image: AssetImage(
                  img,
                ),
                fit: BoxFit.fitHeight,
                height: height,
                width: width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      subtitle,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
