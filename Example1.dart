import 'dart:convert';

import 'package:api_practice/model/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Example1 extends StatefulWidget 
{
  const Example1({Key? key}) : super(key: key);

  @override
  State<Example1> createState() => _Example1State();
}

class _Example1State extends State<Example1>
{
  List<photos>? alldata;
  Future<List<photos>?> getdata()async{
    Uri url = Uri.parse("https://jsonplaceholder.typicode.com/photos");
    var res = await http.get(url);
    if(res.statusCode==200){
      var json = jsonDecode(res.body.toString());
      alldata = json.map<photos>((obj)=>photos.fromJson(obj)).toList();
      return alldata;
    }
  }
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getdata();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Icon(Icons.add_a_photo),
          Icon(Icons.construction_sharp),
          Text("dedede"),
          Expanded(
            child: FutureBuilder(
              future: getdata(),
              builder: (context, snapshot) {
                 if(snapshot.hasData){
                   if(snapshot.data!.isEmpty){
                     return Text("No Data");
                   }
                   else{
                     return ListView.builder(
                       itemCount: alldata!.length,
                       itemBuilder: (context, index) {
                         return Container(
                           child: ListTile(
                             leading: CircleAvatar(
                                 backgroundImage: NetworkImage(alldata![index].url.toString())
                             ),
                             title: Text(alldata![index].title.toString()),
                             subtitle: Text(alldata![index].id.toString()),
                           ),
                         );
                       },
                     );
                   }
                 }
                 else{
                   return Center(
                     child: CircularProgressIndicator(color: Colors.black,),
                   );
                 }
              },
            ),
          ),
        ],
      ),
      // body: (alldata==null)?Center(child: CircularProgressIndicator(),):ListView.builder(
      //   itemCount: alldata!.length,
      //   itemBuilder: (context, index) {
      //     return Container(
      //       child: ListTile(
      //         leading: CircleAvatar(
      //           radius: 30.0,
      //             child: Image.network(alldata![index].url.toString())
      //         ),
      //         title: Text(alldata![index].title.toString()),
      //         subtitle: Text(alldata![index].id.toString()),
      //       ),
      //     );
      //   },
      // )
    );
  }
}
