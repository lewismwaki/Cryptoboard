import 'package:cryptoboard/business_logic/cubits/assets/assets_cubit.dart';
import 'package:cryptoboard/presentation/screens/loading/assets_load_in_progress_shimmer.dart';
import 'package:cryptoboard/presentation/widgets/prices/%25_Change/by_percentage_change_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/%25_Change/by_percentage_change_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/market_cap/by_market_cap_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/market_cap/by_market_cap_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/max_supply/by_max_supply_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/max_supply/by_max_supply_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/name/by_name_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/name/by_name_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/price/by_price_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/price/by_price_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/rank/by_rank_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/rank/by_rank_descending.dart';
import 'package:cryptoboard/presentation/widgets/prices/volume_24hr/by_volume_24hr_ascending.dart';
import 'package:cryptoboard/presentation/widgets/prices/volume_24hr/by_volume_24hr_descending.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Assets extends StatefulWidget {
  final int index;

  const Assets({Key key, this.index}) : super(key: key);

  @override
  _AssetsState createState() => _AssetsState();
}

class _AssetsState extends State<Assets> with AutomaticKeepAliveClientMixin {
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    final _assetsCubit = BlocProvider.of<AssetsCubit>(context);

    return BlocBuilder<AssetsCubit, AssetsState>(
      cubit: _assetsCubit,
      builder: (context, state) {
        // by rank ascending
        if (state is AssetsSortedByRankAscending) {
          return ByRankAscending(index: widget.index);
        }

        if (state is AssetsSortedByRankDescending) {
          return ByRankDescending(index: widget.index);
        }

        //market cap
        if (state is AssetsSortedByMarketCapAscending) {
          return ByMarketCapAscending(index: widget.index);
        }

        if (state is AssetsSortedByMarketCapDescending) {
          return ByMarketCapDescending(index: widget.index);
        }

        //by percentage change
        if (state is AssetsSortedByPercentageChangeAscending) {
          return ByPercentageChangeAscending(index: widget.index);
        }

        if (state is AssetsSortedByPercentageChangeDescending) {
          return ByPercentageChangeDescending(index: widget.index);
        }

        //price
        if (state is AssetsSortedByPriceAscending) {
          return ByPriceAscending(index: widget.index);
        }
        if (state is AssetsSortedByPriceDescending) {
          return ByPriceDescending(index: widget.index);
        }

        //name
        if (state is AssetsSortedByNameAscending) {
          return ByNameAscending(index: widget.index);
        }
        if (state is AssetsSortedByNameDescending) {
          return ByNameDescending(index: widget.index);
        }

        //max supply
        if (state is AssetsSortedByMaxSupplyAscending) {
          return ByMaxSupplyAscending(index: widget.index);
        }
        if (state is AssetsSortedByMaxSupplyDescending) {
          return ByMaxSupplyDescending(index: widget.index);
        }

        //volume 24 hr
        if (state is AssetsSortedByVolume24hrAscending) {
          return ByVolume24hrAscending(index: widget.index);
        }
        if (state is AssetsSortedByVolume24hrDescending) {
          return ByVolume24hrDescending(index: widget.index);
        }

        //load in progress
        if (state is AssetsLoadInProgress) {
          return AssetsLoadInProgressShimmer(index: widget.index);
        }
        //load failed
        else if (state is AssetsLoadFailure) {
          return AssetsLoadInProgressShimmer(index: widget.index);
        } else {
          return Container();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
