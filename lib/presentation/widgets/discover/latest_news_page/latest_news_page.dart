import 'package:cryptoboard/business_logic/blocs/network/network_bloc.dart';
import 'package:cryptoboard/presentation/screens/errors/network_error.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/bitcoin/bitcoin_section.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/bitcoin/bitcoin_title.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/ethereum/ethereum_section.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/ethereum/ethereum_title.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/ripple/ripple_section.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/ripple/ripple_title.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/trending/trending_section.dart';
import 'package:cryptoboard/presentation/widgets/discover/latest_news_page/trending/trending_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LatestNewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc, NetworkState>(
      builder: (context, state) {
        if (state is ConnectionFailure) {
          return SliverList(
            delegate: SliverChildListDelegate(
              [
                NetworkError(),
              ],
            ),
          );
        }
        if (state is ConnectionSuccess) {
          // BlocProvider.of<NewsBloc>(context)..add(NewsRequested());
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
                  children: [
                    TrendingTitle(),

                    //trending
                    TrendingSection(),

                    //bitcoin title
                    BitcoinTitle(),

                    //bitcoin
                    BitcoinSection(),

                    //ethereum title
                    EthereumTitle(),

                    //ethereum
                    EthereumSection(),

                    //ripple title
                    RippleTitle(),

                    //ripple
                    RippleSection(),
                  ],
                );
              },
              childCount: 1,
              addAutomaticKeepAlives: true,
              addRepaintBoundaries: true,
            ),
          );
        } else
          return null;
      },
    );
  }
}
