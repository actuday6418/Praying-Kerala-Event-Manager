import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

void main() => runApp(AllUsers());

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => new _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  var _isLoading = false;
  var items;
  var tof, name, ps, adress, phone;
  _getData() async {
    final url =
        "https://prayingkeralaevent.000webhostapp.com/SelectAllUsers.php";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final events = map["result"];

      setState(() {
        _isLoading = true;
        this.items = events;
        print(items);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Event List", style: TextStyle(fontFamily: 'raleway' ,color: Colors.redAccent, fontSize: 25)),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 5,
          backgroundColor: Colors.redAccent,
          child: Icon(Icons.add, color: Colors.white, size: 40,),
        ),
        body: Center(
            child: !_isLoading
                ? CircularProgressIndicator(backgroundColor: Colors.red)
                : ListView.builder(
                    itemCount: this.items != null ? this.items.length : 0,
                    itemBuilder: (context, i) {
                      final item = this.items[i];
                      return Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        elevation: 3,
                        margin: EdgeInsets.all(20),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: ListTile(
                            title: Text(
                              item["eventName"],
                            ),
                            subtitle: Text(
                              item["eventInfo"],
                              maxLines: 2,
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.delete, color: Colors.redAccent,),
                              onPressed: () {},
                            ),
                            leading: Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle),
                              width: 50,
                              child: Center(
                                child: Text(item["eventDay"],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30)),
                              ),
                            ),
                            isThreeLine: true,
                          ),
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
