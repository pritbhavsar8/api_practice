import 'dart:convert';

import 'package:api_practice/model/poke.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexApi extends StatefulWidget 
{
  const ComplexApi({super.key});
  @override
  State<ComplexApi> createState() => _ComplexApiState();
}

class _ComplexApiState extends State<ComplexApi> 
{
  Future<Poke> getdata() async{
    Uri url = Uri.parse("https://pokeapi.co/api/v2/pokemon/ditto");
    var res = await http.get(url);
    var json = jsonDecode(res.body.toString());
    if(res.statusCode==200){

      return Poke.fromJson(json);
    }
    else{
      return Poke.fromJson(json);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Api"),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            if(snapshot.data==null){
              return Center(
                child: Text("No Data"),
              );
            }
            else{
              return ListView.builder(
                  itemCount: snapshot.data!.abilities!.length,
                  itemBuilder:(context, index) {
                    return Column(
                      children: [
                        ListTile(
                          title: Text(snapshot.data!.abilities![0].ability!.name.toString()),
                          subtitle:Image.network(snapshot.data!.abilities![0].ability!.url.toString()) ,
                          trailing: Text(snapshot.data!.abilities![0].isHidden.toString()),
                          leading: Text(snapshot.data!.abilities![0].slot.toString()),
                          
                        ),
                      ],
                    );
      
                  },
              );
      
            }
          }
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
