import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
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
  final GetIt _getIt = GetIt.instance;
  var registrationFormKey = GlobalKey<FormState>();
  late SharedPreferenceService _sharedPref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences()async{
    _sharedPref = await _getIt.getAsync<SharedPreferenceService>();
  }
 
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) {
        return Scaffold(
          appBar: const CustomAppBar(title: 'Registration'),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.03,horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/Images/registration.svg',
                height: Get.height * 0.25,
                ),
                Form(
                  key: registrationFormKey,
                  child: Expanded(
                    child: Column(
                      children: [
                        CustomInputField2(
                          controller: controller.usernameController,
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
                          controller: controller.emailController,
                          inputType: TextInputType.text,
                          hintText: 'Enter Your Email',
                          label: 'Email',
                          validator: (value) {
                            AppValidatorUtil.validateEmail(value);
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          errorMessage: 'Enter valid username',
                          listOfAutofill: const [AutofillHints.email],
                        ),
                         CustomInputField2(
                          controller: controller.passwordController,
                          inputType: TextInputType.text,
                          hintText: 'Enter Your Password',
                          label: 'Password',
                          validator: (value) {
                            AppValidatorUtil.validateEmpty(
                                    value: value, message: 'Password');
                          },
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          errorMessage: 'Enter valid password',
                          listOfAutofill: const [AutofillHints.password],
                        ),
                        Spacer(),
                        CustomFormButton(innerText: 'Register',isLoading: controller.isLoading.value, onPressed: () async{
                          controller.register();
                          _sharedPref.saveUserRegistrationDetails(controller.usernameController.text, controller.emailController.text);
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}

//sample modification to check git hub account
