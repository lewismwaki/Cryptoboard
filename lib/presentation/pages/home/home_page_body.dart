import 'package:cryptoboard/business_logic/blocs/calculator/calculator_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/converter/converter_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/business_logic/blocs/text_field/text_field_bloc.dart';
import 'package:cryptoboard/business_logic/cubits/home/home_content_cubit.dart';
import 'package:cryptoboard/business_logic/cubits/set_price/set_price_cubit.dart';
import 'package:cryptoboard/constants/constants.dart';
import 'package:cryptoboard/presentation/pages/search/search_page.dart';
import 'package:cryptoboard/presentation/screens/errors/network_error.dart';
import 'package:cryptoboard/presentation/widgets/home/gainers_losers/gainers_losers_section.dart';
import 'package:cryptoboard/presentation/widgets/home/gainers_losers/gainers_losers_title.dart';
import 'package:cryptoboard/presentation/widgets/home/news/news_section.dart';
import 'package:cryptoboard/presentation/widgets/home/news/news_title.dart';
import 'package:cryptoboard/presentation/widgets/home/quick_actions/quick_actions.dart';
import 'package:cryptoboard/presentation/widgets/home/top_coins/top_coins_section.dart';
import 'package:cryptoboard/presentation/widgets/home/top_coins/top_coins_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBody extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePageBody());
  }

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final converterBloc = BlocProvider.of<ConverterBloc>(context);
    final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);
    final setPriceCubit = BlocProvider.of<SetPriceCubit>(context);
    final textFieldBloc = BlocProvider.of<TextFieldBloc>(context);
    final homeContentCubit = BlocProvider.of<HomeContentCubit>(context);
    return CustomScrollView(
      slivers: [
        //app bar
        SliverAppBar(
          brightness: Brightness.dark,
          backgroundColor: Color(0xff171924),
          floating: true,
          title: Text(
            'Home',
            style: appBarText,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                color: Color(0xff858CA2),
              ),
              onPressed: () {
                showSearch(delegate: SearchPage(homeContentCubit: homeContentCubit), context: context);
              },
            ),
          ],
        ),

        BlocBuilder<NetworkBloc, NetworkState>(
          builder: (context, state) {
            if (state is ConnectionSuccess) {
              homeContentCubit.loadHomeContent();
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    //quick actions
                    QuickActions(
                      homeContentCubit: homeContentCubit,
                      converterBloc: converterBloc,
                      calculatorBloc: calculatorBloc,
                      textFieldBloc: textFieldBloc,
                      setPriceCubit: setPriceCubit,
                    ),

                    //top coins title
                    TopCoinsTitle(),
                    //top coins
                    TopCoinsSection(),
                    //gainers losers title
                    GainersLosersTitle(),
                    //gainers losers
                    GainersLosersSection(),
                    //news title
                    NewsTitle(),
                    //news
                    NewsSection(),
                  ],
                ),
              );
            }

            if (state is ConnectionFailure) {
              return SliverList(
                delegate: SliverChildListDelegate(
                  [
                    //quick actions
                    QuickActions(
                      homeContentCubit: homeContentCubit,
                      converterBloc: converterBloc,
                      calculatorBloc: calculatorBloc,
                      textFieldBloc: textFieldBloc,
                      setPriceCubit: setPriceCubit,
                    ),

                    NetworkError(),
                  ],
                ),
              );
            } else
              return SliverList(
                delegate: SliverChildListDelegate(
                  [],
                ),
              );
          },
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
