import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quake_app/quakes.dart';

    Map _data;
    List _features;
      void main() async {
        _data = await getQuakes();

        _features = _data['features'];

        runApp(new MaterialApp(
          title: 'Quakes',
          home: new Quakes(),
        ));
    }

  class Quakes extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text('Quakes'),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: new Center(
          child: new ListView.builder(
              itemCount: _features.length,
              padding: const EdgeInsets.all(15.0),

              itemBuilder: (BuildContext context, int position) {

                if (position.isOdd) return new Divider();
                final index = position ~/ 2;

                var format = new DateFormat.yMMMMd("en_US").add_jm();

                var date = format.format(new DateTime.fromMicrosecondsSinceEpoch(
                    _features[index]['properties']['time'] * 1000, isUtc: true));

                return new ListTile(
                  title: new Text(
                    " $date",
                    style: new TextStyle(
                        fontSize: 15.5,
                        color: Colors.orange,
                        fontWeight: FontWeight.w500),
                  ),
                  subtitle: new Text(
                    "${_features[index]['properties']['place']}",
                    style: new TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic),
                  ),
                  leading: new CircleAvatar(
                    backgroundColor: Colors.green,
                    child: new Text(
                      "${_features[index]['properties']['mag']}",
                      style: new TextStyle(
                          fontSize: 16.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontStyle: FontStyle.normal),
                    ),
                  ),
                  onTap: () {
                    _showAlertMessage(
                        context, "${_features[index]['properties']['title']}");
                  },
                );
              }),
        ),
      );
    }

    void _showAlertMessage(BuildContext context, String message) {
      var alert = new AlertDialog(
        title: new Text('Quakes'),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: new Text('OK'))
        ],
      );
      showDialog(context: context, child: alert);
    }
  }

