import 'package:flutter/material.dart';
import 'package:project2/screens/constraints.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        title: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: '*username*',
                style: TextStyle(fontSize: 16, fontFamily: 'Comfortaa'),
              ),
              TextSpan(text: '\n'),
              TextSpan(
                text: 'Online',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        color: kPrimaryLightColor,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.80,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Text(
                              'hi there!'),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            //for unread messages
                            /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                width: 2,
                                color: kPrimaryColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),*/
                            //for read message
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/profile2.webp'),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            '12:30pm',
                            style: TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topRight,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.80,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Text(
                            'hello how are you?',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '12:30pm',
                            style: TextStyle(fontSize: 12, color: Colors.black45),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            //for unread messages
                            /*decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                width: 2,
                                color: kPrimaryColor,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),*/
                            //for read message
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundImage:
                                  AssetImage('assets/images/profile1.webp'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //Container(
                    //child: Text('*aru messages haru halna parcha*'),
                  //),
                ],
              ),
            ),
            _sendMessageArea(),
          ],
        ),
      ),
    );
  }
}

_sendMessageArea() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(35),
        topLeft: Radius.circular(35),
        bottomRight: Radius.circular(35),
        bottomLeft: Radius.circular(35),
      ),
      boxShadow: [
        BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
      ],
    ),
    padding: EdgeInsets.symmetric(horizontal: 8),
    height: 55,

    child: Row(
      children: <Widget>[
       // IconButton(
         // onPressed: () {},
          //icon: Icon(Icons.photo),
          //iconSize: 25,
          //color: kPrimaryColor,
        //),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextField(
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message..',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.send),
          iconSize: 25,
          color: kPrimaryColor,
        )
      ],
    ),
  );
}
