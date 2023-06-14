import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({Key? key}) : super(key: key);

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Student Registration', style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 24
                  ),),
                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter name';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Full Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: idController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter teacher ID who is guide you';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Your Teacher ID',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: emailController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter email';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    controller: passwordController,
                    validator: (String? value){
                      if(value?.trim().isEmpty ?? true)
                      {
                        return 'Enter password';
                      }
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.green
                            )
                        )
                    ),
                  ),
                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: (){
                        if(formKey.currentState!.validate()){
                          Get.showSnackbar(
                            const GetSnackBar(
                              title: 'Welcome',
                              message: 'Successfully Registered',
                            ),
                          );


                        }
                      }, child: const Text('Next'))
                ],
              ),
            ),
          ),
        ),
      ),

    );


  }
}
