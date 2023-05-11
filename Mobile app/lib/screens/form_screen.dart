import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'home_screen.dart';

final _firebase = FirebaseAuth.instance;

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<FormScreen> {
  int _activeStepIndex = 0;
  final _form = GlobalKey<FormState>();

  var _islogin = true;
  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    try {
      if (_islogin) {
        final userCredentials = _firebase.signInWithEmailAndPassword(
            email: email.text, password: pass.text);
      } else {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: email.text, password: pass.text);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'uid': userCredentials.user!.uid,
          'username': name.text,
          'email': email.text,
          'address': address.text,
          'care_giver_email': CareGiverEmail.text,
        });
        print(userCredentials);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.message ?? 'Authentication failed'),
      ));
    }
  }

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController CareGiverEmail = TextEditingController();
  String? finalGender;
  void homeScreen(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return HomePage();
        },
      ),
    );
  }

  List<Step> stepList() => [
        Step(
          state: _activeStepIndex <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeStepIndex >= 0,
          title: const Text(
            'Account Details',
            style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2),
          ),
          content: Container(
            child: Column(
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Full Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: email,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !EmailValidator.validate(value)) {
                        return 'Invalid email!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      print(value);
                      setState(() {
                        _enteredEmail = value!;
                      });
                    }),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                    controller: pass,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'password',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 5) {
                        return 'Password is too short!';
                      }
                    },
                    onSaved: (value) {
                      setState(() {
                        _enteredPassword = value!;
                      });
                    }),
                GenderPickerWithImage(
                  verticalAlignedText: false,
                  selectedGender: Gender.Male,
                  selectedGenderTextStyle: TextStyle(
                      color: Color(0xFF8b32a8), fontWeight: FontWeight.bold),
                  unSelectedGenderTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.normal),
                  onChanged: (Gender? gender) {
                    if (gender.toString() == 'Gender.Male') {
                      finalGender = 'Male';
                    } else {
                      finalGender = 'Female';
                    }
                    print(gender);
                  },
                  equallyAligned: true,
                  animationDuration: Duration(milliseconds: 300),
                  isCircular: true,
                  // default : true,
                  opacityOfGradient: 0.4,
                  padding: const EdgeInsets.all(3),
                  size: 50, //default : 40
                ),
              ],
            ),
          ),
        ),
        Step(
            state:
                _activeStepIndex <= 1 ? StepState.editing : StepState.complete,
            isActive: _activeStepIndex >= 1,
            title: const Text(
              'Additional information',
              style: TextStyle(
                fontFamily: 'Bebas',
                letterSpacing: 2,
              ),
            ),
            content: Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: address,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Present Address',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: CareGiverEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Care giver email',
                    ),
                  ),
                ],
              ),
            )),
        Step(
            state: StepState.complete,
            isActive: _activeStepIndex >= 2,
            title: const Text(
              'Confirm Details',
              style: TextStyle(
                fontFamily: 'Bebas',
                letterSpacing: 2,
              ),
            ),
            content: Container(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Name: ${name.text}'),
                Text('Email: ${email.text}'),
                Text('Address : ${address.text}'),
                Text('Care Giver Email : ${CareGiverEmail.text}'),
                Text('Gender : $finalGender'),
              ],
            )))
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: _islogin
            ? const Text(
                'Login',
                style: TextStyle(
                  fontFamily: 'Bebas',
                  letterSpacing: 1,
                ),
              )
            : const Text('Sign up',
                style: TextStyle(
                  fontFamily: 'Bebas',
                  letterSpacing: 1,
                )),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Form(
            key: _form,
            child: _islogin
                ? Center(
                    child: Container(
                      width: 250,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 100,
                          ),
                          TextFormField(
                              controller: email,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !EmailValidator.validate(value)) {
                                  return 'Invalid email!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                print(value);
                                setState(() {
                                  _enteredEmail = value!;
                                });
                              }),
                          const SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                              controller: pass,
                              obscureText: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                              ),
                              validator: (value) {
                                if (value!.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                              },
                              onSaved: (value) {
                                setState(() {
                                  _enteredPassword = value!;
                                });
                              }),
                          SizedBox(
                            height: 50,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _submit();
                            },
                            child: Text('Login'),
                          )
                        ],
                      ),
                    ),
                  )
                : Stepper(
                    type: StepperType.vertical,
                    currentStep: _activeStepIndex,
                    steps: stepList(),
                    onStepContinue: () {
                      if (_activeStepIndex < (stepList().length - 1)) {
                        setState(() {
                          _activeStepIndex += 1;
                        });
                      } else {
                        _submit();
                        print('Submited');
                      }
                    },
                    onStepCancel: () {
                      if (_activeStepIndex == 0) {
                        return;
                      }

                      setState(() {
                        _activeStepIndex -= 1;
                      });
                    },
                    onStepTapped: (int index) {
                      setState(() {
                        _activeStepIndex = index;
                      });
                    },
                    controlsBuilder: null),
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  if (_islogin) {
                    _islogin = false;
                  } else {
                    _islogin = true;
                  }
                });
              },
              child: _islogin
                  ? const Text('don\'t have an account? Sign up')
                  : const Text('already have an account? Sign in'))
        ],
      ),
    );
  }
}
