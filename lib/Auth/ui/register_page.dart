import 'package:flutter/material.dart';
import 'package:flutter_app_firebase/Auth/providers/auth_provider.dart';
import 'package:flutter_app_firebase/Auth/ui/widgets/custom_textField.dart';
import 'package:flutter_app_firebase/global_widgets/custom_button.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  static final routeName = 'register';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<AuthProvider>(
      builder: (context, provider, x) {
        return Column(
          children: [
            CustomTextfield('FirstName', provider.firstNameController),
            CustomTextfield('LastName', provider.lastNameController),
            CustomTextfield('Country', provider.countryController),
            CustomTextfield('City', provider.cituController),
            CustomTextfield('Email', provider.emailController),
            CustomTextfield('Password', provider.passwordController),
            CustomButton(provider.register, 'Register'),
          ],
        );
      },
    );
  }
}