import 'package:flutter/material.dart';
import 'package:flutter_app/NewsDetails.dart';

import 'GetRss.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Itune Album'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    setState(() {
      GetRss.getRss();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: FutureBuilder(
            future: GetRss.getRss(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                // TODO: Handle this case.
                  break;
                case ConnectionState.waiting:
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.cloud_download),
                        Text("Itune")
                      ],
                    ),
                  );
                  break;
                case ConnectionState.active:
                // TODO: Handle this case.
                  break;
                case ConnectionState.done:
                  return Container(
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
//
                          return ListTile(
                            title: Text(snapshot.data[index].titulo,
                              style: TextStyle(fontSize: 15, color: Colors.black54),),
                            subtitle: Text(snapshot.data[index].fecha,
                              style: TextStyle(fontSize: 15, color: Colors.black),),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    NewsDetails(
                                      title: "Album",
                                      url: snapshot.data[index].urlNoticia,
                                      key: null,
                                    ),
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (context, index) =>
                            Divider(
                              color: Colors.grey,
                            ),
                        itemCount: snapshot.data.length
                    ),
                  );
                  break;
              }
            }),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}