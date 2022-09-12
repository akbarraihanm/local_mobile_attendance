import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hash_micro_test/core/common/datetime_formatter.dart';
import 'package:hash_micro_test/core/config/app_typography.dart';
import 'package:hash_micro_test/core/util/app_util.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/attendance/select_checkpoint/select_checkpoint_dialog.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_event.dart';
import 'package:hash_micro_test/presentation/blocs/attendance/attendance_state.dart';
import 'package:hash_micro_test/presentation/widgets/app_button.dart';
import 'package:hash_micro_test/presentation/widgets/app_text.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  final bloc = DIObject.attendanceBloc;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    bloc.add(GetListAttendanceEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  void _getCurrentLocation(dynamic latLng) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AppUtil.showLoading(context);
      _isLoading = true;
    });
    bloc.position = await AppUtil.getCurrentLocation();
    bloc.latitude = bloc.position?.latitude;
    bloc.longitude = bloc.position?.longitude;
    _checkLoading();
    bloc.add(CreateAttendanceEvent(
        pinLatitude: latLng[0],
        pinLongitude: latLng[1]
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: "Attendance Check",
          textStyle: AppTypography.title4(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (ctx, state) {
          if (state is ShowLoadingAttendanceState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AppUtil.showLoading(context);
            });
            _isLoading = true;
          }

          if (state is SuccessCreateAttendanceState) {
            _checkLoading();
            bloc.add(ChangeAttendanceStateEvent());
            Fluttertoast.showToast(msg: state.message);
          }

          if (state is ShowErrorAttendanceState) {
            _checkLoading();
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AppUtil.showSnackBar(context, message: state.message);
            });
          }

          return _AttendanceForm(
            bloc: bloc,
            tapRecord: () async {
              final data = await AppUtil.showBottomSheet(
                context,
                child: const SelectCheckpointDialog(),
              );
              if (data != null) _getCurrentLocation(data);
            },
          );
        },
      ),
    );
  }

  void _checkLoading() {
    if (_isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Navigator.pop(context);
      });
      _isLoading = false;
    }
  }
}

class _AttendanceForm extends StatelessWidget {

  final AttendanceBloc bloc;
  final Function tapRecord;

  const _AttendanceForm({
    Key? key,
    required this.bloc,
    required this.tapRecord
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Center(child: _User()),
          const SizedBox(height: 16),
          _AttendanceItem(
            title: "Day",
            value: bloc.data != null? DateTimeFormatter.formatTime(
              dateTime: bloc.data?.dateTime, dateFormat: "EEEE"
            ): "-",
          ),
          const SizedBox(height: 8),
          _AttendanceItem(
            title: "Time",
            value: bloc.data != null? DateTimeFormatter.formatTime(
              dateTime: bloc.data?.dateTime, dateFormat: "HH:mm"
            ): "-",
          ),
          const SizedBox(height: 16),
          bloc.data == null? AppButton(
            title: "Record Attendance",
            textStyle: AppTypography.action1(color: Colors.white),
            color: Colors.green,
            radius: 16,
            isEnable: true,
            onPressed: tapRecord,
          ): AppText(
            title: "Your attendance completely recorded!",
            textStyle: AppTypography.subTitle2(),
          )
        ],
      ),
    );
  }
}

class _User extends StatelessWidget {
  const _User({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black12,
          child: Icon(Icons.person, size: 30, color: Colors.blue),
        ),
        const SizedBox(height: 16),
        AppText(
          title: "Hi, Worker!",
          textStyle: AppTypography.title3(),
        )
      ],
    );
  }
}

class _AttendanceItem extends StatelessWidget {

  final String title;
  final String value;

  const _AttendanceItem({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: title,
              textStyle: AppTypography.caption1(color: Colors.grey),
            ),
            const SizedBox(height: 12),
            AppText(
              title: value,
              textStyle: AppTypography.title4(),
            )
          ],
        ),
      ),
    );
  }
}



