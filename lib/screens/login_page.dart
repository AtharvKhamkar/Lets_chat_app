import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lets_chat/constants/asset_path.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/utils/text_styles.dart';
import 'package:lets_chat/utils/validation.dart';
import 'package:lets_chat/widgets/custom_appbar.dart';
import 'package:lets_chat/widgets/custom_form_button.dart';
import 'package:lets_chat/widgets/custom_input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (controller) {
      return SafeArea(
        top: false,
        child: Scaffold(
          appBar: const CustomAppBar(title: 'Login'),
          body: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * 0.03, horizontal: 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AssetPath.kRegistration,
                            height: Get.height * 0.25,
                          ),
                          Form(
                            key: loginFormKey,
                            child: Column(
                              children: [
                                CustomInputField2(
                                  controller: controller.emailController,
                                  inputType: TextInputType.text,
                                  hintText: 'Enter Your Email',
                                  label: 'Email',
                                  validator: (value) {
                                    AppValidatorUtil.validateEmail(value);
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  errorMessage: 'Enter valid Email',
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
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  errorMessage: 'Enter valid password',
                                  listOfAutofill: const [
                                    AutofillHints.password
                                  ],
                                ),
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Don't have an account? ",
                                        style: TextStyles.textFieldHintText),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed('/registration');
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyles.textFieldHintText
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  CustomFormButton(
                    innerText: 'Login',
                    isLoading: controller.isLoading.value,
                    onPressed: () async {
                      controller.login();
                      // controller.reset();
                    },
                  ),
                ]),
          ),
        ),
      );
    });
  }
}
