import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crud_rumah_sakit/model/kampus.dart';

class KampusMapView extends StatelessWidget {
  final Kampus kampus;

  const KampusMapView({required this.kampus});

  @override
  Widget build(BuildContext context) {
    final double lat = double.tryParse(kampus.latitude) ?? 0.0;
    final double lng = double.tryParse(kampus.longitude) ?? 0.0;

    return Container(
      height: 250,
      margin: EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(lat, lng), zoom: 15),
          markers: {
            Marker(
              markerId: MarkerId(kampus.nama),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: kampus.nama, snippet: kampus.alamat),
            ),
          },
        ),
      ),
    );
  }
}
