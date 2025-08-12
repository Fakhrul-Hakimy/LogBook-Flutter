import 'package:flutter/material.dart';
import 'package:logbook/models/user.dart';
import 'package:logbook/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
  
  
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  

  Future<bool> authenticate() async {
    String username = usernameController.text;
    String password = passwordController.text;
    users user = users(username: username, password: password);
    final authService = AuthService();
    try {
      bool response = await authService.checkLogin(user);
      if (response == true) {
        bool tokenValid = await authService.verifyToken();
        if (!tokenValid) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Token verification failed!"))
          );
          return false; 
        }
        return true; 
      }
    } catch (e) {
      return false; 
    }
    return false; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Icon(
                  Icons.login,
                  size: 100,
                  color: Colors.blue,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: TextField(controller: usernameController,
                  
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name...',
                    
                  ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: TextField(controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    
                    border: OutlineInputBorder(),
                    hintText: 'Enter password...',
                    
                  ),
                  
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 10),
                  child: ElevatedButton(onPressed: () async  {
                    bool access = await authenticate();
                    if(access){
                      Navigator.pushNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Invalid credentials!"))
                      );
                    }
                  },
                  child: Text("Login")),
                ),
                TextButton(
                  child: Text("Don't have an account?"),
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                )
              ],
             
            ),
          ),
        ),
      )
      );
  }
}