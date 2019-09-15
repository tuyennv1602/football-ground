import 'package:flutter/material.dart';
import 'package:footballground/blocs/social-bloc.dart';
import 'package:footballground/res/colors.dart';
import 'package:footballground/res/fonts.dart';
import 'package:footballground/res/styles.dart';
import 'package:footballground/ui/widgets/app-bar-widget.dart';
import 'package:footballground/ui/widgets/border-background.dart';
import 'package:footballground/utils/size-config.dart';
import 'base-page.dart';

// ignore: must_be_immutable
class SocialPage extends BasePage<SocialBloc> {
  @override
  Widget buildAppBar(BuildContext context) => AppBarWidget(
    centerContent: Text(
      'Cộng đồng',
      textAlign: TextAlign.center,
      style: Styles.title(),
    ),
  );

  Widget _buildCateTitle(String title) => Text(
    title,
    style: Styles.semiBold(color: AppColor.PRIMARY),
  );

  Widget _buildItemNew(BuildContext context, int index) => Container(
    width: SizeConfig.screenWidth / 2,
    margin: EdgeInsets.only(right: size10),
    decoration: BoxDecoration(
        color: AppColor.GREY_BACKGROUND,
        borderRadius: BorderRadius.circular(size10)),
    padding: EdgeInsets.all(size10),
    child: Text("Item $index"),
  );

  Widget _buildNewsest(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCateTitle('Tin tức mới nhất'),
        SizedBox(
          height: size10,
        ),
        Container(
            margin: EdgeInsets.only(bottom: size10),
            height: SizeConfig.size(150),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, index) => _buildItemNew(context, index),
            )),
      ],
    );
  }

  Widget _buildRanking(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCateTitle('Bảng xếp hạng'),
        SizedBox(
          height: size10,
        ),
        Container(
            margin: EdgeInsets.only(bottom: size10),
            height: SizeConfig.size(150),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, index) => _buildItemNew(context, index),
            )),
      ],
    );
  }

  Widget _buildTournament(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCateTitle('Giải đấu'),
        SizedBox(
          height: size10,
        ),
        Container(
            margin: EdgeInsets.only(bottom: size10),
            height: SizeConfig.size(150),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, index) => _buildItemNew(context, index),
            )),
      ],
    );
  }

  Widget _buildRecruit(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildCateTitle('Thông tin tuyển quân'),
        SizedBox(
          height: size10,
        ),
        Container(
            height: SizeConfig.size(150),
            child: ListView.builder(
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (c, index) => _buildItemNew(context, index),
            )),
      ],
    );
  }

  @override
  Widget buildMainContainer(BuildContext context) {
    return BorderBackground(
      child: ListView(
        padding: EdgeInsets.all(size10),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: <Widget>[
          _buildNewsest(context),
          _buildRanking(context),
          _buildTournament(context),
          _buildRecruit(context)
        ],
      ),
    );
  }

  @override
  void listenData(BuildContext context) {}
}

