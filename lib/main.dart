import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'Users.dart';
import 'Services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
//      home: MyHomePage(title: 'Flutter Demo Home Page'),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BehaviorSubject<List<Users>> streamcontroller= new BehaviorSubject<List<Users>>();
  StreamTransformer<List<Users>,List<Users>> get streamTransformer => StreamTransformer<List<Users>,List<Users>>.fromHandlers(
    handleData:(data,sink){
      if(data.length >0){
        sink.add(data);
      }
    },
    handleError: (error, stackTrace, sink) {},
  );
 List<Users> users;
 bool _loading =true;
  @override
  void initState() {
    super.initState();
    fetchData();
//    _loading=true;
//    Services.getUsers().then((users){
//      this.users =users;
//      _loading=false;
//      setState(() {
//
//      });
//    }).catchError((e){
//      _loading=true;
//    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Steram builder"),
      ),
//      body: getListData()
//      body: usingFutureBuilder()
    body: usingStreamBuilde(),
    );
  }

  Widget usingStreamBuilde(){
    return StreamBuilder(
//      stream: streamcontroller.transform(streamTransformer),
      stream: streamcontroller.stream,
      builder: (context,snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.none:
            return Container(
                child:  Center(child: CircularProgressIndicator())
            );

            break;
          case ConnectionState.waiting:
            return Container(
                child:  Center(child: CircularProgressIndicator())
            );
            break;
          case ConnectionState.active:

          case ConnectionState.done:
            if(snapshot.hasData){

              return  Container(
                child: ListView.builder(
                    itemCount: snapshot.data == null ?0 :snapshot.data.length,
                    itemBuilder: (context,index){
                      Users user = snapshot.data[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text(user.email),
                      );
                    }
                ),
              );
            }else{
              return Container(
                  child:   Center(child: CircularProgressIndicator())
              );
            }
            break;
          default:
            return Container(
                child:  Center(child: CircularProgressIndicator())
            );
            break;
        }
      },
    );
  }

  fetchData(){
    Services.getUsers().asStream().listen((value){
      streamcontroller.sink.add(value);
    });
  }

  Widget getListData(){
    return  _loading ==true ? Center(child: CircularProgressIndicator(),) : Container(
      child: ListView.builder(
          itemCount: users == null ?0 :users.length,
          itemBuilder: (context,index){
            Users user = users[index];
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.email),
            );
          }
      ),
    );
  }

  Widget usingFutureBuilder(){
    return FutureBuilder(
      future:  Services.getUsers(),
      builder:(context,snapshot) {
       switch(snapshot.connectionState){
         case ConnectionState.none:
           return Container(
             child:  Center(child: CircularProgressIndicator())
           );

           break;
         case ConnectionState.waiting:
           return Container(
               child:  Center(child: CircularProgressIndicator())
           );
           break;
         case ConnectionState.active:
           return Container(
               child:   Center(child: CircularProgressIndicator())
           );
           break;
         case ConnectionState.done:
           if(snapshot.hasData){

             return  Container(
               child: ListView.builder(
                   itemCount: snapshot.data == null ?0 :snapshot.data.length,
                   itemBuilder: (context,index){
                     Users user = snapshot.data[index];
                     return ListTile(
                       title: Text(user.name),
                       subtitle: Text(user.email),
                     );
                   }
               ),
             );
           }else{
             return Container(
                 child:   Center(child: CircularProgressIndicator())
             );
           }
           break;
         default:
           return Container(
               child:  Center(child: CircularProgressIndicator())
           );
           break;
       }
      },);
  }

}




//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
// final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  void Call(){
//    print("Method 1");
//    this.method2();
//    print("Method 3");
//    print("Method 4");
//  }
//
//  method2() async{
//    await Future.delayed(Duration(seconds: 4),(){
//    });
//    print("Method 2");
//  }
//  @override
//  Widget build(BuildContext context) {
//
//    return Scaffold(
//      appBar: AppBar(
//              title: Text(widget.title),
//      ),
//      body: Center(
//        child:RaisedButton(onPressed: (){Call();},child: Text("Click Me"),)
//      ),
//     
//    );
//  }
//}
