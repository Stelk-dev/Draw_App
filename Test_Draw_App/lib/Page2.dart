import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:painter/painter.dart';

// ignore: must_be_immutable
class Page2 extends StatefulWidget {
  String title = '';
  int index = 0;
  Color color;

  Page2({this.title, this.index, this.color});

  @override
  _Page2State createState() => _Page2State();
}

Icon optionTool;
double sizePen;
Color colorPen;
double sizeRubber;
List<PainterController> controllerPaints;
int indexController;

class _Page2State extends State<Page2> {
  PageController controller;
  List page = []; //Pages drawing
  int pageIndex = 0; //What page is active

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: 0);
    controller.dispose();
    setState(() {
      optionTool = Icon(Icons.create);
      sizePen = 3;
      colorPen = Colors.black;
      sizeRubber = 3;
      controllerPaints = [];
      indexController = -1;
    });
    addPainterPage();
    print(widget.index);
  }

//New controller
  PainterController initializeControllerPaints() {
    PainterController controller = new PainterController();
    controller.thickness = sizePen;
    controller.drawColor = colorPen;
    return controller;
  }

//Add page function
  void addPainterPage() {
    controllerPaints.add(initializeControllerPaints());
    indexController += 1;
    page.add(drawPage2(controllerPaints[indexController]));
  }

  //Base drawing
  Widget drawPage2(PainterController control) {
    return Painter(control);
  }

  //MAIN
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: widget.color,
          actions: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Row(
                  children: [
                    optionTool.icon == Icons.gradient
                        ? IconButton(
                            icon: Icon(Icons.rotate_left),
                            onPressed: () {
                              controllerPaints[pageIndex].undo();
                            })
                        : Container(),
                    IconButton(
                        icon: optionTool,
                        onPressed: () {
                          return showDialog(
                            context: context,
                            builder: (context) {
                              if (optionTool.icon == Icons.create) {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                      backgroundColor: Colors.black54,
                                      title: Container(
                                          color: Colors.black,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(
                                              child: Text(
                                                'Pencil',
                                                style: TextStyle(
                                                    color: Colors.amber),
                                              ),
                                            ),
                                          )),
                                      content: Container(
                                        height: 190,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              color:
                                                  Color.fromRGBO(23, 23, 23, 1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 0),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Thickness',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Slider(
                                                      min: 1,
                                                      max: 7,
                                                      divisions: 7,
                                                      value: sizePen,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          sizePen = value;
                                                          for (var i
                                                              in controllerPaints)
                                                            i.thickness =
                                                                sizePen;
                                                        });
                                                      },
                                                      label: sizePen
                                                          .round()
                                                          .toString(),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Container(
                                              color:
                                                  Color.fromRGBO(23, 23, 23, 1),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 8, 0, 4),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'Color',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    SizedBox(
                                                      height: 2,
                                                    ),
                                                    OptionColorsWidget()
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                                });
                              } else {
                                return StatefulBuilder(
                                    builder: (context, setState) {
                                  return AlertDialog(
                                    backgroundColor: Colors.black54,
                                    title: Container(
                                        color: Colors.black,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Center(
                                            child: Text(
                                              'Rubber',
                                              style: TextStyle(
                                                  color:
                                                      Colors.lightBlueAccent),
                                            ),
                                          ),
                                        )),
                                    content: Container(
                                      height: 82,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            color:
                                                Color.fromRGBO(23, 23, 23, 1),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 8, 0, 0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Size',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Slider(
                                                    min: 1,
                                                    max: 7,
                                                    divisions: 7,
                                                    value: sizeRubber,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        sizeRubber = value;
                                                        for (var i
                                                            in controllerPaints)
                                                          i.thickness =
                                                              sizeRubber;
                                                      });
                                                    },
                                                    label: sizeRubber
                                                        .round()
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      FlatButton(
                                          onPressed: () {
                                            controllerPaints[pageIndex].clear();
                                            print("Soos");
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancella tutto',
                                            style: TextStyle(color: Colors.red),
                                          ))
                                    ],
                                  );
                                });
                              }
                            },
                          );
                        }),
                  ],
                ))
          ],
          bottom: PreferredSize(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  (pageIndex + 1).toString() + "/" + page.length.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
                SizedBox(width: 220),
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () {
                    if (pageIndex != 0) controller.jumpToPage(pageIndex - 1);
                  },
                  color: Colors.white,
                  iconSize: 30,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () {
                    if ((pageIndex + 1) != page.length && page.length > 1)
                      controller.jumpToPage(pageIndex + 1);
                  },
                  color: Colors.white,
                  iconSize: 30,
                )
              ],
            ),
            preferredSize: Size(1, 25.0),
          )),
      body: PageView.builder(
        controller: controller,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        physics: new NeverScrollableScrollPhysics(),
        itemCount: page.length,
        itemBuilder: (context, index) {
          // * Sistema cambio pagina
          return page[index];
        },
      ),
      floatingActionButton: SpeedDial(
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.gradient),
              backgroundColor: Colors.red,
              onTap: () {
                setState(() {
                  optionTool = Icon(Icons.gradient);
                  for (var i in controllerPaints) i.eraseMode = true;
                  for (var i in controllerPaints) i.thickness = sizeRubber;
                });
              }),
          SpeedDialChild(
            child: Icon(Icons.create),
            backgroundColor: Colors.blue,
            onTap: () {
              setState(() {
                optionTool = Icon(Icons.create);
                for (var i in controllerPaints) i.thickness = sizePen;
                for (var i in controllerPaints) i.eraseMode = false;
              });
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add_box),
            backgroundColor: Colors.green,
            onTap: () {
              setState(() {
                addPainterPage();
              });
            },
          ),
        ],
      ),
    );
  }
}

//Change color option menu
class OptionColorsWidget extends StatefulWidget {
  @override
  OoptionColorsWidgetState createState() => OoptionColorsWidgetState();
}

class OoptionColorsWidgetState extends State<OptionColorsWidget> {
  void changeColorPaints(Color color) {
    for (var i in controllerPaints) i.drawColor = color;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              colorPen = Colors.black;
              changeColorPaints(colorPen);
            });
          },
          elevation: 2.0,
          fillColor: Colors.black,
          child: Icon(
            colorPen == Colors.black ? Icons.check_circle_outline : null,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              colorPen = Colors.red;
              changeColorPaints(colorPen);
            });
          },
          elevation: 2.0,
          fillColor: Colors.red,
          child: Icon(
            colorPen == Colors.red ? Icons.check_circle_outline : null,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              colorPen = Colors.lightBlue;
              changeColorPaints(colorPen);
            });
          },
          elevation: 2.0,
          fillColor: Colors.lightBlue,
          child: Icon(
            colorPen == Colors.lightBlue ? Icons.check_circle_outline : null,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              colorPen = Colors.yellow;
              changeColorPaints(colorPen);
            });
          },
          elevation: 2.0,
          fillColor: Colors.yellow,
          child: Icon(
            colorPen == Colors.yellow ? Icons.check_circle_outline : null,
            color: Colors.white,
          ),
          shape: CircleBorder(),
        ),
      ],
    );
  }
}
