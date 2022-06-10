import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../constant.dart';
import 'loginscreen.dart';

class RegisterSc extends StatefulWidget {
  const RegisterSc({Key? key}) : super(key: key);

  @override
  State<RegisterSc> createState() => _RegisterScState();
}

class _RegisterScState extends State<RegisterSc> {
  final formKey = new GlobalKey<FormState>();
  late double screenHeight, screenWidth, ctrwidth;
  bool _isChecked = false;
  var _image;
  String pathImageAsset = 'assets/images/avatar.png';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final TextEditingController _addController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: HexColor('#457b9d'),
        title: const Text('MY TUTOR -- User Registration'),
      ),
      body: SingleChildScrollView(
          child: Center(
              child: SizedBox(
        width: ctrwidth,
        child: Form(
          key: formKey,
          child: Column(children: [
            const SizedBox(height: 10),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: GestureDetector(
                  onTap: () => {_takePictureDialog()},
                  child: SizedBox(
                      height: 200,
                      width: 200,
                      child: _image == null
                          ? Image.asset(pathImageAsset)
                          : Image.file(
                              _image,
                              fit: BoxFit.contain,
                            ))),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                  labelText: 'Username',
                  prefixIcon: const Icon(Icons.people),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid username';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 2),
                      child: Icon(Icons.email)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Phone Number',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 3),
                      child: Icon(Icons.phone)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid phone number';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _passController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.password),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please re-enter password';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _confirmPassController,
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  prefixIcon: const Icon(Icons.password),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value != _passController.text) {
                  return 'Please enter correct password';
                }
                return null;
              },
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _addController,
              keyboardType: TextInputType.multiline,
              maxLines: 2,
              decoration: InputDecoration(
                  labelText: 'Address',
                  alignLabelWithHint: true,
                  prefixIcon: const Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Icon(Icons.house)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0))),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: screenWidth,
              height: 50,
              child: ElevatedButton(
                child: const Text("Register Now"),
                onPressed: () {
                  _regDialog();
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already Register?"),
                TextButton(
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 8.0)),
                  child: const Text("Login Now",
                      style: TextStyle(fontWeight: FontWeight.w300)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (content) => const LoginPage()));
                  },
                ),
              ],
            ),
          ]),
        ),
      ))),
    );
  }

  _takePictureDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            title: const Text(
              "Select from",
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          _galleryPicker(),
                        },
                    icon: const Icon(Icons.browse_gallery),
                    label: const Text("Gallery")),
                TextButton.icon(
                    onPressed: () =>
                        {Navigator.of(context).pop(), _cameraPicker()},
                    icon: const Icon(Icons.camera_alt),
                    label: const Text("Camera")),
              ],
            ));
      },
    );
  }

  _galleryPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  _cameraPicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 800,
      maxWidth: 800,
    );
    if (pickedFile != null) {
      _image = File(pickedFile.path);
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: _image!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          // CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.original,
          // CropAspectRatioPreset.ratio4x3,
          // CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blueGrey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    if (croppedFile != null) {
      _image = croppedFile;
      setState(() {});
    }
  }

  void _regDialog() {
    if (formKey.currentState!.validate() && _image != null) {
      formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: const Text(
              "MY Tutor -- User Register",
              style: TextStyle(),
            ),
            content: const Text("Register Now?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _addTutor();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void _addTutor() {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String pass = _passController.text;
    String add = _addController.text;
    String base64image = base64Encode(_image!.readAsBytesSync());

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      http.post(Uri.parse(CONSTANTS.server + "/mytutor/php/userReg.php"),
          body: {
            'name': name,
            'email': email,
            'phone': phone,
            'pass': pass,
            'add': add,
            'image': base64image,
          }).then((response) {
        print(response.body);
        var data = jsonDecode(response.body);
        if (response.statusCode == 200 && data['status'] == 'success') {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
          Navigator.push(context,
              MaterialPageRoute(builder: (content) => const LoginPage()));
        } else {
          Fluttertoast.showToast(
              msg: data['status'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 16.0);
        }
      });
    }
  }
}
