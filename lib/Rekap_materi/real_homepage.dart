import 'package:flutter/material.dart';
import 'package:learning_udemy/Rekap_materi/list_materi.dart';

class RealHomepage extends StatefulWidget {
  const RealHomepage({super.key});

  @override
  State<RealHomepage> createState() => _RealHomepageState();
}

class _RealHomepageState extends State<RealHomepage> {
  bool isTheme = false;
  bool isColor = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: MediaQuery.of(context).size.width,
              color: isColor
                  ? const Color.fromRGBO(241, 250, 238, 1)
                  : Color.fromRGBO(16, 0, 43, 1),
              child: Stack(
                children: [
                  Center(
                    child: Stack(children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(left: 20, top: 20),
                        height: 80,
                        width: 80,
                        color: isColor
                            ? const Color.fromRGBO(230, 57, 70, 1)
                            : Color.fromRGBO(247, 37, 133, 1),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(left: 30, top: 50),
                        child: CustomPaint(
                            size: const Size(90, 90), painter: DrawTriangle()),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        margin: const EdgeInsets.only(left: 90, top: 30),
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(50.0),
                          ),
                          color: isColor
                              ? Color.fromRGBO(29, 53, 87, 1)
                              : Color.fromRGBO(114, 9, 183, 1),
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            'Rekap Materi',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 33,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 4
                                ..color = isColor
                                    ? Color.fromRGBO(29, 53, 87, 1)
                                    : Color.fromRGBO(114, 9, 183, 1),
                            ),
                          ),
                          // Solid text as fill.
                          const Text(
                            'Rekap Materi',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 33,
                              color: Color.fromRGBO(241, 250, 238, 1),
                            ),
                          ),
                        ],
                      )
                    ]),
                  ),
                  // Switch(
                  //     activeColor: Color.fromRGBO(157, 78, 221, 1),
                  //     value: isTheme,
                  //     onChanged: ((value) {
                  //       setState(() {
                  //         isTheme = value;
                  //         isColor = !value;
                  //       });
                  //     }))
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.red,
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      color: isColor
                          ? Color.fromRGBO(129, 196, 255, 1)
                          : Color.fromRGBO(90, 24, 154, 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      color: isColor
                          ? Color.fromRGBO(22, 88, 142, 1)
                          : Color.fromRGBO(36, 0, 70, 1),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      color: isColor
                          ? Color.fromRGBO(231, 34, 46, 1)
                          : Color.fromRGBO(247, 37, 133, 1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
                color: Color.fromRGBO(29, 53, 87, 1).withOpacity(0.3),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: materi.length,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => materi[index].page,
                            ));
                          },
                          title: Text(materi[index].title.toUpperCase()),
                          subtitle: Text(materi[index].deskripsi),
                        ),
                      );
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

class DrawTriangle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.height, size.width);
    path.close();
    canvas.drawPath(
        path, Paint()..color = const Color.fromRGBO(168, 218, 220, 1));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
