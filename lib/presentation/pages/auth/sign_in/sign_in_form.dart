import 'package:bot_toast/bot_toast.dart';
import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/auth/sign_up/sign_up_page.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

import 'forgot_password/forgot_password_sheet.dart';

class SignInForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          showCustomNotification(
            title: 'Failed to sign in!',
            iconColor: Colors.white,
            padding: EdgeInsets.only(top: 8.0.h),
            subtitle: 'Something went wrong! Please try again',
            icon: Icons.person_add_disabled_outlined,
            iconBackgroundColor: Color(0xff555E8D),
            seconds: 2,
          );
        }
        if (state.status.isSubmissionSuccess) {
          BotToast.showCustomNotification(
            duration: Duration(seconds: 2),
            onlyOne: true,
            toastBuilder: (void Function() cancelFunc) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.0.w),
                child: Container(
                  width: 1.sw,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: Color(0xff080E24),
                    border: Border.all(
                      color: Color(0xff3861FB),
                      width: 1.25.w,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Material(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      tileColor: Color(0xff080E24),
                      leading: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: Colors.green,
                        child: Padding(
                          padding: EdgeInsets.all(4.0.r),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 20.r,
                          ),
                        ),
                      ),
                      title: Padding(
                        padding: EdgeInsets.only(top: 0.0.h),
                        child: RichText(
                          text: TextSpan(
                            text: "Successfully signed in as:",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.5.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            children: [
                              TextSpan(
                                text: " ${firebase_auth.FirebaseAuth.instance.currentUser.displayName}!",
                                style: TextStyle(
                                  color: Color(0xff3861FB),
                                  fontSize: 14.5.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(right: 32.0.w, left: 32.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _EmailInput(),
            _PasswordInput(),
            _ForgotPassword(),
            _SignInButton(),
            _SeparatorOr(),
            _SocialLoginButtons(),
            _Disclaimer(),
            _SignUpButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 16.0.h),
          child: SizedBox(
            width: 350.w,
            child: TextFormField(
              maxLines: 1,
              cursorColor: Color(0xff3861FB),
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.done,
              style: formText.copyWith(color: Colors.white),
              decoration: InputDecoration(
                fillColor: Color(0xff2C2F38),
                focusColor: Color(0xff646B80),
                labelText: 'Email',
                helperText: '',
                hintText: "Email",
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
        );
      },
    );
  }
}

class _PasswordInput extends StatefulWidget {
  @override
  __PasswordInputState createState() => __PasswordInputState();
}

class __PasswordInputState extends State<_PasswordInput> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return SizedBox(
          width: 350.w,
          child: TextFormField(
            key: const Key('loginForm_passwordInput_textField'),
            onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
            obscureText: _isObscured ? true : false,
            style: TextStyle(
              fontSize: 16.0.sp,
              color: Colors.white,
            ),
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) {},
            decoration: InputDecoration(
              fillColor: Color(0xff2C2F38),
              focusColor: Color(0xff646B80),
              filled: true,
              labelText: 'Password',
              helperText: '',
              hintText: "Password",
              helperStyle: formText,

              //error handling
              errorText: state.password.invalid ? 'Invalid Password' : null,
              errorMaxLines: 1,
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
              labelStyle: formText,
              hintStyle: formText,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                iconSize: 16.r,
                icon: FaIcon(
                  _isObscured ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash,
                  color: Color(0xffA6B8FD),
                ),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 0.0.h, bottom: 16.0.h),
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
            splashColor: Color(0xff7A95FC),
            highlightColor: Colors.transparent,
            fillColor: Color(0xff3861FB),
            child: state.status.isSubmissionInProgress
                ? SizedBox(
                    height: 42.h,
                    width: 42.w,
                    child: SpinKitRipple(
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign In',
                  ),
            onPressed: state.status.isValidated
                ? () {
                    //show bot toast
                    BotToast.showCustomNotification(
                      duration: Duration(seconds: 3),
                      onlyOne: true,
                      toastBuilder: (void Function() cancelFunc) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.0.w),
                          child: Container(
                            width: 1.sw,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: Color(0xff080E24),
                              border: Border.all(
                                color: Color(0xff3861FB),
                                width: 1.25.w,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: Material(
                              clipBehavior: Clip.hardEdge,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                tileColor: Color(0xff080E24),
                                leading: CircleAvatar(
                                  radius: 18.r,
                                  backgroundColor: Color(0xff555E8D),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.0.r),
                                    child: Icon(
                                      Icons.person_add_disabled_outlined,
                                      color: Colors.white,
                                      size: 20.r,
                                    ),
                                  ),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(top: 8.0.h),
                                  child: Text(
                                    'E-mail sign in not available in alpha release',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.5.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 8.0.h, bottom: 10.0.h),
                                  child: Text(
                                    'Please use Google or Facebook to sign in',
                                    style: TextStyle(
                                      color: Color(0xff82899E),
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    //return context.read<LoginCubit>().logInWithCredentials();
                  }
                : () {},
          ),
        );
      },
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Container(width: 249.0.w, height: 1.0.h),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isDismissible: true,
                enableDrag: true,
                isScrollControlled: true,
                barrierColor: Color(0xffA6B8FD).withAlpha(10),
                clipBehavior: Clip.hardEdge,
                routeSettings: RouteSettings(
                  name: '/fromLoginForm',
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                builder: (context) => ForgotPasswordSheet(),
              );
            },
            child: Text(
              'Reset Password',
              style: TextStyle(
                color: Color(0xff3861FB),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.combine(
                  [
                    TextDecoration.underline,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeparatorOr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 1.0.h, width: 68.w, color: Color(0xff82899E)),
        SizedBox(width: 16.0.w),
        Text(
          'or',
          style: TextStyle(color: Color(0xff82899E), fontSize: 13.sp),
        ),
        SizedBox(width: 16.0.w),
        Container(height: 1.0.h, width: 68.w, color: Color(0xff82899E)),
      ],
    );
  }
}

class _SocialLoginButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //google
          RawMaterialButton(
            key: const Key('loginForm_googleLogin_raisedButton'),
            fillColor: Color(0xff2C2F38),
            elevation: 0.0,
            constraints: BoxConstraints(
              maxWidth: 52.w,
              minWidth: 52.w,
              minHeight: 52.0.h,
              maxHeight: 52.0.h,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0.sp,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.google),
              ],
            ),
            onPressed: () => context.read<LoginCubit>().signInWithGoogle(),
          ),

          SizedBox(width: 40.0.w),

          //facebook
          RawMaterialButton(
            // key: const Key('loginForm_googleLogin_raisedButton'),
            elevation: 0.0,
            constraints: BoxConstraints(
              maxWidth: 52.w,
              minWidth: 52.w,
              minHeight: 52.0.h,
              maxHeight: 52.0.h,
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
            textStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16.0.sp,
            ),
            fillColor: Color(0xff2C2F38),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(FontAwesomeIcons.facebookF),
              ],
            ),
            onPressed: () => context.read<LoginCubit>().signInWithFacebook(),
          ),
        ],
      ),
    );
  }
}

class _Disclaimer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());

    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w, top: 20.0.h),
      child: Container(
        width: 300.w,
        child: RichText(
          textAlign: TextAlign.center,
          softWrap: true,
          textWidthBasis: TextWidthBasis.parent,
          text: TextSpan(
            text: 'By signing in you acknowledge that you\'ve read & agreed to our',
            style: TextStyle(
              color: Color(0x8082899e),
              fontSize: 12.sp,
            ),
            children: [
              TextSpan(
                text: ' Terms and Conditions',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await browser.open(url: 'https://www.websitepolicies.com/policies/view/WsmWyfO6'),
                style: TextStyle(
                  color: Color(0xff3861fb),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: ' and our ',
                style: TextStyle(
                  color: Color(0x8082899e),
                  fontSize: 12.sp,
                ),
              ),
              TextSpan(
                text: 'Privacy Policy.',
                recognizer: TapGestureRecognizer()
                  ..onTap = () async => await browser.open(url: 'https://www.freeprivacypolicy.com/live/7d83b341-6b48-4456-983a-8a7e00a3f107'),
                style: TextStyle(
                  color: Color(0xff3861fb),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0.h, bottom: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Don\'t have an account?',
            style: TextStyle(
              color: Color(0xff82899E),
              fontSize: 13.sp,
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push<void>(SignUpPage.route()),
            child: Text(
              ' Sign Up',
              key: const Key('loginForm_createAccount_flatButton'),
              style: TextStyle(
                color: Color(0xff3861FB),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
