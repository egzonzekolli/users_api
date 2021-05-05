import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
class DetailScreen extends StatefulWidget {
  final int id;
  final List users;
  DetailScreen({
    Key key,
    @required this.id,
    @required this.users,
  }) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int idd;
  int check = 0;
  void nextuser() {
    setState(() {
      if (idd < widget.users.length - 1) {
        idd++;
      }
    });
  }

  void previoususer() {
    setState(() {
      if (idd > 0) {
        idd--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (check == 0) {
      idd = widget.id - 1;
      check++;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("User Details"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // CircleAvatar(
            //     radius: 50.0,
            //     backgroundColor: Colors.red,
            //     backgroundImage: NetworkImage(widget.users[idd]['avatar'])),
            FullScreenWidget(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.network(
                  widget.users[idd]['avatar'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              widget.users[idd]['first_name'] +
                  " " +
                  widget.users[idd]['last_name'],
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 30.0,
                color: Colors.black12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${idd + 1}",
              style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 20.0,
                  color: Colors.black12,
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(
                color: Colors.teal.shade100,
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.black45),
                title: Text(
                  widget.users[idd]['email'],
                  style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'SourceSansPro',
                    color: Colors.black45,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton(
                  onPressed: () {
                    previoususer();
                  },
                  child: Icon(
                    Icons.skip_previous,
                  ),
                ),
                Container(
                  width: 20.0,
                ),
                RaisedButton(
                  onPressed: () {
                    nextuser();
                  },
                  child: Icon(
                    Icons.skip_next,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
