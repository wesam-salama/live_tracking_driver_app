import 'package:driver_app/get/getx_state.dart';
import 'package:driver_app/ui/components/custom_surfix_icon.dart';
import 'package:driver_app/ui/components/default_button.dart';
import 'package:driver_app/ui/components/form_error.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../constants.dart';
import '../../../../size_config.dart';

class CompleteProfileForm extends StatefulWidget {
  @override
  _CompleteProfileFormState createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String carNumber;

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

  GlobalKey<FormState> formKeyCompleteProfile = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKeyCompleteProfile,
        child: GetBuilder<AuthGet>(
          builder: (controler) {
            return Column(
              children: [
                buildFirstNameFormField(controler),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildLastNameFormField(controler),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildPhoneNumberFormField(controler),
                SizedBox(height: getProportionateScreenHeight(30)),
                buildCarNumberFormField(controler),
                FormError(errors: errors),
                SizedBox(height: getProportionateScreenHeight(40)),
                DefaultButton(
                  text: "إنشاء حساب",
                  press: () {
                    if (formKeyCompleteProfile.currentState.validate()) {
                      formKeyCompleteProfile.currentState.save();
                      controler.onSubmitRegister(context);
                    }
                  },
                ),
              ],
            );
          },
        ));
  }

  TextFormField buildCarNumberFormField(AuthGet controler) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => controler.carNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCarNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCarNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
          labelText: "رقم السيارة",
          hintText: "أدخل رقم السيارة",
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon:
              // CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
              Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Icon(
              Icons.format_list_numbered_outlined,
              color: Colors.grey,
            ),
          )),
    );
  }

  TextFormField buildPhoneNumberFormField(AuthGet controler) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => controler.phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "رقم الهاتف",
        hintText: "أدخل رقم الهاتف",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField(AuthGet controler) {
    return TextFormField(
      onSaved: (newValue) => controler.secondName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kSecondNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kSecondNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "اسم العائلة",
        hintText: "أدخل أسم العائلة",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }

  TextFormField buildFirstNameFormField(AuthGet controler) {
    return TextFormField(
      onSaved: (newValue) => controler.firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "الإسم",
        hintText: "أدخل أسمك",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
        ),
      ),
    );
  }
}
