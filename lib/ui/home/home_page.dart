import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pojok_islam/resources/colors.dart';
import 'package:pojok_islam/resources/dimens.dart';
import 'package:pojok_islam/resources/strings.dart';
import 'package:pojok_islam/ui/home/widget/home_widget.dart';
import 'package:pojok_islam/utils/extensions.dart';

import 'bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetLocationEvent());

    return CustomScrollView(
      slivers: <Widget>[
        SliverPersistentHeader(
          delegate: HeaderView(
              expandedHeight: context.heightInPercent(context, 38),
              minHeight: context.widthInPercent(context, 35)),
          pinned: true,
          floating: false,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin:
                  EdgeInsets.only(top: context.heightInPercent(context, 14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        NearbyMosque(),
                        HaditsCollections(),
                        RadioDakwah(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ]),
        )
      ],
    );
  }
}

class HeaderView extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;
  HomeBloc _homeBloc;

  HeaderView({@required this.expandedHeight, this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final cardTopPosition = expandedHeight / 1.35 - shrinkOffset;

    _homeBloc = BlocProvider.of<HomeBloc>(context);

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image(
          image: AssetImage('assets/images/bg_header.png'),
          fit: BoxFit.fill,
        ),
        SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: Dimens.Space16, top: Dimens.Space16),
                    child: Text(
                      "Pojok Islam",
                      style: TextStyle(
                          fontFamily: 'Arabic',
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: Dimens.Space16),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black12,
                            blurRadius: Dimens.Space2,
                            spreadRadius: Dimens.Elevation,
                            offset: Offset(0.0, Dimens.Space2)),
                      ],
                      borderRadius: new BorderRadius.only(
                        bottomLeft: const Radius.circular(Dimens.ButtonRound),
                        topLeft: const Radius.circular(Dimens.ButtonRound),
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              _homeBloc.add(GetLocationEvent());
                              context.toastInfo("Location Updated");
                              /*showDialog(
                                  context: context,
                                  builder: (_) => CupertinoAlertDialog(
                                        title: Text("Title"),
                                        content: Text("Content"),
                                        actions: <Widget>[
                                          FlatButton(
                                            onPressed: () {},
                                            child: Text("Ok"),
                                          ),
                                          FlatButton(
                                            onPressed: () {},
                                            child: Text("Cancel"),
                                          )
                                        ],
                                      ),
                                  barrierDismissible: true);*/
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimens.Space4,
                                  right: Dimens.Space4,
                                  top: Dimens.Space8,
                                  bottom: Dimens.Space8),
                              child: Row(
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        'assets/images/ic_location.png'),
                                    width: Dimens.SmallIcon,
                                    height: Dimens.SmallIcon,
                                    color: Palette.colorPrimary,
                                  ),
                                  BlocListener<HomeBloc, HomeState>(
                                    listener: (context, homeState) {},
                                    child: BlocBuilder<HomeBloc, HomeState>(
                                        builder: (context, homeState) {
                                      if (homeState is GetLocationState) {
                                        print("piyu" + homeState.locationValue);
                                        return Text(
                                          homeState.locationValue.toString(),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: Dimens.Body1,
                                              color: Palette.colorPrimary),
                                        );
                                      } else
                                        return Container();
                                    }),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              Visibility(
                  visible:
                      (1 - shrinkOffset / expandedHeight) <= 0.8 ? false : true,
                  child: Opacity(
                      opacity: (1 - ((shrinkOffset * 13) / expandedHeight)) <= 0
                          ? 0
                          : (1 - ((shrinkOffset * 13) / expandedHeight)),
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(
                                Dimens.Space16,
                                context.heightInPercent(context, 4),
                                Dimens.Space16,
                                0),
                            child: Text(
                              Strings.haditsText,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.Space16,
                                  fontStyle: FontStyle.italic),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: Dimens.Space2),
                            padding: EdgeInsets.fromLTRB(
                                0, Dimens.Space16, Dimens.SmallIcon, 0),
                            child: Text(
                              Strings.haditsRiwayah,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimens.Caption,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ))),
            ],
          ),
        ),
        Positioned(
          top: cardTopPosition > context.widthInPercent(context, 26)
              ? cardTopPosition
              : context.widthInPercent(context, 26),
          width: context.widthInPercent(context, 100),
          child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              margin:
                  EdgeInsets.only(left: Dimens.Space16, right: Dimens.Space16),
              child: Opacity(
                opacity: 1,
                child: Card(
                    elevation: 4,
                    child: SizedBox(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            width: context.widthInPercent(context, 40),
                            padding: EdgeInsets.all(Dimens.Space8),
                            decoration: new BoxDecoration(
                                color: Palette.colorPrimaryDark,
                                borderRadius: new BorderRadius.only(
                                    bottomLeft:
                                        const Radius.circular(Dimens.Space16),
                                    bottomRight:
                                        const Radius.circular(Dimens.Space16))),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "13 Syawal 1440H",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimens.Body1,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Puasa Ayyaumul Bid",
                                  style: TextStyle(
                                      fontSize: Dimens.Caption,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )),
                        Flexible(
                            child: Container(
                          width: double.infinity,
                          height: context.heightInPercent(context, 8.5),
                          margin: EdgeInsets.only(
                              left: Dimens.Space8,
                              right: Dimens.Space8,
                              top: Dimens.Space8),
                          child: TimeShalatAdapter(),
                        )),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(Dimens.Space8),
                          child: Text(
                            "Lihat Semua",
                            style: TextStyle(
                                color: Palette.colorPrimary,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ))),
              )),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class TimeShalat {
  final String shalatTime;
  final String shalatName;

  TimeShalat(this.shalatTime, this.shalatName);
}
