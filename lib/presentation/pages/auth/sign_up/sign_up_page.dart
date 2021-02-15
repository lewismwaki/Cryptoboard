import 'package:authentication_repository/authentication_repository.dart';
import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:cryptoboard/presentation/pages/auth/sign_up/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:transparent_image/transparent_image.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (context) => SignUpPage(),
      settings: RouteSettings(name: '/signUpPage'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: KeyboardAvoider(
        autoScroll: true,
        duration: Duration(milliseconds: 100),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            height: 1.sh - 24.h,
            child: Stack(
              children: [
                //background
                Container(
                  width: 1.sw,
                  height: 1.sh,
                  child: FadeInImage.memoryNetwork(
                    fit: BoxFit.fitHeight,
                    fadeInDuration: Duration(milliseconds: 200),
                    placeholder: kTransparentImage,
                    image:
                        "https://images.unsplash.com/photo-1605792657660-596af9009e82?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1291&q=30",
                  ),
                ),

                //gradient bkg
                Container(
                  height: 1.sh,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black87,
                        Colors.black,
                      ],
                    ),
                  ),
                ),

                //title
                Positioned(
                  top: 202.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 32.0.h, horizontal: 32.0.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up to',
                          style: TextStyle(
                            fontSize: 32.0.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Cryptoboard',
                          style: TextStyle(
                            fontSize: 32.0.sp,
                            color: Color(0xff3861FB),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //formz
                Positioned(
                  top: 350.h,
                  bottom: 0.0,
                  child: BlocProvider(
                    create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
                    child: SignUpForm(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
