import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Page2.dart';

void main() {
  runApp(MaterialApp(
    home: BodyApp(),
    debugShowCheckedModeBanner: false,
    title: 'BackpackApp',
  ));
}

String titleNewNote;
int index;
Color optionColors = Colors.red;
List notes = [];

class BodyApp extends StatefulWidget {
  @override
  _BodyAppState createState() => _BodyAppState();
}

class _BodyAppState extends State<BodyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text('Backpack'),
      ),
      body: notes.length == 0
          ? Center(
              child: Text(
                'Aggiungi quaderno',
                style: TextStyle(fontSize: 20, color: Colors.white60),
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.all(4),
              children: List.generate(notes.length, (index) {
                return Center(
                  child: Container(
                    height: 170,
                    width: MediaQuery.of(context).size.width * 0.47,
                    child: FlatButton(
                      onLongPress: () {
                        return showCupertinoDialog(
                            context: context,
                            builder: (context) {
                              return CupertinoAlertDialog(
                                title: Text(notes[index][0]),
                                actions: [
                                  CupertinoDialogAction(
                                      onPressed: () {
                                        setState(() {
                                          notes.removeAt(index);
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Elimina',
                                        style: TextStyle(color: Colors.red),
                                      )),
                                  CupertinoDialogAction(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'Annulla',
                                        style:
                                            TextStyle(color: Colors.lightBlue),
                                      )),
                                ],
                              );
                            });
                      },
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Page2(
                                  title: notes[index][0],
                                  index: notes[index][1],
                                  color: notes[index][2],
                                )));
                      },
                      child: Text(
                        notes[index][0].length < 70
                            ? notes[index][0]
                            : notes[index][0].substring(0, 42) + "...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                blurRadius: 6.0,
                                color: Colors.black,
                                offset: Offset(0, 0),
                              ),
                            ]),
                        textAlign: TextAlign.center,
                      ),
                      color: notes[index][2],
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            titleNewNote = null;
          });
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                title: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Center(
                      child: Text(
                        'Aggiungi nuovo quaderno',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  color: Colors.grey[900].withOpacity(0.7),
                ),
                content: Container(
                  height: 157,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        autofocus: false,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            labelText: 'Nome quaderno',
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 16)),
                        onChanged: (value) {
                          setState(() {
                            titleNewNote = value;
                          });
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          color: Colors.grey[900].withOpacity(0.7),
                          child: OptionColorsWidget())
                    ],
                  ),
                ),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Annulla'),
                    color: Colors.red,
                  ),
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        index = notes.length;
                        titleNewNote != null
                            ? titleNewNote = titleNewNote
                            : titleNewNote =
                                'Nuovo quaderno ' + (index + 1).toString();
                        notes.add([titleNewNote, index, optionColors]);
                      });
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Aggiungi',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.lightBlue,
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class OptionColorsWidget extends StatefulWidget {
  @override
  OoptionColorsWidgetState createState() => OoptionColorsWidgetState();
}

class OoptionColorsWidgetState extends State<OptionColorsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              optionColors = Colors.blue;
            });
          },
          elevation: 2.0,
          fillColor: Colors.blue,
          child: Icon(
            optionColors == Colors.blue ? Icons.check_circle_outline : null,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              optionColors = Colors.red;
            });
          },
          elevation: 2.0,
          fillColor: Colors.red,
          child: Icon(
            optionColors == Colors.red ? Icons.check_circle_outline : null,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              optionColors = Colors.green;
            });
          },
          elevation: 2.0,
          fillColor: Colors.green,
          child: Icon(
            optionColors == Colors.green ? Icons.check_circle_outline : null,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              optionColors = Colors.yellow;
            });
          },
          elevation: 2.0,
          fillColor: Colors.yellow,
          child: Icon(
            optionColors == Colors.yellow ? Icons.check_circle_outline : null,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
        RawMaterialButton(
          constraints: BoxConstraints(minHeight: 20, minWidth: 0),
          onPressed: () {
            setState(() {
              optionColors = Colors.purple;
            });
          },
          elevation: 2.0,
          fillColor: Colors.purple,
          child: Icon(
            optionColors == Colors.purple ? Icons.check_circle_outline : null,
            color: Colors.black,
          ),
          shape: CircleBorder(),
        ),
      ],
    );
  }
}
