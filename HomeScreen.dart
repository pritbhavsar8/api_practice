import 'dart:convert';

import 'package:api_practice/model/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
{
 Future<List>? alldata;
 Future<List> getdeta() async{
   Uri url = Uri.parse("https://jsonplaceholder.typicode.com/users");
   var res = await http.get(url);
   if(res.statusCode==200){
     var body = res.body.toString();
     var json = jsonDecode(body);
     return json;
   }
   else{
     return [];
   }
 }
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    setState(() {
      alldata= getdeta();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder(
        future: alldata,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!.length<=0){
              return Center(
                child: Text("no data"),
              );
            }
            else{
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(20),
                          color: Colors.orange.shade50
                      ),
                      child: Column(
                        children: [
                          Text(snapshot.data![index]["name"].toString()),
                          Text(snapshot.data![index]["username"].toString()),
                          Text(snapshot.data![index]["email"].toString()),
                          Text(snapshot.data![index]["address"]["street"]),
                          Text(snapshot.data![index]["address"]["geo"]["lat"].toString()),
                          // Text(snapshot.data![index]["address"]["street"]["geo"]["lng"]),
                        ],
                      )
                  );
                },
              );
            }
          }
          else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
