import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/24h_chart/chart24h_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/all_coins/all_coins_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/chart/chart_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/login/login_cubit.dart';
import 'package:cryptoboard/data/data_providers/all_coins_data_provider.dart';
import 'package:cryptoboard/data/data_providers/asset_data_provider.dart';
import 'package:cryptoboard/data/data_providers/chart_data_provider.dart';
import 'package:cryptoboard/data/data_providers/news_data_provider.dart';
import 'package:cryptoboard/data/repositories/all_coins_repository.dart';
import 'package:cryptoboard/data/repositories/chart_repository.dart';
import 'package:cryptoboard/data/repositories/news_repository.dart';
import 'package:cryptoboard/presentation/pages/auth/sign_up/sign_up_page.dart';
import 'package:cryptoboard/presentation/screens/splash/auth_unknown_screen.dart';
import 'package:cryptoboard/presentation/shared/pages_builder.dart';
import 'package:cryptoboard/simple_bloc_observer.dart';
import 'package:cryptoboard/src/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screenutil_init.dart';

import 'business_logic/blocs/auth/authentication_bloc.dart';
import 'business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'business_logic/blocs/calculator/calculator_bloc.dart';
import 'business_logic/blocs/prices_switcher/prices_switcher_bloc.dart';
import 'business_logic/blocs/range_switcher/range_switcher_bloc.dart';
import 'business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'business_logic/blocs/text_field/text_field_bloc.dart';
import 'business_logic/blocs/watchlist/watchlist_bloc.dart';
import 'business_logic/cubits/assets/assets_cubit.dart';
import 'business_logic/cubits/home/home_content_cubit.dart';
import 'business_logic/cubits/login/login_cubit.dart';
import 'business_logic/cubits/set_price/set_price_cubit.dart';
import 'business_logic/cubits/sign_up/sign_up_cubit.dart';
import 'business_logic/cubits/sort/sort_cubit.dart';
import 'business_logic/cubits/sort/sort_now_cubit.dart';
import 'data/data_providers/asset_data_provider.dart';
import 'data/repositories/asset_repository.dart';
import 'presentation/pages/auth/sign_in/forgot_password/check_email_screen.dart';
import 'presentation/pages/auth/sign_in/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();

  runApp(App(authenticationRepository: AuthenticationRepository()));
}

class App extends StatelessWidget {
  final AuthenticationRepository authenticationRepository;

  const App({
    Key key,
    @required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetDataProvider assetDataProvider = AssetDataProvider();
    final AssetRepository assetRepository = AssetRepository(assetDataProvider: assetDataProvider);
    final ChartDataProvider chartDataProvider = ChartDataProvider();
    final ChartRepository chartRepository = ChartRepository(chartDataProvider: chartDataProvider);
    final NewsDataProvider newsDataProvider = NewsDataProvider();
    final NewsRepository newsRepository = NewsRepository(newsDataProvider: newsDataProvider);
    final AllCoinsDataProvider allCoinsDataProvider = AllCoinsDataProvider();
    final AllCoinsRepository allCoinsRepository = AllCoinsRepository(allCoinsDataProvider: allCoinsDataProvider);
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: ScreenUtilInit(
          designSize: Size(414, 848),
          allowFontScaling: false,
          builder: () => MyApp(
            authenticationRepository: AuthenticationRepository(),
            assetRepository: assetRepository,
            newsRepository: newsRepository,
            chartRepository: chartRepository,
            allCoinsRepository: allCoinsRepository,
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  final AssetRepository assetRepository;
  final NewsRepository newsRepository;
  final ChartRepository chartRepository;
  final AllCoinsRepository allCoinsRepository;
  final AuthenticationRepository authenticationRepository;

  MyApp({
    Key key,
    @required this.chartRepository,
    @required this.assetRepository,
    @required this.newsRepository,
    @required this.authenticationRepository,
    @required this.allCoinsRepository,
  });

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  ///

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    return ScreenUtilInit(
      designSize: Size(414, 848),
      allowFontScaling: false,
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        routes: {
          '/checkEmailScreen': (context) => CheckEmailScreen(),
          '/loginPage': (context) => SignInPage(),
          '/signUpPage': (context) => SignUpPage(),
        },
        theme: ThemeData(
          brightness: Brightness.dark,
          accentColor: Color(0xff4878FF),
          pageTransitionsTheme: PageTransitionsTheme(
            builders: {
              TargetPlatform.android: ZoomPageTransitionsBuilder(),
            },
          ),
        ),
        onGenerateRoute: (_) => AuthUnknownScreen.route(),
        navigatorObservers: [
          BotToastNavigatorObserver(),
        ],
        builder: (context, child) {
          child = MediaQuery(
            data: MediaQuery.of(context),
            child: MultiBlocProvider(
              providers: [
                //asset bloc
                BlocProvider<AssetsCubit>(
                  create: (BuildContext context) => AssetsCubit(
                    assetRepository: widget.assetRepository,
                  ),
                ),

                BlocProvider<NetworkBloc>(
                  create: (context) => NetworkBloc()..add(ListenConnection()),
                ),

                //home content
                BlocProvider<HomeContentCubit>(
                  create: (BuildContext context) => HomeContentCubit(
                    assetRepository: widget.assetRepository,
                    newsRepository: widget.newsRepository,
                  )..loadHomeContent(),
                ),

                BlocProvider<AllCoinsCubit>(
                  create: (context) => AllCoinsCubit(
                    allCoinsRepository: widget.allCoinsRepository,
                  )..loadCoinData(),
                ),

                BlocProvider<WatchListBloc>(
                  create: (context) => WatchListBloc(),
                ),

                BlocProvider<PricesSwitcherBloc>(create: (context) => PricesSwitcherBloc()),

                //news bloc
                BlocProvider(
                  create: (BuildContext context) => NewsBloc(
                    newsRepository: widget.newsRepository,
                  ),
                ),

                BlocProvider(
                  create: (BuildContext context) => TextFieldBloc(),
                ),

                // BlocProvider<B>()
                BlocProvider<BottomNavBarBloc>(
                  create: (context) => BottomNavBarBloc(),
                ),

                BlocProvider<SortCubit>(
                  create: (context) => SortCubit(),
                ),

                BlocProvider<ChartCubit>(
                  create: (context) => ChartCubit(
                    chartRepository: widget.chartRepository,
                  ),
                ),

                BlocProvider<Chart24hCubit>(
                  create: (context) => Chart24hCubit(
                    chartRepository: widget.chartRepository,
                  ),
                ),

                BlocProvider<ConverterBloc>(
                  create: (context) => ConverterBloc(),
                ),

                BlocProvider<SortNowCubit>(
                  create: (context) => SortNowCubit(),
                ),

                BlocProvider<CalculatorBloc>(
                  create: (context) => CalculatorBloc(),
                ),

                BlocProvider<SetPriceCubit>(
                  create: (context) => SetPriceCubit(),
                ),

                //tab switcher
                BlocProvider<TabSwitcherBloc>(
                  create: (context) => TabSwitcherBloc(),
                ),

                BlocProvider<RangeSwitcherBloc>(
                  create: (context) => RangeSwitcherBloc(),
                ),

                BlocProvider<LoginCubit>(
                  create: (BuildContext context) => LoginCubit(
                    context.read<AuthenticationRepository>(),
                  ),
                ),

                BlocProvider<SignUpCubit>(
                  create: (BuildContext context) => SignUpCubit(
                    context?.read<AuthenticationRepository>(),
                  ),
                ),
              ],
              child: BlocListener<AuthenticationBloc, AuthenticationState>(
                child: child,
                listener: (context, state) {
                  switch (state.status) {
                    case AuthenticationStatus.authenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        PagesBuilder.route(),
                        (route) => false,
                      );
                      break;
                    case AuthenticationStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil<void>(
                        SignInPage.route(),
                        (route) => false,
                      );
                      break;
                    default:
                      break;
                  }
                },
              ),
            ),
          );
          child = botToastBuilder(context, child);
          return child;
        },
      ),
    );
  }
}
