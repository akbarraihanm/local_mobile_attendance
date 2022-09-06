import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hash_micro_test/core/config/app_typography.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/widgets/app_text.dart';

import '../../../core/util/app_util.dart';
import '../../../di/di_object.dart';
import '../../blocs/location/location_state.dart';
import '../../checkpoint/list/checkpoint_item.dart';
import '../../widgets/empty_data.dart';
import '../../widgets/refresh_builder.dart';

class SelectCheckpointDialog extends StatefulWidget {
  const SelectCheckpointDialog({Key? key}) : super(key: key);

  @override
  State<SelectCheckpointDialog> createState() => _SelectCheckpointDialogState();
}

class _SelectCheckpointDialogState extends State<SelectCheckpointDialog> {

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
    return SizedBox(
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, size: 24, color: Colors.black),
                ),
                AppText(
                  title: "Select Checkpoint",
                  textStyle: AppTypography.subTitle2(),
                ),
                const SizedBox()
              ],
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder(
            bloc: bloc,
            builder: (ctx, state) {
              if (state is ShowErrorLocationState) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                  AppUtil.showSnackBar(context, message: state.message);
                });
              }

              return Expanded(
                child: RefreshBuilder(
                  refresh: () => bloc.add(GetListLocationEvent()),
                  child: bloc.locations.isNotEmpty? ListView.separated(
                    itemCount: bloc.locations.length,
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (ctx, pos) => const SizedBox(height: 12),
                    itemBuilder: (ctx, pos) => GestureDetector(
                      onTap: () => Navigator.pop(context, [
                        bloc.locations.elementAt(pos).latitude,
                        bloc.locations.elementAt(pos).longitude
                      ]),
                      child: CheckpointItem(
                        data: bloc.locations.elementAt(pos),
                      ),
                    ),
                  ): const Padding(
                    padding: EdgeInsets.only(top: 64),
                    child: EmptyData(),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
