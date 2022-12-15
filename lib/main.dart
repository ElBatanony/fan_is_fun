// ignore_for_file: sort_child_properties_last

import 'dart:html';

import 'package:course_example_app/support.dart';
import 'package:course_example_app/timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'fire_auth.dart';

void main() async {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: SignUp(),
          );
        } else {
          return Scaffold(
            body: Container(
              child: Support(),
            ),
          );
        }
      },
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  late String email;
  late String password;
  late String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'), backgroundColor: Colors.orange),
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Text("Skip"),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Support()));
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Form(
              child: Column(
            children: [
              Image(
                  image: AssetImage('images/logo.png'),
                  width: 200,
                  height: 200),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    hintText: "Enter your Email"),
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                    hintText: "Enter your Password",
                    prefixIcon: Icon(Icons.lock_outlined),
                  ),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "FirstName",
                      hintText: "Enter your FirstName"),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  }),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Lastname",
                    hintText: "Enter your LastName"),
              ),
              SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description about me",
                  hintText: "Enter description about you",
                ),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 100,
                width: 100,
                child: FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery,
                        context: context);
                  },
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(
                    Icons.photo,
                    size: 50,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                child: ElevatedButton(
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () async {
                    FireAuth.registerUsingEmailPassword(
                        name: name, email: email, password: password);

                    final isLoggedIn = await FireAuth.signInUser(
                        email: email, password: password);

                    if (isLoggedIn) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyWidget()));
                    }
                  },
                ),
                height: 50,
                width: 400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Already have an account?',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: const Text(
                      'Log in',
                      style: TextStyle(fontSize: 25),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LogIn()));
                    },
                  )
                ],
              ),
            ],
          )),
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: source,
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    String email = "";
    String password = "";

    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Image(image: AssetImage('images/logo.png'), width: 200, height: 200),
          SizedBox(
            height: 50,
          ),
          TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                hintText: "Enter your Email"),
            onChanged: (value) {
              email = value;
            },
          ),
          SizedBox(
            height: 50,
          ),
          TextFormField(
            obscureText: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Password",
              hintText: "Enter your Password",
              prefixIcon: Icon(Icons.lock_outlined),
            ),
            onChanged: (value) {
              password = value;
            },
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: ElevatedButton(
              child: Text('Log In'),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 30),
              ),
              onPressed: () async {
                final isLoggedIn =
                    await FireAuth.signInUser(email: email, password: password);
                if (isLoggedIn) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyWidget()));
                }
              },
            ),
            height: 50,
            width: 400,
          ),
          Row(
            children: <Widget>[
              const Text(
                'Dont have an account?',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 25),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SignUp()));
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var email = "null";

  @override
  Widget build(BuildContext context) {
    var currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.email != null) {
      email = currentUser.email!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Main Page"),
      ),
      body: Container(
        child: ElevatedButton(
          child: Text("Go to the timer"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Countdown()));
          },
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser!.email;
    print("here1");
    return Scaffold(
      appBar: AppBar(title: Text("User Loged in")),
      body: Container(
        child: Text(
          "$email",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
