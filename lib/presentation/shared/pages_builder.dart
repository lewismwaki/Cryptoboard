import 'package:cached_network_image/cached_network_image.dart';
import 'package:cryptoboard/business_logic/blocs/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/news/news_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/tab_switcher/tab_switcher_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/sort/sort_now_cubit.dart';
import 'package:cryptoboard/presentation/pages/discover/discover_page_body.dart';
import 'package:cryptoboard/presentation/pages/home/home_page_body.dart';
import 'package:cryptoboard/presentation/pages/prices/prices_page_body.dart';
import 'package:cryptoboard/presentation/pages/settings/settings_page_body.dart';
import 'package:cryptoboard/presentation/screens/loading/shimmer_avi.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PagesBuilder extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => PagesBuilder());
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size);
    final currentUser = firebase_auth.FirebaseAuth.instance.currentUser;
    final TabSwitcherBloc tabSwitcherBloc = BlocProvider.of<TabSwitcherBloc>(context);
    final AssetsCubit assetsCubit = BlocProvider.of<AssetsCubit>(context);
    final BottomNavBarBloc bottomNavBarBloc = BlocProvider.of<BottomNavBarBloc>(context);
    final SortCubit sortCubit = BlocProvider.of<SortCubit>(context);
    final SortNowCubit sortNowCubit = BlocProvider.of<SortNowCubit>(context);
    final NewsBloc newsBloc = BlocProvider.of<NewsBloc>(context);
    final HomeContentCubit homeContentCubit = BlocProvider.of<HomeContentCubit>(context);

    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (BuildContext context, BottomNavBarState state) {
        //home page
        if (state is LoadedHomePage) {
          return SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: HomePageBody(),
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Color(0x1aa3b1ff),
                  ),
                  child: BottomNavigationBar(
                    elevation: 2.0,
                    currentIndex: state.index,
                    unselectedItemColor: Color(0xff646B80),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    backgroundColor: Color(0xff171924),
                    //actions
                    onTap: (index) {
                      if (index == 0) {
                        bottomNavBarBloc.state is! LoadedHomePage ? homeContentCubit.loadHomeContent() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                      }
                      if (index == 1) {
                        assetsCubit.state is AssetsInitial ? assetsCubit.sortAssetsByRankAscending() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadPricesPage());
                      }
                      if (index == 2) {
                        tabSwitcherBloc.state is! LatestNewsLoaded ? BlocProvider.of<TabSwitcherBloc>(context).add(LoadLatestNews()) : null;
                        newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadDiscoverPage());
                      }
                      if (index == 3) {
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadSettingsPage());
                      }

                      return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                    },

                    //icons
                    items: [
                      _buildNavBarItem(icon: Icon(MdiIcons.homeVariant, size: 24)),
                      _buildNavBarItem(icon: Icon(Icons.bar_chart, size: 26)),
                      _buildNavBarItem(icon: Icon(Icons.explore_rounded, size: 26)),
                      _buildNavBarItem(
                        icon: Container(
                          height: 25.0.r,
                          width: 25.0.r,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        //prices page
        if (state is LoadedPricesPage) {
          return SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: PricesPageBody(
                    assetsCubit: assetsCubit, newsBloc: newsBloc, sortCubit: sortCubit, sortNowCubit: sortNowCubit, tabSwitcherBloc: tabSwitcherBloc),
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Color(0x1aa3b1ff),
                  ),
                  child: BottomNavigationBar(
                    elevation: 2.0,
                    currentIndex: state.index,
                    unselectedItemColor: Color(0xff646B80),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    backgroundColor: Color(0xff171924),
                    //actions
                    onTap: (index) {
                      if (index == 0) {
                        bottomNavBarBloc.state is! LoadedHomePage ? homeContentCubit.loadHomeContent() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                      }
                      if (index == 1) {
                        assetsCubit.state is AssetsInitial ? assetsCubit.sortAssetsByRankAscending() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadPricesPage());
                      }
                      if (index == 2) {
                        tabSwitcherBloc.state is! LatestNewsLoaded ? BlocProvider.of<TabSwitcherBloc>(context).add(LoadLatestNews()) : null;

                        newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadDiscoverPage());
                      }
                      if (index == 3) {
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadSettingsPage());
                      }

                      return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                    },

                    //icons
                    items: [
                      _buildNavBarItem(icon: Icon(MdiIcons.homeVariant, size: 24)),
                      _buildNavBarItem(icon: Icon(Icons.bar_chart, size: 26)),
                      _buildNavBarItem(icon: Icon(Icons.explore_rounded, size: 26)),
                      _buildNavBarItem(
                        icon: Container(
                          height: 25.0.r,
                          width: 25.0.r,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        //discover page
        if (state is LoadedDiscoverPage) {
          return SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: DiscoverPageBody(),
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Color(0x1aa3b1ff),
                  ),
                  child: BottomNavigationBar(
                    elevation: 2.0,
                    currentIndex: state.index,
                    unselectedItemColor: Color(0xff646B80),
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: Colors.white,
                    backgroundColor: Color(0xff171924),
                    //actions
                    onTap: (index) {
                      if (index == 0) {
                        bottomNavBarBloc.state is! LoadedHomePage ? homeContentCubit.loadHomeContent() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                      }
                      if (index == 1) {
                        assetsCubit.state is AssetsInitial ? assetsCubit.sortAssetsByRankAscending() : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadPricesPage());
                      }
                      if (index == 2) {
                        tabSwitcherBloc.state is! LatestNewsLoaded ? BlocProvider.of<TabSwitcherBloc>(context).add(LoadLatestNews()) : null;
                        newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadDiscoverPage());
                      }
                      if (index == 3) {
                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadSettingsPage());
                      }

                      return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                    },

                    //icons
                    items: [
                      _buildNavBarItem(icon: Icon(MdiIcons.homeVariant, size: 24)),
                      _buildNavBarItem(icon: Icon(Icons.bar_chart, size: 26)),
                      _buildNavBarItem(icon: Icon(Icons.explore_rounded, size: 26)),
                      _buildNavBarItem(
                        icon: Container(
                          height: 25.0.r,
                          width: 25.0.r,
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        //settings page
        if (state is LoadedSettingsPage) {
          return SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              // ignore: missing_return
              onNotification: (overscroll) {
                overscroll.disallowGlow();
              },
              child: Scaffold(
                backgroundColor: Colors.black,
                body: SettingsPageBody(),
                bottomNavigationBar: Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Color(0x1aa3b1ff),
                  ),
                  child: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Color(0x1aa3b1ff),
                    ),
                    child: BottomNavigationBar(
                      elevation: 2.0,
                      currentIndex: state.index,
                      unselectedItemColor: Color(0xff646B80),
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.white,
                      backgroundColor: Color(0xff171924),
                      //actions
                      onTap: (index) {
                        if (index == 0) {
                          bottomNavBarBloc.state is! LoadedHomePage ? homeContentCubit.loadHomeContent() : null;
                          return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                        }
                        if (index == 1) {
                          assetsCubit.state is AssetsInitial ? assetsCubit.sortAssetsByRankAscending() : null;
                          return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadPricesPage());
                        }
                        if (index == 2) {
                          tabSwitcherBloc.state is! LatestNewsLoaded ? BlocProvider.of<TabSwitcherBloc>(context).add(LoadLatestNews()) : null;
                          newsBloc.state is NewsInitial ? BlocProvider.of<NewsBloc>(context).add(NewsRequested()) : null;
                          return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadDiscoverPage());
                        }
                        if (index == 3) {
                          return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadSettingsPage());
                        }

                        return BlocProvider.of<BottomNavBarBloc>(context)..add(LoadHomePage());
                      },

                      //icons
                      items: [
                        _buildNavBarItem(icon: Icon(MdiIcons.homeVariant, size: 24)),
                        _buildNavBarItem(icon: Icon(Icons.bar_chart, size: 26)),
                        _buildNavBarItem(icon: Icon(Icons.explore_rounded, size: 26)),
                        _buildNavBarItem(
                          icon: Container(
                            height: 25.0.r,
                            width: 25.0.r,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(100.r),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: '${currentUser.photoURL}',
                                placeholder: (context, url) => ShimmerAvi(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  _buildNavBarItem({final Widget icon}) {
    return BottomNavigationBarItem(
      icon: icon,
      // ignore: deprecated_member_use
      title: Text(
        '',
        style: TextStyle(fontSize: 0.0),
        textAlign: TextAlign.center,
      ),
    );
  }
}
