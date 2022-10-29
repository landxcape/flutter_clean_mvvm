// Flutter imports:
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/values_manager.dart';

import '../common/state_renderer/state_renderer_impl.dart';

// Project imports:

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  @override
  void initState() {
    _bind();
    super.initState();
  }

  _bind() {
    _viewModel.start();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(), () {
                  _viewModel.start();
                }) ??
                Container();
          },
        ),
      ),
    );
  }

  Widget _getContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getBannersCarousel(),
        _getSection(AppStrings.services),
        _getServices(),
        _getSection(AppStrings.stores),
        _getStores(),
      ],
    );
  }

  Widget _getBannersCarousel() {
    return StreamBuilder<List<BannerAd>>(
      stream: _viewModel.outputBanners,
      builder: (context, snapshot) {
        return _getBanner(snapshot.data);
      },
    );
  }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners == null) {
      return Container();
    }
    return CarouselSlider(
      items: banners
          .map((banner) => SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: AppSize.s1_5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    child: Image.network(
                      banner.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ))
          .toList(),
      options: CarouselOptions(
        height: AppSize.s190,
        autoPlay: true,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
      ),
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Text(title, style: Theme.of(context).textTheme.headline3),
    );
  }

  Widget _getServices() {
    return Container();
  }

  Widget _getStores() {
    return Container();
  }
}
