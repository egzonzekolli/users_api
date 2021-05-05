import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'screens/secondScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  List _users = [];

  getUsers() async {
    http.get("https://reqres.in/api/users?per_page=12").then((res) {
      Map userData = json.decode(res.body);
      setState(() {
        _users = userData["data"];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => getUsers(),
          )
        ],
      ),
      body: _users.length == 0
          ? Center(child: Text("No user Found"))
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(_users[index]['avatar'])),
                  title: Text(_users[index]['first_name'] +
                      " " +
                      _users[index]['last_name']),
                  onTap: () {
                    gotoSecondActivity(context, _users[index]['id'],_users);
                  },
                );
              },
            ),
    );
  }

  gotoSecondActivity(BuildContext context, int id, List _users) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailScreen (id: id, users: _users)),
    );
  }
}



