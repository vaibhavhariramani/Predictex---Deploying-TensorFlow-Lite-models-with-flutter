import 'package:flutter/material.dart';
import 'package:predictex/constant.dart';
import 'package:predictex/webViewer/webview.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black87,
        ),
        title: const Text(
          'Symtoms & Testing',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: const Color(0xFF003D64),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black45,
                            offset: Offset(0.0, 10.0),
                            blurRadius: 10.0)
                      ]),
                ),
                Container(
                  alignment: FractionalOffset.centerLeft,
                  child: const Image(
                    image: AssetImage(
                      'images/doctor.png',
                    ),
                    height: 200,
                    width: 190,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 160.0, top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Call your Doctor',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        'if You think you have been exposed to COVID-19 ?',
                        style: TextStyle(
                            color: Color(0xFF426D8D),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        height: 40.0,
                        width: 160.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF025790),
                        ),
                        child: Center(
                          child: RichText(
                            text: const TextSpan(
                              text: 'Chat with  Doctor',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              children: [
                                WidgetSpan(
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                  alignment: PlaceholderAlignment.middle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Symptoms',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  cards(
                    colour: Color(0xFF087CC7),
                    img: 'images/caugh (1).png',
                    height: 120,
                    width: 150,
                    title: 'Symptoms &',
                    subtitle: 'Preventions',
                    wid: SecondScreen(),
                  ),
                  cards(
                    colour: Color(0xFFB3E0FF),
                    img: 'images/headache.png',
                    height: 120,
                    width: 160,
                    title: ' Prevent ',
                    subtitle: 'Getting Sick',
                    wid: SecondScreen(),
                  ),
                ],
              ),
            ),
            Text(
              'Training Video',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 2.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xFFFEE8DA),
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                            color: Colors.black38,
                            offset: Offset(0.0, 8.0),
                            blurRadius: 10.0)
                      ]),
                ),
                Container(
                  alignment: FractionalOffset.centerLeft,
                  child: Image(
                    image: AssetImage(
                      'images/Picture11.png',
                    ),
                    height: 150,
                    width: 140,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 130.0, top: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Safety and Health Topics',
                        style: TextStyle(
                            color: Color(0xFFEC8537),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'if You think you have been exposed to COVID-19 '
                        'if You think you have been?',
                        style: TextStyle(
                            color: Color(0xFFA59A92),
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ),
      ),
    );
  }
}
