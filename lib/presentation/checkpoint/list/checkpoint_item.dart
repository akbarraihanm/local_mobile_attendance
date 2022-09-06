import 'package:flutter/material.dart';

import '../../../core/config/app_typography.dart';
import '../../../data/models/location/location_data.dart';
import '../../widgets/app_text.dart';

class CheckpointItem extends StatelessWidget {

  final LocationData data;

  const CheckpointItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(
              title: data.address,
              textStyle: AppTypography.body2(),
            ),
            const SizedBox(height: 12),
            AppText(
              title: "LatLng : ${data.latitude}, ${data.longitude}",
              textStyle: AppTypography.body2(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}