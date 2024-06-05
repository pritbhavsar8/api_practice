import 'dart:convert';

import 'package:api_practice/model/users2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example3 extends StatefulWidget
{
  const Example3({super.key});

  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3> {
  List<Users> ?alldata;
  getdata() async{
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var res = await http.get(url);
    if(res.statusCode==200){
      var body = res.body.toString();
      var json = jsonDecode(body);
      setState(() {
        alldata = json.map<Users>((obj)=>Users.fromJson(obj)).toList();
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
        title: Text("Example3"),
        centerTitle: true,
      ),
      body: (alldata==null)?Center(child: CircularProgressIndicator(),): ListView.builder(
        itemCount: alldata!.length,
        itemBuilder: (context, index) {
          print(alldata);
          return ListTile(
            title: Text(alldata![index].address!.city.toString()),
            subtitle:Text(alldata![index].address!.geo!.lat.toString()),
          );
        },
      ),
      // body: FutureBuilder(
      //   future: getdata(),
      //   builder: (context, snapshot) {
      //     if(snapshot.hasData){
      //       if(snapshot.data!.length<=0){
      //         return Center(child: Text("NO Data"),);
      //       }
      //       else{
      //         L
      //
      //       }
      //
      //     }
      //     else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
    );
  }
}
