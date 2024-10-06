import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lets_chat/utils/validation.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';
import 'package:lets_chat/widgets/custom_form_button.dart';
import 'package:lets_chat/widgets/custom_input_field.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  var registrationFormKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Registration'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset('assets/Images/registration.svg'),
          Form(
            key: registrationFormKey,
            child: Column(
              children: [
                CustomInputField2(
                  controller: usernameController,
                  inputType: TextInputType.text,
                  hintText: 'Enter Your Username',
                  label: 'Username',
                  validator: (value) {
                    AppValidatorUtil.validateUsername(value);
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  errorMessage: 'Enter valid username',
                  listOfAutofill: const [AutofillHints.username],
                ),
                CustomInputField2(
                  controller: passwordController,
                  inputType: TextInputType.text,
                  hintText: 'Enter Your Password',
                  label: 'Password',
                  validator: (value) {
                    AppValidatorUtil.validateEmail(value);
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  errorMessage: 'Enter valid password',
                  listOfAutofill: const [AutofillHints.password],
                ),
                CustomFormButton(innerText: 'Register', onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
