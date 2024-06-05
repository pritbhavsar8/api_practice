import 'dart:convert';
import 'package:api_practice/model/users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  List<users> ? alldata;
   getdata() async {
    Uri url = Uri.parse("https://reqres.in/api/users?page=2");
    var res = await http.get(url);
    if(res.statusCode==200){
      var json = jsonDecode(res.body.toString());
      setState(() {
        alldata = json["data"].map<users>((obj)=>users.fromJson(obj)).toList();
      });

    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example2"),
        centerTitle: true,
      ),
      body:(alldata==null)?Center(child: CircularProgressIndicator(),): Column(
        children: [
          Icon(Icons.add_a_photo),
          Icon(Icons.construction_sharp),
          Text("dedede"),
          Expanded(
            child: ListView.builder(
              itemCount:alldata!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10.0),
                  color: Colors.orangeAccent.shade100,
                  child: Column(
                    children: [
                      Text(alldata![index].id.toString()),
                      Text(alldata![index].email.toString()),
                      Text(alldata![index].firstName.toString()),
                      Text(alldata![index].lastName.toString()),
                      Image.network(alldata![index].avatar.toString()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],

      ),
      // body: (alldata==null)?Center(child: CircularProgressIndicator(),): ListView.builder(
      //   itemCount:alldata!.length,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       margin: EdgeInsets.all(10.0),
      //       color: Colors.orangeAccent.shade100,
      //       child: Column(
      //         children: [
      //           Text(alldata![index].id.toString()),
      //           Text(alldata![index].email.toString()),
      //           Text(alldata![index].firstName.toString()),
      //           Text(alldata![index].lastName.toString()),
      //           Image.network(alldata![index].avatar.toString()),
      //
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
