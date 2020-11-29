import 'package:flutter/material.dart';
import 'package:flutter_auth_flow/constants.dart';
import 'package:flutter_auth_flow/provider/provider_loading.dart';
import 'package:flutter_auth_flow/screens/home_screen.dart';
import 'package:flutter_auth_flow/screens/login_screen.dart';
import 'package:flutter_auth_flow/services/authen.dart';
import 'package:flutter_auth_flow/widgets/custom_button.dart';
import 'package:flutter_auth_flow/widgets/custom_textField.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = 'signUp_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerUserName = TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();
  String email, password, username, confirmPassword;
  Auth auth = Auth();
  bool _security = true;
  bool _security1 = true;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<LoadingProvider>(context).loading,
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Image.asset(
                  'assets/images/signup_top.png',
                  width: size.width * 0.3,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_bottom.png',
                  width: size.width * 0.2,
                ),
              ),
              SingleChildScrollView(
                child: Container(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'SIGNUP',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        SvgPicture.asset(
                          'assets/icons/signup.svg',
                          height: size.height * 0.35,
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        CustomTextField(
                          text: 'Enter Username',
                          onPress: (value) {
                            if (value.isEmpty || value.length < 3) {
                              return "please enter username or enter greater than 3 character";
                            }
                            return null;
                          },
                          saved: (value) {
                            username = value;
                          },
                          icon: Icons.person,
                          security: false,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        CustomTextField(
                          text: 'Enter Email',
                          onPress: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          saved: (value) {
                            email = value;
                          },
                          icon: Icons.email,
                          security: false,
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        CustomTextField(
                          text: 'Password',
                          onPress: (value) {
                            if (value.isEmpty || value.length < 3) {
                              return 'please enter your password or greater than 3 character';
                            }
                            return null;
                          },
                          saved: (value) {
                            password = value;
                          },
                          icon: Icons.lock,
                          security: _security,
                          iconShow:_security ?  Icons.visibility : Icons.visibility_off,
                          tap: () {
                            setState(() {
                              _security = !_security;
                            });
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        CustomTextField(
                          text: 'Confirm Password',
                          onPress: (value) {
                            if(value.isEmpty || value.length < 3) {
                              return 'please enter your confirm password or greater than 3 character';
                            }
                            if(confirmPassword != password) {
                              return 'please enter password match to confirm password';
                            }
                            return null;
                          },
                          saved: (value) {
                            confirmPassword = value;
                          },
                          icon: Icons.lock,
                          security: _security,
                          iconShow: _security1 ? Icons.visibility : Icons.visibility_off,
                          tap: () {
                            setState(() {
                              _security1 = !_security1;
                            });
                          },
                        ),
                        CustomButton(
                          title: 'SiGNUp',
                          textColor: Colors.white,
                          onPress: () async{
                             FocusScope.of(context).unfocus();
                             final modalProvider = Provider.of<LoadingProvider>(context, listen: false);
                            if (!_formKey.currentState.validate()) {
                              return;
                            }
                             modalProvider.changeLoading(true);
                              _formKey.currentState.save();
                              if(password != confirmPassword ) {
                                print('please enter matching password and confirm password');
                                return;
                              }else {
                                await auth.signUp(email.trim() , password.trim());
                                modalProvider.changeLoading(false);
                                Navigator.pushNamed(context, HomeScreen.routeName);
                              }
                          },
                          color: kPrimaryColor,
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an Account ? ',
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        OrDivider(),
                        SocialSignUp(),
                        SizedBox(
                          height: 20.0,
                        ),
                      ],
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

class OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.02,
      ),
      width: size.width * 0.8,
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: Color(0xFFD9D9D9),
              height: 1.5,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Text(
              'OR',
              style: TextStyle(
                color: kPrimaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: Color(0xFFD9D9D9),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class SocialSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomIcons(
          images: 'assets/icons/facebook.svg',
        ),
        CustomIcons(
          images: 'assets/icons/twitter.svg',
        ),
        CustomIcons(
          images: 'assets/icons/google-plus.svg',
        ),
      ],
    );
  }
}

class CustomIcons extends StatelessWidget {
  final String images;

  const CustomIcons({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: kPrimaryLightColor,
          width: 2,
        ),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        images,
        width: 15.0,
        height: 15.0,
      ),
    );
  }
}
