import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  var _eventnameController = new TextEditingController();
  var _eventinfoController = new TextEditingController();
  var _eventtimeController = new TextEditingController();
  var _eventdayController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void onCreatedAccount() {
    var alert = new AlertDialog(
      title: new Text('Info'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('You have created a new Account.'),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

  void _addData() {
    var url = "https://prayingkeralaevent.000webhostapp.com/NewUser.php";

    http.post(url, body: {
      "eventName": _eventnameController.text,
      "eventInfo": _eventinfoController.text,
      "eventTime": _eventtimeController.text,
      "eventDay": _eventdayController.text,
    });
    onCreatedAccount();
    //print(_adresseController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: Container(
            child: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                iconSize: 20,
                color: Colors.redAccent,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              centerTitle: true,
              elevation: 2,
              title: Text("New Event",
                  style: TextStyle(
                      fontFamily: 'raleway',
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: 22)),
              backgroundColor: Colors.white,
            ),
          ),
          preferredSize: Size.fromHeight(64),
        ),
        body: Container(
            color: Colors.white,
            padding: EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Form(
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: "Event Name",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 3))),
                            keyboardType: TextInputType.text,
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value.length < 3)
                                return "Event Name should have more than 2 charecters";
                              else
                                return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                          ),
                          TextFormField(
                            maxLines: null,
                            decoration: InputDecoration(
                                labelText: "Event Description",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 3))),
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(color: Colors.black),
                            validator: (value) {
                              if (value.length < 1)
                                return "Event Description should not be blank";
                              else
                                return null;
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12,24,12,12),
                            child: Text("Time:", style:TextStyle(fontFamily: 'raleway', fontWeight: FontWeight.w500, fontSize: 16)),
                          ),
                          
                        ]))
              ],
            )));
  }
}
