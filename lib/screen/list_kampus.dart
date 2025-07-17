import 'package:crud_rumah_sakit/model/kampus.dart';
import 'package:crud_rumah_sakit/screen/detail_kampus.dart';
import 'package:crud_rumah_sakit/screen/form_kampus.dart';
import 'package:crud_rumah_sakit/service/api_service_kampus.dart';
import 'package:flutter/material.dart';

class ListKampus extends StatefulWidget {
  @override
  _ListKampusState createState() => _ListKampusState();
}

class _ListKampusState extends State<ListKampus> {
  late Future<List<Kampus>> kampusList;

  @override
  void initState() {
    super.initState();
    kampusList = ApiServiceKampus.getAllKampus();
  }

  void refreshData() {
    setState(() {
      kampusList = ApiServiceKampus.getAllKampus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Daftar Kampus'), backgroundColor: Colors.teal),
      body: FutureBuilder<List<Kampus>>(
        future: kampusList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!
                  .map((kampus) => Card(
                child: ListTile(
                  leading: Icon(Icons.school, color: Colors.teal),
                  title: Text(kampus.nama),
                  subtitle: Text(kampus.kategori),
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DetailKampus(kampus: kampus)),
                    );
                    refreshData();
                  },
                ),
              ))
                  .toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Gagal memuat data'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => FormKampus()));
          refreshData();
        },
      ),
    );
  }
  }
