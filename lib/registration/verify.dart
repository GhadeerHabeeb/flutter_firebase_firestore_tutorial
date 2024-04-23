import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/HomePage.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/LessonsPage.dart';
import 'package:flutter_firebase_firestore_tutorial/registration/phone.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
 final String verifyId;
    MyVerify({required this.verifyId,Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  final auth=FirebaseAuth.instance;
  String code='';
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo2.png',
                  width: 300,
                  height: 300,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              Text(
                "ادخل الارقام",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Tajawal',
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                 /*defaultPinTheme: defaultPinTheme,*/

                 focusedPinTheme: focusedPinTheme,
                 submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
                onChanged: (value){
                   code=value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: ()  async {
                      try{
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                            verificationId:widget.verifyId,
                            smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context)=>HomePage()));
                      }
                      catch(e){
                        print(e);
                      }

                    },
                    child: Text("تحقق من الرقم",style: TextStyle(
                      fontSize:25,
                      color: Colors.black,
                      fontFamily: 'Tajawal',
                    ),)),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: Text(
                        "تعديل رقم الهاتف؟",
                        style: TextStyle(
                            fontFamily: 'Tajawal',
                            color: Colors.black,
                            fontSize: 20,
                        ),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
