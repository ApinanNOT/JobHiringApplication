import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

class SelectJobNearest extends StatefulWidget
{
  const SelectJobNearest({Key? key}) : super(key: key);

  @override
  State<SelectJobNearest> createState() => _SelectJobNearestState();
}

class _SelectJobNearestState extends State<SelectJobNearest>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.primary,
        title: Text(
          "งานรอบตัวคุณ"
          ,style: MyConstant().headbar(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: jList.length,
        itemBuilder: (BuildContext context, int index)
        {
          return Card(
            color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            elevation: 5,
            margin: const EdgeInsets.all(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: ListTile(
                leading: Image.asset(
                  'images/' + jList[index]['safe'].toString() + ".png",
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:
                  [
                    Text(
                      jList[index]["name"],
                      style: MyConstant().h2Style(),
                    ),
                    Text(
                      jList[index]["money"],
                      style: MyConstant().h2Style(),
                    ),
                    // SmoothStarRating(
                    //   rating: 3.5,
                    //   color: Colors.black,
                    //   borderColor: Colors.black,
                    //   allowHalfRating: true,
                    //   starCount: 5,
                    //   size: 15,
                    // )
                  ]
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 2,),
                    Text(
                      "10 กิโลเมตร", style: MyConstant().h4Style(),
                    )
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
