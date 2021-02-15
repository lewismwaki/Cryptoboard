import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ForgotPasswordSheet extends StatefulWidget {
  static ModalRoute route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/forgotPasswordSheet'),
      builder: (context) => ForgotPasswordSheet(),
    );
  }

  @override
  _ForgotPasswordSheetState createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  Image passResetIcon;

  @override
  void initState() {
    super.initState();
    passResetIcon = Image(
      fit: BoxFit.contain,
      color: Color(0xff3861FB),
      image: AssetImage(
        'assets/images/password-reset.png',
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(passResetIcon.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //handle
            SizedBox(height: 18.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 40.0.w,
                  height: 5.0.h,
                  decoration: BoxDecoration(
                    color: Color(0xffD2DBFE),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
              ],
            ),
            SizedBox(height: 48.0.h),

            Center(
              child: Container(
                height: 75.0.h,
                width: 75.0.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17.5.r),
                  color: Color(0xffA6B8FD),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15.5),
                  child: passResetIcon,
                ),
              ),
            ),

            SizedBox(height: 32.0.h),

            //title
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 1.sw),
                Text(
                  'Reset Password',
                  style: TextStyle(
                    color: Color(0xffA6B8FD),
                    fontSize: 22.0.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Enter the email address associated\nwith your account and we\'ll send you a link\nto reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0.sp,
                    color: Color(0xff82899E),
                  ),
                ),
              ],
            ),

            SizedBox(height: 48.0.h),

            //email
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(top: 32.0.h),
                  child: SizedBox(
                    width: 350.w,
                    child: Padding(
                      padding: MediaQuery.of(context).viewInsets,
                      child: TextFormField(
                        cursorColor: Color(0xff3861FB),
                        key: const Key('loginForm_emailInput_textField'),
                        onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
                        keyboardType: TextInputType.emailAddress,
                        style: formText.copyWith(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          fillColor: Color(0xff2C2F38),
                          focusColor: Color(0xff646B80),
                          labelText: 'Enter Email Address',
                          helperText: '',
                          hintText: "Enter Email Address",
                          errorText: state.email.invalid ? 'Invalid Email' : null,
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                            borderSide: BorderSide(
                              color: Colors.red,
                              width: 1.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          alignLabelWithHint: true,
                          filled: true,
                          labelStyle: formText,
                          hintStyle: formText,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            //reset btn
            BlocBuilder<LoginCubit, LoginState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
                  child: RawMaterialButton(
                    key: const Key('loginForm_continue_raisedButton'),
                    elevation: 0.0,
                    constraints: BoxConstraints(
                      maxWidth: 350.w,
                      minWidth: 350.w,
                      minHeight: 48.0.h,
                      maxHeight: 48.0.h,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0.sp,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    fillColor: Color(0xff3861FB),
                    child: !state.status.isSubmissionInProgress
                        ? Text(
                            'Reset Password',
                          )
                        : SizedBox(
                            height: 42.h,
                            width: 42.w,
                            child: SpinKitRipple(
                              color: Colors.white,
                            ),
                          ),
                    onPressed: () {
                      // context.read<LoginCubit>().resetPassword();
                      // if (state.status.isValid) {
                      //   if (ModalRoute.of(context).settings.name == '/fromLoginForm') {
                      //     Navigator.of(context).pushReplacementNamed('/checkEmailScreen');
                      //   } else if (ModalRoute.of(context).settings.name == '/fromCheckEmailScreen') {
                      //     Navigator.pop(context);
                      //   }
                      // }
                      Navigator.pop(context);
                      showCustomNotification(
                        title: 'Password reset not available in alpha release',
                        subtitle: 'Be sure to check after subsequent releases',
                        icon: MdiIcons.beta,
                        iconColor: Colors.white,
                        iconBackgroundColor: Color(0xff555E8D),
                        seconds: 3,
                        padding: EdgeInsets.only(top: 8.0.h),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
