import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:patdoc/ui/views/appointments/appointments_view.dart';
import 'package:patdoc/ui/views/home/home_view.dart';
import 'package:patdoc/ui/views/messages/messages_list/messages_list_view.dart';
import 'package:patdoc/ui/views/messages/messages_view.dart';
import 'package:patdoc/ui/views/nav_bar/nav_bar_viewmodel.dart';
import 'package:patdoc/ui/views/patients/patients_view.dart';
import 'package:patdoc/ui/views/profile/profile_view.dart';
import 'package:patdoc/ui/views/reports/reports_view.dart';
import 'package:patdoc/ui/views/token/generate_token_view.dart';
import 'package:patdoc/utils/colors.dart';
import 'package:patdoc/utils/styles.dart';
import 'package:stacked/stacked.dart';

class NavBarView extends StatelessWidget {
  final Map<int, Widget> _viewCache = <int, Widget>{};

  NavBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavBarViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: [
            ///* INBUILT FLUTTER WIDGET FOR PAGE TRANSITIONING
            Expanded(
              child: PageTransitionSwitcher(
                duration: const Duration(milliseconds: 400),
                reverse: model.reverse,
                transitionBuilder: (
                  Widget child,
                  Animation<double> primaryAnimation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },

                ///* RETURNS A WIDGET UI FOR THE SWITCHER IMPLEMENTATION
                child: getViewForIndex(model.currentIndex, model.isPhysician),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          iconSize: 18.sp,
          elevation: 6,
          backgroundColor: AppColors.whiteColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          selectedLabelStyle: AppStyles.primaryNormal(11.5.sp),
          unselectedLabelStyle: AppStyles.color5Normal(11.5.sp),
          currentIndex: model.currentIndex,
          onTap: model.setIndex,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: AppColors.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                model.isPhysician
                    ? 'assets/icons/patients_icon.svg'
                    : 'assets/icons/graph.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                model.isPhysician
                    ? 'assets/icons/patients_icon.svg'
                    : 'assets/icons/graph.svg',
                color: AppColors.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/calendar.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/calendar.svg',
                color: AppColors.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/messages.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/messages.svg',
                color: AppColors.primaryColor,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                height: 20,
                width: 20,
              ),
              activeIcon: SvgPicture.asset(
                'assets/icons/profile.svg',
                color: AppColors.primaryColor,
              ),
              label: '',
            ),
          ],
        ),
      ),
      viewModelBuilder: () => NavBarViewModel(),
      onViewModelReady: (model) => model.init(),
    );
  }

  Widget getViewForIndex(int index, bool isPhysician) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = const HomeView();
          break;
        case 1:
          _viewCache[index] =
              isPhysician ? const PatientsView() : const ReportsView();
          break;
        case 2:
          _viewCache[index] = const AppointmentsView();
          break;
        case 3:
          _viewCache[index] =
              isPhysician ? const MessagesListView() : const MessagesView();
          break;
        case 4:
          _viewCache[index] =
              isPhysician ? const GenerateTokenView() : const ProfileView();
          break;
        default:
          _viewCache[index] = const HomeView();
      }
    }
    return _viewCache[index]!;
  }
}
