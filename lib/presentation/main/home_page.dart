// Flutter imports:
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:carousel_slider/carousel_slider.dart';

// Project imports:
import 'package:flutter_clean_mvvm/app/dependency_injection.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import 'package:flutter_clean_mvvm/presentation/main/home/home_viewmodel.dart';
import 'package:flutter_clean_mvvm/presentation/resources/color_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/routes_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/strings_manager.dart';
import 'package:flutter_clean_mvvm/presentation/resources/values_manager.dart';
import '../common/state_renderer/state_renderer_impl.dart';

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
    return StreamBuilder(
      stream: _viewModel.outputHomeData,
      builder: (context, snapshot) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getBanner(snapshot.data?.banners),
            _getSection(AppStrings.services.tr()),
            _getServicesWidget(snapshot.data?.services),
            _getSection(AppStrings.stores.tr()),
            _getStoresWidget(snapshot.data?.stores),
          ],
        );
      },
    );
  }

  // Widget _getContentWidget() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _getBannersCarousel(),
  //       _getSection(AppStrings.services),
  //       _getServices(),
  //       _getSection(AppStrings.stores),
  //       _getStores(),
  //     ],
  //   );
  // }

  // Widget _getBannersCarousel() {
  //   return StreamBuilder<List<BannerAd>>(
  //     stream: _viewModel.outputBanners,
  //     builder: (context, snapshot) {
  //       return _getBanner(snapshot.data);
  //     },
  //   );
  // }

  Widget _getBanner(List<BannerAd>? banners) {
    if (banners == null) {
      return Container();
    }
    return CarouselSlider(
      options: CarouselOptions(
        height: AppSize.s190,
        autoPlay: true,
        enableInfiniteScroll: true,
        enlargeCenterPage: true,
      ),
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
    );
  }

  Widget _getSection(String title) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Text(title, style: Theme.of(context).textTheme.headline3),
    );
  }

  // Widget _getServices() {
  //   return StreamBuilder<List<Service>>(
  //     stream: _viewModel.outputServices,
  //     builder: (context, snapshot) {
  //       return _getServicesWidget(snapshot.data);
  //     },
  //   );
  // }

  Widget _getServicesWidget(List<Service>? services) {
    if (services == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p12),
      child: Container(
        height: AppSize.s140,
        margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: services
              .map(
                (service) => Card(
                  elevation: AppSize.s4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSize.s12),
                    side: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
                  ),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          service.image,
                          fit: BoxFit.cover,
                          width: AppSize.s120,
                          height: AppSize.s100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: AppPadding.p8),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            service.title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // Widget _getStores() {
  //   return StreamBuilder<List<Store>>(
  //     stream: _viewModel.outputServices,
  //     builder: (context, snapshot) {
  //       return _getStoresWidget(snapshot.data);
  //     },
  //   );
  // }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p12),
      child: Flex(
        direction: Axis.vertical,
        children: [
          GridView.count(
            crossAxisSpacing: AppSize.s8,
            mainAxisSpacing: AppSize.s8,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: AppSize.s2.toInt(),
            children: List.generate(stores.length, (index) {
              return InkWell(
                onTap: () {
                  // navigate to store details screen
                  Navigator.of(context).pushNamed(Routes.storeDetailsRoute);
                },
                child: Card(
                  elevation: AppSize.s4,
                  child: Image.network(stores[index].image),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
