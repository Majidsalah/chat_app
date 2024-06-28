import 'package:chat_app/widgets/chat_list.dart';
import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/widgets.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = 'chatScreen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
 TextEditingController _mess=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff284461),
        title: Row(
          children: [
            SizedBox(
                height: 60,
                width: 60,
                child: Image.asset('assets/scholar.png')),
            const Text(
              'Chat',
              style: TextStyle(fontSize: 18, color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (_, index) => BubbleSpecialThree(
                text: messages[index],
                color: Color(0xFF1B97F3),
                tail: true,
                textStyle: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: TextField(
               controller: _mess,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() { messages.add(_mess.text);
                        _mess.text='';
                        });
                       
                      },
                      icon: Icon(Icons.send),
                    ),
                    suffixIconColor: Color(0xff284461),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
