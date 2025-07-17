import 'package:flutter/material.dart';
import 'package:crud_rumah_sakit/service/api_service_hospital.dart';
import 'package:crud_rumah_sakit/model/hospital.dart';
import 'form_hospital.dart';
import 'detail_hospital.dart';

class ListRumahSakit extends StatefulWidget {
  @override
  _ListRumahSakitState createState() => _ListRumahSakitState();
}

class _ListRumahSakitState extends State<ListRumahSakit> {
  late Future<List<Hospital>> futureHospitals;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    setState(() {
      futureHospitals = ApiServiceHospital().getHospitals();
    });
  }

  void deleteHospital(int id) async {
    await ApiServiceHospital().deleteHospital(id);
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Rumah Sakit'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Hospital>>(
        future: futureHospitals,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final h = snapshot.data![index];
                return Card(
                  color: Colors.greenAccent.shade100,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(Icons.local_hospital, color: Colors.green.shade700, size: 30),
                    title: Text(
                      h.nama,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      h.alamat,
                      style: TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.map, color: Colors.teal),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DetailHospital(hospital: h)),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.pink),
                          onPressed: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FormHospital(isEdit: true, hospital: h),
                              ),
                            );
                            if (result == true) fetchData();
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => deleteHospital(h.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => FormHospital(isEdit: false)),
          );
          if (result == true) fetchData();
        },
        backgroundColor: Colors.green,
        icon: Icon(Icons.add),
        label: Text("Tambah"),
      ),
    );
  }
}
