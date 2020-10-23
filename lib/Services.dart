import 'package:asynchronousflutter/Users.dart';
import 'package:http/http.dart' as http;
import 'Users.dart';
class Services{
    static const url = "https://jsonplaceholder.typicode.com/users/";

 static Future<List<Users>>  getUsers() async{


    try {
      var response = await http.get(url);
      if(response.statusCode == 200){
        print("type of json ===> ${response.body.runtimeType}");
        List<Users> users=  usersFromJson(response.body);
       return users;
      }else{
       return List<Users>();
      }
    } on Exception catch (e) {
      print("error ==> ${e}");
     return List<Users>();
    }

  }
}