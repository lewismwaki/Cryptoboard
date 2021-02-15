import 'package:app_settings/app_settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/auth/authentication_bloc.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:cryptoboard/presentation/shared/toast_notification.dart';
import 'package:cryptoboard/presentation/shared/web_view.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPageBody extends StatefulWidget {
  @override
  _SettingsPageBodyState createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final ChromeSafariBrowser browser = new MyChromeSafariBrowser(new WebViewContent());
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.black,
          floating: true,
          title: Text(
            'Settings',
            style: appBarText,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              //header
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      height: 200.h,
                      width: 1.sw,
                      decoration: BoxDecoration(
                        backgroundBlendMode: BlendMode.darken,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.r),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            'assets/images/avi-bkg.jpg',
                          ),
                        ),
                      ),
                    ),

                    //details
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 72.0.h,
                          width: 72.0.h,
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                          ),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: '${currentUser.photoURL}',
                              placeholder: (context, url) => ShimmerAvi(),
                            ),
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${currentUser.displayName}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${currentUser.email}",
                              style: TextStyle(
                                color: Color(0xff858AA1),
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //general title
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.w),
                child: Text(
                  'ACCOUNT',
                  style: initialsText.copyWith(
                    fontSize: 12.0.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),

              //name
              ListTile(
                onTap: () => showCustomNotification(
                  title: 'Feature not available in alpha releases',
                  subtitle: 'Be sure to check after beta release',
                  icon: MdiIcons.alpha,
                  iconColor: Colors.white,
                  iconBackgroundColor: Color(0xff555E8D),
                  seconds: 3,
                  padding: EdgeInsets.only(top: 8.0.h),
                ),
                dense: true,
                leading: Icon(
                  Icons.person_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${currentUser.displayName}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //username
              ListTile(
                onTap: () => showCustomNotification(
                  title: 'Feature not available in alpha releases',
                  subtitle: 'Be sure to check after beta release',
                  icon: MdiIcons.alpha,
                  iconColor: Colors.white,
                  iconBackgroundColor: Color(0xff555E8D),
                  seconds: 3,
                  padding: EdgeInsets.only(top: 8.0.h),
                ),
                dense: true,
                leading: Icon(
                  Icons.alternate_email_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '@${currentUser.displayName.split(" ")[0]}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              //email
              ListTile(
                onTap: () => showCustomNotification(
                  title: 'Feature not available in alpha releases',
                  subtitle: 'Be sure to check after beta release',
                  icon: MdiIcons.alpha,
                  iconColor: Colors.white,
                  iconBackgroundColor: Color(0xff555E8D),
                  seconds: 3,
                  padding: EdgeInsets.only(top: 8.0.h),
                ),
                dense: true,
                leading: Icon(
                  Icons.email_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'E-mail',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '${currentUser.email}',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Divider(height: 1.0.h),

              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.w),
                child: Text(
                  'GENERAL',
                  style: initialsText.copyWith(
                    fontSize: 12.0.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),

              // notifs
              ListTile(
                onTap: () {
                  AppSettings.openNotificationSettings();
                },
                dense: true,
                leading: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Manage your preferences for notifications',
                ),
              ),
              // theme
              ListTile(
                onTap: () {
                  showCustomNotification(
                    title: 'Feature still in development',
                    subtitle: 'Be sure to check after subsequent releases',
                    icon: MdiIcons.beta,
                    iconColor: Colors.white,
                    iconBackgroundColor: Color(0xff555E8D),
                    seconds: 3,
                    padding: EdgeInsets.only(top: 8.0.h),
                  );
                },
                dense: true,
                leading: Icon(
                  MdiIcons.themeLightDark,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Theme',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  'Dark',
                ),
              ),
              Divider(height: 1.0.h),

              //feedback title
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.w),
                child: Text(
                  'FEEDBACK',
                  style: initialsText.copyWith(
                    fontSize: 12.0.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),

              //bug report
              ListTile(
                onTap: () => _launchLink(url: "https://forms.gle/XfJAZdrDPTJtzcKo7"),
                dense: true,
                leading: Icon(
                  Icons.bug_report_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Report Bug',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),

              //feedback
              ListTile(
                onTap: () => _launchLink(url: "https://forms.gle/XfJAZdrDPTJtzcKo7"),
                dense: true,
                leading: Icon(
                  Icons.feedback_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Feedback',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),

              //contact developer
              ListTile(
                onTap: () => _launchURL(),
                dense: true,
                leading: Icon(
                  Icons.send_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Contact Developer',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),
              Divider(height: 1.0.h),

              //data & privacy title
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.w),
                child: Text(
                  'DATA & PRIVACY',
                  style: initialsText.copyWith(
                    fontSize: 12.0.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),

              //privacy policy
              ListTile(
                onTap: () async => await browser.open(url: 'https://www.freeprivacypolicy.com/live/7d83b341-6b48-4456-983a-8a7e00a3f107'),
                dense: true,
                leading: Icon(
                  Icons.lock_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Privacy policy',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),

              //terms of service
              ListTile(
                onTap: () async => await browser.open(url: 'https://www.websitepolicies.com/policies/view/WsmWyfO6'),
                dense: true,
                leading: Icon(
                  Icons.account_balance_outlined,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'Terms of service',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),

              //about
              ListTile(
                onTap: () async => await browser.open(url: 'https://github.com/mwakicodes/cryptoboard/#readme'),
                dense: true,
                leading: Icon(
                  MdiIcons.web,
                  color: Colors.white,
                  size: 24.r,
                ),
                title: Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 16.r,
                  color: Colors.white,
                ),
              ),
              Divider(height: 1.0.h),

              //log out title
              Padding(
                padding: EdgeInsets.only(top: 16.0.h, left: 16.0.w, right: 16.0.w, bottom: 0.0.w),
                child: Text(
                  'LOG OUT',
                  style: initialsText.copyWith(
                    fontSize: 12.0.sp,
                    letterSpacing: 1,
                  ),
                ),
              ),

              //log out
              Theme(
                data: ThemeData(
                  splashColor: Color(0xff170605),
                  highlightColor: Color(0xff170605),
                ),
                child: ListTile(
                  dense: false,
                  onTap: () => context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested()),
                  leading: Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.red,
                    size: 24.r,
                  ),
                  title: Text(
                    'Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              //delete acccount
              Theme(
                data: ThemeData(
                  splashColor: Color(0xff170605),
                  highlightColor: Color(0xff170605),
                ),
                child: ListTile(
                  dense: false,
                  onTap: () => context.read<AuthenticationBloc>().add(AuthenticationDeleteRequested()),
                  leading: Icon(
                    Icons.person_remove_alt_1_outlined,
                    color: Colors.red,
                    size: 24.r,
                  ),
                  title: Text(
                    'Delete account',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              Divider(height: 1.0),
              Container(height: 16.0.h),

              Text(
                'v0.0.1-alpha',
                textAlign: TextAlign.center,
                style: GoogleFonts.inconsolata(
                  fontSize: 11.5.sp,
                  color: Color(0xff82899E),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4.0.h),
              GestureDetector(
                onTap: () => browser.open(url: 'https://github.com/mwakicodes/cryptoboard/releases'),
                child: Text(
                  'Check for updates',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff4878FF),
                  ),
                ),
              ),
              Container(height: 16.0.h),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

_launchLink({String url}) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

_launchURL() async {
  final url = Uri.encodeFull('mailto:mwakicodes@gmail.com?subject=About Cryptoboard');
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
