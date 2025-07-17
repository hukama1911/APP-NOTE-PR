import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:crud_rumah_sakit/model/hospital.dart';

class DetailHospital extends StatelessWidget {
  final Hospital hospital;

  const DetailHospital({required this.hospital});

  @override
  Widget build(BuildContext context) {
    final LatLng? pos = (hospital.latitude.isNotEmpty && hospital.longitude.isNotEmpty)
        ? LatLng(double.parse(hospital.latitude), double.parse(hospital.longitude))
        : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.nama),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Container(
            height: 250,
            child: pos != null
                ? GoogleMap(
              initialCameraPosition: CameraPosition(target: pos, zoom: 14),
              markers: {
                Marker(markerId: MarkerId('rs'), position: pos),
              },
            )
                : Center(child: Text("Lokasi tidak tersedia")),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: Colors.greenAccent.shade100,
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoRow(icon: Icons.local_hospital, label: 'Nama', value: hospital.nama),
                    SizedBox(height: 12),
                    InfoRow(icon: Icons.location_on, label: 'Alamat', value: hospital.alamat),
                    SizedBox(height: 12),
                    InfoRow(icon: Icons.phone, label: 'Telepon', value: hospital.telepon),
                    SizedBox(height: 12),
                    InfoRow(icon: Icons.category, label: 'Tipe', value: hospital.tipe),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: Colors.green),
        SizedBox(width: 10),
        Expanded(
          child: RichText(
            text: TextSpan(
              text: '$label:\n',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.green.shade900,
              ),
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
