import 'package:flutter/material.dart';
import 'package:crud_rumah_sakit/model/hospital.dart';
import 'package:crud_rumah_sakit/service/api_service_hospital.dart';

class FormHospital extends StatefulWidget {
  final bool isEdit;
  final Hospital? hospital;

  const FormHospital({required this.isEdit, this.hospital});

  @override
  _FormHospitalState createState() => _FormHospitalState();
}

class _FormHospitalState extends State<FormHospital> {
  final _formKey = GlobalKey<FormState>();
  final namaC = TextEditingController();
  final alamatC = TextEditingController();
  final teleponC = TextEditingController();
  final tipeC = TextEditingController();
  final latC = TextEditingController();
  final longC = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.isEdit && widget.hospital != null) {
      final h = widget.hospital!;
      namaC.text = h.nama;
      alamatC.text = h.alamat;
      teleponC.text = h.telepon;
      tipeC.text = h.tipe;
      latC.text = h.latitude;
      longC.text = h.longitude;
    }
  }

  @override
  void dispose() {
    namaC.dispose();
    alamatC.dispose();
    teleponC.dispose();
    tipeC.dispose();
    latC.dispose();
    longC.dispose();
    super.dispose();
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      Hospital data = Hospital(
        id: widget.isEdit ? widget.hospital!.id : 0,
        nama: namaC.text,
        alamat: alamatC.text,
        telepon: teleponC.text,
        tipe: tipeC.text,
        latitude: latC.text,
        longitude: longC.text,
      );

      bool result = widget.isEdit
          ? await ApiServiceHospital().updateHospital(data.id, data)
          : await ApiServiceHospital().addHospital(data);

      if (result) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal menyimpan data.")),
        );
      }
    }
  }

  InputDecoration inputStyle(String label, IconData icon) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: Colors.green),
    filled: true,
    fillColor: Colors.greenAccent.shade100,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit Rumah Sakit" : "Tambah Rumah Sakit"),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaC,
                decoration: inputStyle("Nama Rumah Sakit", Icons.local_hospital),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: alamatC,
                decoration: inputStyle("Alamat Lengkap", Icons.location_on),
                maxLines: 3,
                minLines: 2,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: teleponC,
                decoration: inputStyle("No. Telepon", Icons.phone),
                keyboardType: TextInputType.phone,
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: tipeC,
                decoration: inputStyle("Tipe Rumah Sakit", Icons.category),
                validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: latC,
                decoration: inputStyle("Latitude", Icons.map),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (double.tryParse(v) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              SizedBox(height: 12),
              TextFormField(
                controller: longC,
                decoration: inputStyle("Longitude", Icons.map_outlined),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Wajib diisi';
                  if (double.tryParse(v) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _save,
                icon: Icon(Icons.save),
                label: Text(widget.isEdit ? "Update" : "Simpan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
