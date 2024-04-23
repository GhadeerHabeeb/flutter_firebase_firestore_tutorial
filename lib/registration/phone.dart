
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/picker.dart';
import 'package:flutter_firebase_firestore_tutorial/registration/verify.dart';
class MyPhone extends StatefulWidget {
    MyPhone({Key? key}) : super(key: key);
 static String VerifyId="";
  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  final auth=FirebaseAuth.instance;
  var phone='';
  bool showLoading=false;

    @override
  void initState() {
    // TODO: implement initState

    countryController.text = "+964";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child:showLoading?CircularProgressIndicator(): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                  height: 300,
                ),
              ),
              SizedBox(
                height: 25,
              ),

              SizedBox(
                height: 10,
              ),
              Text(
                "! يرجى ادخال الرقم الخاص بك ",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Tajawal'
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(

                          onChanged: (value){
                           setState(() {
                             phone=value;
                           });
                          },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
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
                    onPressed: ()  {

                          _phoneAuth();
                    },
                    child: Text("إرسال",style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      fontFamily:'Tajawal',
                    ),)),
              )
            ],
          ),
        ),
      ),
    );
  }
  _phoneAuth()
  async {
    try{
      print(countryController.text + phone);
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${countryController.text + phone}',

        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);


        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            _displayTextInputDialog(context);
          };
        },
        codeSent: (String verificationId, int? resendToken) {
          print(resendToken);
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context)=>MyVerify(verifyId:verificationId) ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }
    catch(e)
    {
     print(e);
    }

  }
}

void _displayTextInputDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title:Image.asset('assets/images/warning.gif'),
        content:  Text('The provided phone number is not valid.'),
        actions: <Widget>[
          MaterialButton(
            color: Colors.amber,
            textColor: Colors.white,
            child: const Text('Ok'),
            onPressed: () {
              /*    Todo todo = Todo(
                    task: _textEditingController.text,
                    title:'',
                    isDone: false,
                    createdOn: Timestamp.now(),
                    updatedOn: Timestamp.now(),


             );
                _databaseService.addTodo(todo);*/

              Navigator.pop(context);

            },
          ),
        ],
      );
    },
  );
}
