// main.dart
import 'package:flutter/material.dart';
class Example  extends StatefulWidget {
  const Example ({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Example > createState() => _ExampleState ();
}

class _ExampleState  extends State<Example > {

  void myFunction(){
    print('hello dart');
  }
  ShowDialog showDialog = ShowDialog();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
        ),
        body: TextButton(
            onPressed: (){
              showDialog.myDialog(context);
            },
            child: Text('tab me')
        )
    );
  }
}


class ShowDialog {

  Future myDialog(BuildContext context){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(

          backgroundColor: Colors.deepPurple[900],
          titleTextStyle: const TextStyle(
              color: Colors.red, fontSize: 18),
          children: [
            ElevatedButton(
                onPressed: () {
                  // here i need to call myFunction() Methood
                  _ExampleState().myFunction();
                },
                child: const Text("tab")
            ),
          ],
        );
      },
    );
  }

}