import 'package:driver_app/get/getx_state.dart';
import 'package:driver_app/ui/components/custom_surfix_icon.dart';
import 'package:driver_app/ui/components/default_button.dart';
import 'package:driver_app/ui/components/form_error.dart';
import 'package:driver_app/ui/screens/complete_profile/complete_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  String email;
  String password;
  String conformPassword;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKeyRegister,
      child: GetBuilder<AuthGet>(
        builder: (controler) {
          return Column(
            children: [
              buildEmailFormField(controler),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(controler),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildConformPassFormField(controler),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: "أستمر",
                press: () {
                  if (formKeyRegister.currentState.validate()) {
                    formKeyRegister.currentState.save();
                    print(email);
                    print(password);
                    print(conformPassword);
                    // if all are valid then go to success screen
                    Get.to(CompleteProfileScreen());
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }

  TextFormField buildConformPassFormField(AuthGet controler) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conformPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conformPassword) {
          removeError(error: kMatchPassError);
        }
        conformPassword = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "تأكيد كلمة المرور",
        hintText: "أعاد إدخال كلمة المرور الخاصة بك",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField(AuthGet controler) {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => controler.password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "كلمة المرور ",
        hintText: "أدخل كلمة المرور",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField(AuthGet controler) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => controler.email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "البريد الإلكتروني",
        hintText: "أدخل البريد الإلكتروني",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
        ),
      ),
    );
  }
}
