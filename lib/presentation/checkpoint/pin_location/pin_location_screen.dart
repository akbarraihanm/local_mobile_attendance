import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hash_micro_test/core/config/app_typography.dart';
import 'package:hash_micro_test/core/util/app_util.dart';
import 'package:hash_micro_test/data/models/location/location_data.dart';
import 'package:hash_micro_test/di/di_object.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_bloc.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_event.dart';
import 'package:hash_micro_test/presentation/blocs/location/location_state.dart';
import 'package:hash_micro_test/presentation/widgets/app_button.dart';
import 'package:hash_micro_test/presentation/widgets/app_text.dart';

class PinLocationScreen extends StatefulWidget {

  static const routeName = "/pin-location";

  const PinLocationScreen({Key? key}) : super(key: key);

  @override
  State<PinLocationScreen> createState() => _PinLocationScreenState();
}

class _PinLocationScreenState extends State<PinLocationScreen> {

  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;
  final bloc = DIObject.locationBloc;

  bool _isCameraMoving = false;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  void _getCurrentLocation() async {
    bloc.position = await AppUtil.getCurrentLocation();
    bloc.address = await AppUtil.getAddress(
      bloc.position?.latitude,
      bloc.position?.longitude
    );
    bloc.add(ChangeLocationEventState());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          title: "Pin A Checkpoint",
          textStyle: AppTypography.title4(color: Colors.white),
        ),
        automaticallyImplyLeading: true,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (ctx, state) {
          if (state is SuccessCreateLocationState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Navigator.pop(context);
            });
            Fluttertoast.showToast(msg: state.message);
          }

          if (state is ShowErrorLocationState) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              AppUtil.showSnackBar(context, message: state.message);
            });
          }

          return Stack(
            children: [
              bloc.position != null? GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    bloc.position?.latitude ?? 0.0,
                    bloc.position?.longitude ?? 0.0,
                  ),
                  zoom: 19,
                ),
                onMapCreated: (v) {
                  _controller.complete(v);
                  _mapController = v;
                },
                onCameraMove: (v) {
                  _cameraPosition = v;
                  _isCameraMoving = true;
                  bloc.add(ChangeLocationEventState());
                },
                onCameraIdle: () {
                  _isCameraMoving = false;
                  bloc.add(OnCameraIdleLocationEvent(
                    controller: _mapController,
                    cameraPosition: _cameraPosition,
                  ));
                },
              ): Center(
                child: AppText(
                  title: "Loading Map",
                  textStyle: AppTypography.body2(color: Colors.grey),
                ),
              ),
              const Center(
                child: Icon(Icons.location_on, size: 36, color: Colors.red),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                left: 16,
                child: bloc.position != null? _LocationDetailCard(
                  bloc: bloc,
                  isCameraMoving: _isCameraMoving,
                ): const SizedBox(),
              )
            ],
          );
        },
      ),
    );
  }
}

class _LocationDetailCard extends StatelessWidget {

  final LocationBloc bloc;
  final bool isCameraMoving;

  const _LocationDetailCard({
    Key? key,
    required this.bloc,
    required this.isCameraMoving
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                !isCameraMoving? _ColItem(
                  title: "Address",
                  value: bloc.address,
                ): const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Center(
                    child: SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        !isCameraMoving? AppButton(
          title: "Confirm",
          textStyle: AppTypography.action2(color: Colors.white),
          color: Colors.green,
          radius: 16,
          isEnable: true,
          onPressed: () {
            bloc.add(CreateLocationEvent(LocationData(
              address: "",
              latitude: bloc.latitude,
              longitude: bloc.longitude
            )));
          },
        ): const SizedBox()
      ],
    );
  }
}


class _ColItem extends StatelessWidget {

  final String title;
  final String value;

  const _ColItem({
    Key? key,
    required this.title,
    required this.value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          title: title,
          textStyle: AppTypography.caption1(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        AppText(
          title: value,
          textStyle: AppTypography.body2(),
        ),
        const SizedBox(height: 14)
      ],
    );
  }
}

