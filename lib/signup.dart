// ignore_for_file: camel_case_types, prefer_const_constructors, prefer_final_fields, unused_field, unused_import, curly_braces_in_flow_control_structures

import 'package:contact/controller/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  final formkey = GlobalKey <FormState>();
  bool isPasswordVisible = false;
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.purple[50],

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left:20, right: 20, top: 28),
          child: Form(
            key: formkey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image.asset('images/sign.png', width: 250,height: 250,),


                Text('SIGN UP',
                style: GoogleFonts.lora(
                  fontSize: 40,
                  fontWeight: FontWeight.w700
                  
                   
                ),),
                Text('Create your account below',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w200,
                  color: Colors.black45
                  
                   
                ),),
          
          
                SizedBox(height: 20,),

                namefield(context),
          
          SizedBox(height: 20,),


                emailfield(),
          
          
                SizedBox(height: 20,),
          
          
                passwordfield(),
                SizedBox(height: 32,),
                
                
                signupbutton(context),
                
                
                  SizedBox(height: 20,),
                
                
                
                
                  googleloginbutton(context),
                
                  SizedBox(height: 20,),
                
                
                  login(context)
              ],
            ),
          ),
        ),
      ),

    );
  }



  

  Row login(BuildContext context) {
    return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('LogIn', style: TextStyle(
                      fontSize: 18),))
                  ],
                );
  }

  OutlinedButton googleloginbutton(BuildContext context) {
    return OutlinedButton(
                  onPressed: (){

                    AuthService().continueWithGoogle().then((value){
                      if (value == "Google account login successfull..."){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: 
                          Text('Google Login Successfully..')));
                          Navigator.pushNamed(context, "/home");

                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: 
                          Text(value, style: TextStyle(
                            color: Colors.white,
                          ),), backgroundColor: Colors.red.shade400,));

                      }

                    });
                    
                  }, child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('images/gog.png', height: 30, width: 30,),
                    SizedBox(width: 10,),
                    Text('Continue with google', style: TextStyle(
                      fontSize: 16),)
                  ],
                ));
  }

  SizedBox signupbutton(BuildContext context) {
    return SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width * .9,
                child: ElevatedButton(onPressed: (){
                  
                  if (formkey.currentState!.validate()){
                    AuthService().createAccountWithEmail(_emailcontroller.text, _passwordcontroller.text).then((value) {
                      if (value == "Account Created"){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: 
                          Text('Account created successfully..!')));
                          Navigator.pushNamed(context, "/home");

                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: 
                          Text(value, style: TextStyle(
                            color: Colors.white,
                          ),), backgroundColor: Colors.red.shade400,));

                      }
                    });


                  }
                  
                }, child: Text("SignUp", style: TextStyle(
                  fontSize: 20
                ),)));
  }

  TextFormField passwordfield() {
    return TextFormField(
                validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Password must not be empty';
            } else if (value.length < 8) {
              return 'Password must be at least 8 characters';
            } else {
              return null;
            }
            
          },
                controller: _passwordcontroller,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),),
                  label: Text('Password'),
                  hintText: 'Enter your Password here',

                  suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                isPasswordVisible = !isPasswordVisible; // Toggle visibility
              });
            },
          ),
                ),
                
              );
  }

  TextFormField emailfield() {
    return TextFormField(
                validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Email must not be empty';
          } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
            return 'Enter a valid email';
          }
          return null;
        },
                controller: _emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(

                  prefixIcon: Icon(Icons.email_outlined),
                  
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  label: Text('Email'),
                  hintText: 'Enter your Email here'
                ),
                
              );
  }

  Container namefield(BuildContext context) {
    return Container(
width: MediaQuery.of(context).size.width * 0.89, // 80% of the screen width
// height: 60, // Fixed height
child: Row(
  children: [
    Flexible(
      child: TextFormField(
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Name must not be empty';
          } else return null;
          
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: 'First Name',
          hintText: 'John',
        ),
      ),
    ),
    SizedBox(width: 8),
    Flexible(
      child: TextFormField(
        keyboardType: TextInputType.name,
        
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
          labelText: 'LastName',
          hintText: 'Doe',
        ),
      ),
    ),
  ],
),
);
  }
}