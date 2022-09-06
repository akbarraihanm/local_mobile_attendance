import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_test/core/common/navigation.dart';
import 'package:hash_micro_test/core/config/app_typography.dart';
import 'package:hash_micro_test/core/util/app_util.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';
import 'package:hash_micro_test/presentation/checkpoint/pin_location/pin_location_screen.dart';
import 'package:hash_micro_test/presentation/widgets/app_text.dart';
import 'package:hash_micro_test/presentation/widgets/empty_data.dart';
import 'package:hash_micro_test/presentation/widgets/refresh_builder.dart';

import 'checkpoint_item.dart';

class CheckpointScreen extends StatefulWidget {
  const CheckpointScreen({Key? key}) : super(key: key);

  @override
  State<CheckpointScreen> createState() => _CheckpointScreenState();
}

class _CheckpointScreenState extends State<CheckpointScreen> {

  final bloc = DIObject.locationBloc;

  @override
  void initState() {
    super.initState();
    bloc.add(GetListLocationEvent());
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: "Checkpoint",
          textStyle: AppTypography.title4(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        onPressed: () async {
          await Navigation.push(context, PinLocationScreen.routeName);
          bloc.add(GetListLocationEvent());
        },
        child: const Icon(Icons.add, size: 26, color:  Colors.white),
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (ctx, state) {
          if (state is ShowErrorLocationState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AppUtil.showSnackBar(context, message: state.message);
            });
          }

          return RefreshBuilder(
            refresh: () => bloc.add(GetListLocationEvent()),
            child: bloc.locations.isNotEmpty? ListView.separated(
              itemCount: bloc.locations.length,
              padding: const EdgeInsets.all(16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (ctx, pos) => const SizedBox(height: 12),
              itemBuilder: (ctx, pos) => CheckpointItem(
                data: bloc.locations.elementAt(pos),
              ),
            ): const Padding(
              padding: EdgeInsets.only(top: 150),
              child: EmptyData(),
            ),
          );
        },
      ),
    );
  }
}
