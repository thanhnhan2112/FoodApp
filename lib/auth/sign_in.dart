import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:foodapp/screens/home_screen/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';


class SignIn extends StatefulWidget{
  @override
  _SignInState createState()=> _SignInState();
}

class _SignInState extends State<SignIn>{
  //UserProvider userProvider;

  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      // userProvider.addUserData(
      //   currentUser: user,
      //   userEmail: user.email,
      //   userImage: user.photoURL,
      //   userName: user.displayName,
      // );
      return user;
    } catch (e) {
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text("Đăng nhập để tiếp tục"),
                  const Text("Ti En",
                    style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    shadows: [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.green,
                        offset: Offset(3, 3)
                      )
                    ]
                    ),
                  ),
                  Column(
                    children: [
                      SignInButton(
                        Buttons.Google,
                        text: "Đăng nhập với Google",
                        onPressed: () {
                          _googleSignUp().then(
                            (value) => Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context)=> HomeScreen())));
                        },
                      ),
                      SignInButton(
                        Buttons.Facebook,
                        text: "Đăng nhập với Facebook",
                        onPressed: () {},
                  ),
                    ],
                  ),               
                  Column(
                    children: const[
                       Text("Chúng tôi sẽ không sử dụng thông tin của bạn với bất kỳ mục đích nào khác.",
                      style: TextStyle(color:Colors.grey),textAlign: TextAlign.center,),
                       Text("Điều khoản và chính sách",
                  style: TextStyle(color:Colors.grey),), 
                    ],
                  ),
                           
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  

}