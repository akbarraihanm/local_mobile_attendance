import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_test/core/config/icons_string.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/attendance/attendance_screen.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_event.dart';
import 'package:hash_micro_test/presentation/blocs/dashboard/dashboard_state.dart';
import 'package:hash_micro_test/presentation/checkpoint/list/checkpoint_screen.dart';

import '../../core/config/app_typography.dart';

class DashboardScreen extends StatefulWidget {

  static const routeName = "/dashboard";

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  final bloc = DIObject.dashboardBloc;

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: bloc,
        builder: (ctx, state) {
          if (state is LocationMenuState) return const CheckpointScreen();

          return const AttendanceScreen();
        },
      ),
      bottomNavigationBar: BlocBuilder(
        bloc: bloc,
        builder: (ctx, state) => BottomNavigationBar(
          currentIndex: bloc.index,
          selectedLabelStyle: AppTypography.action2(color: Colors.blue),
          selectedItemColor: Colors.blue,
          unselectedLabelStyle: AppTypography.body2(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          iconSize: 16,
          elevation: 2.5,
          enableFeedback: true,
          onTap: (v) => bloc.add(ChangeMenuDashboardEvent(v)),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                IconString.icAttendance,
                height: 24,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                IconString.icAttendance,
                height: 24,
                color: Colors.blue,
              ),
              label: 'Attendance',
              tooltip: 'Attendance',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                IconString.icLocation,
                height: 24,
                color: Colors.grey,
              ),
              activeIcon: Image.asset(
                IconString.icLocation,
                height: 24,
                color: Colors.blue,
              ),
              label: 'Checkpoint',
              tooltip: 'Checkpoint',
            ),
          ],
        ),
      ),
    );
  }
}
