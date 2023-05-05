// ignore_for_file: library_private_types_in_public_api, prefer_typing_uninitialized_variables, non_constant_identifier_names, unused_import, unused_local_variable, deprecated_member_use, must_be_immutable
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'UserModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_about_page/flutter_about_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:date_field/date_field.dart';
import 'package:get/get.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: First(),
    );
  }
}

/* class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Login(),
    );
  }
}
*/
class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  State<First> createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Smart Unlock'),
          centerTitle: true,
          backgroundColor: Colors.green[900],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/unlocklogo.png',
                width: 200,
                height: 200,
                alignment: AlignmentDirectional.topCenter,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                    elevation: 2,
                    backgroundColor: Colors.green[900]),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const Login(),
                  ));
                },
                child: const Text(
                  'Click to Login',
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(35.0, 25.0, 35.0, 25.0),
                    elevation: 2,
                    backgroundColor: Colors.green[900]),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample(),
                  ));
                },
                child: const Text(
                  'Scan to add Device',
                ),
              ),
            ],
          ),
        ));
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.green[900],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Phone"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone no';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  // heightFactor: 100,widthFactor: 250,
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 175, height: 55),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[900]),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate the user to the Home page
                          if (phoneController.text == "9100000000" &&
                              passwordController.text == "12345678") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Homepage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Invalid Credentials')),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      child: const Text(
                        'Login',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String _chosenValue = 'All';
String title1 = "MyTitle1";
String title2 = "MyTitle2";
String title3 = "MyTitle3";
String title4 = "MyTitle4";
bool isEditable1 = false;
bool isEditable2 = false;
bool isEditable3 = false;
bool isEditable4 = false;

// previous state -Home
/*class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: const TextStyle(color: Colors.green),

              items: <String>[
                'All',
                'Device1',
                'Device2',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _chosenValue = value!;
                });
                if (_chosenValue == 'All') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage()),
                  );
                }
                if (_chosenValue == 'Device1') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Homepage1()),
                      (Route<dynamic> route) => false);
                }
                if (_chosenValue == 'Device2') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage2()),
                  );
                }
              },
            ),

            /*
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    elevation: 2,
                    backgroundColor: Colors.green[900]),
                onPressed: () {
                  /* if (_chosenValue == 'Device1') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage1()),
                    );
                  }
                  if (_chosenValue == 'Device2') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage2()),
                    );
                  }
                  */
                },
                child: const Text(
                  'Click to Go ',
                ),
              ),
              */
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable1 = true,
                    }),
              },
              child: !isEditable1
                  ? Text(
                      title1,
                    )
                  : TextFormField(
                      initialValue: title1,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable1 = false, title1 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable2 = true,
                    }),
              },
              child: !isEditable2
                  ? Text(
                      title2,
                    )
                  : TextFormField(
                      initialValue: title2,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable2 = false, title2 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable3 = true,
                    }),
              },
              child: !isEditable3
                  ? Text(
                      title3,
                    )
                  : TextFormField(
                      initialValue: title3,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable3 = false, title3 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable4 = true,
                    }),
              },
              child: !isEditable4
                  ? Text(
                      title4,
                    )
                  : TextFormField(
                      initialValue: title4,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable4 = false, title4 = value});
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.home),
      ),
    );
  }
}
*/

//Homepage showing buttons of all devices ex- device1, device2

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: const TextStyle(color: Colors.green),

              items: <String>[
                'All',
                'Device1',
                'Device2',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _chosenValue = value!;
                });
                if (_chosenValue == 'All') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage()),
                  );
                }
                if (_chosenValue == 'Device1') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Homepage1()),
                      (Route<dynamic> route) => false);
                }
                if (_chosenValue == 'Device2') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage2()),
                  );
                }
              },
            ),

            /*
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    elevation: 2,
                    backgroundColor: Colors.green[900]),
                onPressed: () {
                  /* if (_chosenValue == 'Device1') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage1()),
                    );
                  }
                  if (_chosenValue == 'Device2') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Homepage2()),
                    );
                  }
                  */
                },
                child: const Text(
                  'Click to Go ',
                ),
              ),
              */
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable1 = true,
                    }),
              },
              child: !isEditable1
                  ? Text(
                      title1,
                    )
                  : TextFormField(
                      initialValue: title1,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable1 = false, title1 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable2 = true,
                    }),
              },
              child: !isEditable2
                  ? Text(
                      title2,
                    )
                  : TextFormField(
                      initialValue: title2,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable2 = false, title2 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable3 = true,
                    }),
              },
              child: !isEditable3
                  ? Text(
                      title3,
                    )
                  : TextFormField(
                      initialValue: title3,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable3 = false, title3 = value});
                      }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable4 = true,
                    }),
              },
              child: !isEditable4
                  ? Text(
                      title4,
                    )
                  : TextFormField(
                      initialValue: title4,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable4 = false, title4 = value});
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.home),
      ),
    );
  }
}

//String _value1 = 'Device1';

// Homepage1 for device 1
class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  _Homepage1State createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: const TextStyle(color: Colors.green),

              items: <String>[
                'All',
                'Device1',
                'Device2',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _chosenValue = value!;
                });
                if (_chosenValue == 'All') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage()),
                  );
                }
                if (_chosenValue == 'Device1') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Homepage1()),
                      (Route<dynamic> route) => false);
                }
                if (_chosenValue == 'Device2') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage2()),
                  );
                }
              },
            ),
            const Text('Device 1',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                )),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable1 = true,
                    }),
              },
              child: !isEditable1
                  ? Text(
                      title1,
                    )
                  : TextFormField(
                      initialValue: title1,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable1 = false, title1 = value});
                      }),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable2 = true,
                    }),
              },
              child: !isEditable2
                  ? Text(
                      title2,
                    )
                  : TextFormField(
                      initialValue: title2,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable2 = false, title2 = value});
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Homepage()),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.home),
      ),
    );
  }
}

// Homepage2 for device 2
//String _value2 = 'Device2';

class Homepage2 extends StatefulWidget {
  const Homepage2({super.key});

  @override
  _Homepage2State createState() => _Homepage2State();
}

class _Homepage2State extends State<Homepage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Home'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: _chosenValue,
              //elevation: 5,
              style: const TextStyle(color: Colors.green),

              items: <String>[
                'All',
                'Device1',
                'Device2',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),

              onChanged: (value) {
                setState(() {
                  _chosenValue = value!;
                });
                if (_chosenValue == 'All') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage()),
                  );
                }
                if (_chosenValue == 'Device1') {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Homepage1()),
                      (Route<dynamic> route) => false);
                }
                if (_chosenValue == 'Device2') {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Homepage2()),
                  );
                }
              },
            ),
            const Text('Device 2',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.black,
                )),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable3 = true,
                    }),
              },
              child: !isEditable3
                  ? Text(
                      title3,
                    )
                  : TextFormField(
                      initialValue: title3,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable3 = false, title3 = value});
                      }),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(45.0, 25.0, 45.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              onLongPress: () => {
                setState(() => {
                      isEditable4 = true,
                    }),
              },
              child: !isEditable4
                  ? Text(
                      title4,
                    )
                  : TextFormField(
                      initialValue: title4,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        setState(() => {isEditable4 = false, title4 = value});
                      }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Homepage()),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.home),
      ),
    );
  }
}

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.blue,
              gradient: LinearGradient(
                  colors: [Colors.green.shade800, Colors.blue.shade50]),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.add_home,
                  size: 48,
                  color: Colors.grey,
                ),
                const SizedBox(width: 18),
                Text(
                  'Welcome',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.black,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Homepage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.security,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Change Password',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const ChangePasswdpage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Settings',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const Settings()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.qr_code,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Add Device',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const QRViewExample()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.article,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Gate Log Report',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GateLogReport()),
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.logout,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'Sign Out',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              /*  int count = 0;
              Navigator.of(context).popUntil((_) => count++ >= 2);*/
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const First()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              size: 26,
              color: Colors.grey,
            ),
            title: Text(
              'About Smart Unlock',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.grey,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutApp()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class ChangePasswdpage extends StatefulWidget {
  const ChangePasswdpage({super.key});

  @override
  _ChangePasswdpageState createState() => _ChangePasswdpageState();
}

class _ChangePasswdpageState extends State<ChangePasswdpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordFieldController =
      TextEditingController();
  final TextEditingController _newPasswordFieldController =
      TextEditingController();
  final TextEditingController _repeatPasswordFieldController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        backgroundColor: Colors.green[900],
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _oldPasswordFieldController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Old Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _newPasswordFieldController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "New Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _repeatPasswordFieldController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Repeat Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints.tightFor(width: 175, height: 55),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 2, backgroundColor: Colors.green[900]),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate the user to the Home page

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Invalid Credentials')),
                          );
                        }
                      },
                      child: const Text(
                        'Change Password',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  //bool _lightTheme = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedTheme(
        data: Theme.of(context),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: Colors.green[900],
          ),
          drawer: const MainDrawer(),
        ));
  }
}
*/
//Add theme page settings

class Settings extends StatefulWidget {
  const Settings({super.key});
  @override
  _SettingsState createState() => _SettingsState();

  /// InheritedWidget style accessor to our State object.
  /// We can call this static method from any descendant context to find our
  /// State object and switch the themeMode field value & call for a rebuild.
  static _SettingsState of(BuildContext context) =>
      context.findAncestorStateOfType<_SettingsState>()!;
}

/// Our State object
class _SettingsState extends State<Settings> {
  /// 1) our themeMode "state" field
  ThemeMode _themeMode = ThemeMode.system;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, // 2) ← ← ← use "state" field here //////////////
      home: const SettingPage(title: 'Settings'),
    );
  }

  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}

class SettingPage extends StatelessWidget {
  final String title;
  const SettingPage({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green[900],
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Choose your theme:',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// //////////////////////////////////////////////////////
                /// Change theme & rebuild to show it using these buttons
                /// to find our State object and call changeTheme()
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2, backgroundColor: Colors.green[900]),
                    onPressed: () =>
                        Settings.of(context).changeTheme(ThemeMode.light),
                    child: const Text('Light')),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 2, backgroundColor: Colors.green[900]),
                    onPressed: () =>
                        Settings.of(context).changeTheme(ThemeMode.dark),
                    child: const Text('Dark')),

                /// //////////////////////////////////////////////////////
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[900]),
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return const Text('Flash On/Off');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[900]),
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return const Text('Flip Camera facing');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

Barcode? result;
UserModel userObject = UserModel(data: describeEnum({result!.code}));
Map<String, dynamic> userMap = userObject.toMap();
var json = jsonEncode(userMap);

print(json) {
  throw UnimplementedError();
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

// about page
class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('About App'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/unlocklogo.png',
              width: 100,
              height: 100,
              alignment: Alignment.topCenter,
            ), //FlutterLogo(size: 100),
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Smart Unlock App uses location data for backgound/foreground bluetooth scan to find, connect to, and detemine Smart Unlock device location for operating boom gate..',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            const Center(
              child: Text(
                'Designed & Developed By ',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  //fontFamily: "Oleo Script",
                  fontSize: 22,
                  //color: Colors.black87,
                ),
              ),
            ),

            Image.asset('assets/images/naveen.jpg',
                width: 100, height: 100),
            const Text(
              'Naveen Dwivedi.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10.0),
            Center(
              child: InkWell(
                  child: const Text('Contact Us',
                      style: TextStyle(fontSize: 24, color: Colors.blue)),
                  onTap: () {
                    const url = 'https://in.linkedin.com/in/naveen-dwivedi-517236192';
                    launchURL(url);
                    (Route<dynamic> route) => false;
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => const Homepage()),
            (Route<dynamic> route) => false,
          );
        },
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.home),
      ),
    );
  }
}

class GateLogReport extends StatelessWidget {
  const GateLogReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: const Text('Gate Log Report'),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Society',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Gate',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        elevation: 2,
                        backgroundColor: Colors.green[900]),
                    onPressed: () {},
                    child: const Text(
                      "Daily\nreport",
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        elevation: 2,
                        backgroundColor: Colors.green[900]),
                    onPressed: () {},
                    child: const Text(
                      "Weekly\nReport",
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        elevation: 2,
                        backgroundColor: Colors.green[900]),
                    onPressed: () {},
                    child: const Text(
                      "Monthly\nReport",
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            Form(
              child: Column(
                children: <Widget>[
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'Start Date & Time',
                    ),
                    firstDate: DateTime.now().add(const Duration(days: 10)),
                    lastDate: DateTime.now().add(const Duration(days: 40)),
                    initialDate: DateTime.now().add(const Duration(days: 20)),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (DateTime? e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {},
                  ),
                  const SizedBox(height: 50),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'End Date & Time',
                    ),
                    firstDate: DateTime.now().add(const Duration(days: 10)),
                    lastDate: DateTime.now().add(const Duration(days: 40)),
                    initialDate: DateTime.now().add(const Duration(days: 20)),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (DateTime? e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(40.0, 25.0, 40.0, 25.0),
                  elevation: 2,
                  backgroundColor: Colors.green[900]),
              onPressed: () {},
              child: const Text(
                "Get Report",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setState(Null Function() param0) async {}
}
