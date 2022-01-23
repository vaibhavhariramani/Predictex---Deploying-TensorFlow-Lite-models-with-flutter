import 'package:flutter/material.dart';
import 'package:predictex/example.dart';

class cards extends StatelessWidget {
  cards(
      {this.img,
      this.title,
      this.subtitle,
      this.height,
      this.width,
      this.colour,
      this.wid});

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
      padding: const EdgeInsets.all(8.0),
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
              height: 150.0,
              width: 160.0,
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
                height: height,
                width: width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, top: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
