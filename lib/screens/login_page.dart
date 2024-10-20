import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:lets_chat/controller/auth_controller.dart';
import 'package:lets_chat/services/shared_preference_service.dart';
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
  final GetIt _getIt = GetIt.instance;
  var loginFormKey = GlobalKey<FormState>();
  late SharedPreferenceService _sharedPref;

  @override
  void initState(){
    // TODO: implement initState
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
          appBar: const CustomAppBar(title: 'Login'),
          body: Padding(
          padding: EdgeInsets.symmetric(vertical: Get.height * 0.03,horizontal: 16),
          child: Column(
            children: [
              SvgPicture.asset('assets/Images/registration.svg',
                height: Get.height * 0.25,
                ),
                Form(
                  key: loginFormKey,
                  child: Expanded(
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
                          autoValidateMode: AutovalidateMode.onUserInteraction,
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
                          autoValidateMode: AutovalidateMode.onUserInteraction,
                          errorMessage: 'Enter valid password',
                          listOfAutofill: const [AutofillHints.password],
                        ),
                        SizedBox(
                          height: Get.height * 0.05,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? ",style: TextStyles.textFieldHintText),
                            GestureDetector(
                              onTap: (){
                                Get.toNamed('/registration');
                              },
                              child: Text('Sign up',style: TextStyles.textFieldHintText.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                              ),),
                            )
                          ],
                        ),
                        const Spacer(),
                        CustomFormButton(innerText: 'Login', isLoading: controller.isLoading.value,onPressed: () async{
                         Future<bool> isPrefProcessSuccess =  _sharedPref.saveUserCredentials(controller.emailController.text, controller.passwordController.text);
                          if(await isPrefProcessSuccess){
                            controller.login();
                            controller.reset();
                          }
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