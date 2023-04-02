import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _addressController = TextEditingController();
  final _nicknameController = TextEditingController();
  final _schoolController = TextEditingController();
  final _hobbiesController = TextEditingController();

  String _errorMessage = '';
  bool _isLoading = false;

  Future<void> _signup() async {
    setState(() {
      _errorMessage = '';
      _isLoading = true;
    });

    try {
      final auth = FirebaseAuth.instance;
      final authResult = await auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final user = authResult.user;
      final userData = {
        'name': _nameController.text.trim(),
        'age': int.parse(_ageController.text.trim()),
        'address': _addressController.text.trim(),
        'nickname': _nicknameController.text.trim(),
        'school': _schoolController.text.trim(),
        'hobbies': _hobbiesController.text.trim(),
      };
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .set(userData);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', user.uid);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Sign up')),
        body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
    child: Form(
    key: _formKey,
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    TextFormField(
    controller: _emailController,
    decoration: InputDecoration(labelText: 'Email'),
    keyboardType: TextInputType.emailAddress,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your email.';
    }
    return null;
    },
    ),
    TextFormField(
    controller: _passwordController,
    decoration: InputDecoration(labelText: 'Password'),
    obscureText: true,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your password.';
    }
    return null;
    },
    ),
    TextFormField(
    controller: _nameController,
    decoration: InputDecoration(labelText: 'Name'),
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your name.';
    }
    return null;
    },
    ),
    TextFormField(
    controller: _ageController,
    decoration: InputDecoration(labelText: 'Age'),
    keyboardType: TextInputType.number,
    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter your age.';
    }
    if (int.parse(value) <= 0) {
      return 'Please enter a valid age.';
    }
    return null;
    },
    ),
      TextFormField(
        controller: _addressController,
        decoration: InputDecoration(labelText: 'Address'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your address.';
          }
          return null;
        },
      ),
      TextFormField(
        controller: _nicknameController,
        decoration: InputDecoration(labelText: 'Nickname'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your nickname.';
          }
          return null;
        },
      ),
      TextFormField(
        controller: _schoolController,
        decoration: InputDecoration(labelText: 'School'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your school.';
          }
          return null;
        },
      ),
      TextFormField(
        controller: _hobbiesController,
        decoration: InputDecoration(labelText: 'Hobbies'),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your hobbies.';
          }
          return null;
        },
      ),
      SizedBox(height: 16.0),
      ElevatedButton(
        onPressed: _isLoading ? null : _signup,
        child: Text('Sign up'),
      ),
      if (_errorMessage.isNotEmpty)
        Text(
          _errorMessage,
          style: TextStyle(color: Colors.red),
        ),
    ],
    ),
    ),
        ),
    );
  }
}
