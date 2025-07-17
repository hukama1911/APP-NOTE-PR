import 'package:flutter/material.dart';
import 'package:crud_rumah_sakit/model/kampus.dart';
import 'package:crud_rumah_sakit/service/api_service_kampus.dart';
import 'package:crud_rumah_sakit/screen/form_kampus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailKampus extends StatelessWidget {
  final Kampus kampus;
  const DetailKampus({required this.kampus});

  void hapus(BuildContext context) async {
    final confirm = await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Hapus Kampus'),
        content: Text('Yakin ingin menghapus kampus ini?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Batal')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text('Hapus')),
        ],
      ),
    );

    if (confirm == true) {
      bool success = await ApiServiceKampus.hapusKampus(kampus.id);
      if (success) Navigator.pop(context, true);
    }
  }

  Widget info(String title, String value, IconData icon) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.orange),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        ),
      ],
    ),
  );

  Widget mapView() {
    final double lat = double.tryParse(kampus.latitude) ?? 0.0;
    final double lng = double.tryParse(kampus.longitude) ?? 0.0;

    return Container(
      height: 250,
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lng),
            zoom: 15,
          ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(kampus.nama), backgroundColor: Colors.orange),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            info("Alamat", kampus.alamat, Icons.location_on),
            info("Telepon", kampus.telepon, Icons.phone),
            info("Kategori", kampus.kategori, Icons.category),
            info("Jurusan", kampus.jurusan, Icons.book),
            mapView(),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.edit),
                  label: Text("Edit"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => FormKampus(kampus: kampus)),
                    );
                    if (updated == true) Navigator.pop(context, true);
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.delete),
                  label: Text("Hapus"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () => hapus(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
