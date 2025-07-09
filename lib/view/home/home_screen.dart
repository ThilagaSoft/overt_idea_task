import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_pro/bloc/user/user_bloc.dart';
import 'package:map_pro/bloc/user/user_event.dart';
import 'package:map_pro/bloc/user/user_state.dart';
import 'package:map_pro/controller/home_controller.dart';
import 'package:map_pro/model/user_model.dart';
import 'package:map_pro/repository/home_repository.dart';
import 'package:map_pro/utility/common_extension.dart';
import 'package:map_pro/utility/config/static_text.dart';
import 'package:map_pro/view/widgets/category_list_widgte.dart';
import 'package:map_pro/view/widgets/common_appBar.dart';
import 'package:map_pro/view/widgets/details_card_widget.dart';
import 'package:map_pro/view/widgets/meesage_widget.dart';
import 'package:map_pro/view/widgets/shimmer_profilecard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final currentLocale = context.currentLocale;
    final homeController = HomeController(context);

    return BlocProvider<UserBloc>(
      create: (_) =>
      UserBloc(homeRepository: HomeRepository())..add(LoadUserById()),
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state)
              {
                UserModel? userData;

                if (state is UserLoaded)
                {

                  userData = state.user;
                }

                return CommonAppBar(
                  title: StaticText.welcome,
                  backButton: false,
                  userData: userData,
                );
              },
            ),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              BlocBuilder<UserBloc, UserState>(builder: (context, state) {
                if (state is UserLoaded) {
                  return ProfileCard(
                    name: capitalize(state.user.userName),
                    phoneNumber: state.user.mobile,
                    country: state.user.countryData.name.common,
                    imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQUJud2BBjuoQY11nXmhJwokj2tXovmXddoMQ&s',
                  );
                }
                else if (state is UserLoading)
                {
                  return ShimmerProfileCard();
                }

                return ShimmerProfileCard();
              }),
              MessageWidget(message: StaticText.hintMessage.tr()),
              CategorySection(
                categories: homeController.mockCategories,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
