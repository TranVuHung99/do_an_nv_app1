import 'dart:convert';

import 'package:do_an_nv_app/datas/chat_data.dart';
import 'package:do_an_nv_app/datas/fake_datas.dart';
import 'package:do_an_nv_app/modules/employes.dart';
import 'package:do_an_nv_app/widget/messages_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
class ChatPage extends StatefulWidget {
  Employes _employee;
  static const String routeName = '/ChatPage';
  @override
  _ChatPageState createState() => _ChatPageState();
}


class _ChatPageState extends State<ChatPage> {
  String message = '';
  TextEditingController _textController = TextEditingController();

  var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
  Future<void> _sendMessage() async{
    Map<String, dynamic> body ={
      "to" : deviceToken,
      "collapse_key" : "type_a",
      "notification" : {
        "body" : message,
        "title": "${widget._employee.name} nhắn: "
      },
      "data" : {
        "type" : "messages"
      }
    };
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json",
        "Authorization": "key=AAAAAZL8920:APA91bEi6ArWOfYha7oZK4itXBmkVhSSZGGw0Lo0HX6sDsW1-xPpz-xLpvC4bic2m17wUnELzBNR3w3iIs5Q542nrD71di1OThQst86oYWQhrUKfHrYeMMAgxhVRmIPiMInlrq-QSk57"},
      body: json.encode(body),
    );
    if(response.statusCode == 200 || response.statusCode == 201){
      print('Response Body: ${response.body}');
      return response;
    }
    print('Response Body: ${response.body}');
    print('Response Status: ${response.statusCode}');
  }
  @override
  Widget build(BuildContext context) {
    FireStoreDatabaseMessage firebaseMessage = Provider.of<FireStoreDatabaseMessage>(context);
    Map<String, dynamic> argument = ModalRoute.of(context).settings.arguments;
    this.widget._employee = argument['employee'];
    void sendMessage() async{
      FocusScope.of(context).unfocus();
      await firebaseMessage.upLoadMessage(message, DateTime.now(), widget._employee.id, widget._employee.name);
      await _sendMessage();
      setState(() {
        message='';
      });
      _textController.clear();
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tin Nhắn', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: MessagesWidget(employee: widget._employee),
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      enableSuggestions: true,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          labelText: 'Nhập tin nhắn',
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: 0),
                              gapPadding: 10,
                              borderRadius: BorderRadius.circular(25)
                          )
                      ),
                      onChanged: (value) => setState(() {
                        message = value;
                      }),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: message.trim().isEmpty ? null : sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue
                      ),
                      child: Icon(Icons.send, color: Colors.white,),
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
