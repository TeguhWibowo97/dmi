import 'dart:convert';
import 'package:dmi_app/controller/databasehelper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class UlasanPage extends StatefulWidget {
  String idproduk;
  String idjasa;
  // int iterasi;
  UlasanPage({this.idproduk, this.idjasa});
  @override
  _UlasanPageState createState() => _UlasanPageState();
}

class _UlasanPageState extends State<UlasanPage> {
  DataBaseHelper databaseHelper = new DataBaseHelper();

  getUlasan() async {
    if (widget.idjasa != null) {
      var response =
          await http.post(databaseHelper.urlGetUlasanByIdJasa, body: {
        "id_jasa": widget.idjasa.toString(),
      });
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        return jsonData;
      }
    } else {
      var response =
          await http.post(databaseHelper.urlGetUlasanByIdProduk, body: {
        "id_produk": widget.idproduk.toString(),
      });
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        print(jsonData);
        return jsonData;
      }
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    this.getUlasan();
  }

  @override
  Widget build(BuildContext context) {
    int iterasi;
    return Scaffold(
      appBar: AppBar(
        title: Text("Semua Ulasan"),
      ),
      body: Container(
        child: FutureBuilder(
            future: getUlasan(),
            // ignore: missing_return
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length == 0) {
                  return Center(
                    child: Text(
                      "-- Tidak Ada Ulasan --",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: snapshot.data == null ? 0 : snapshot.data.length,
                  itemBuilder: (context, i) {
                    iterasi = int.parse(snapshot.data[i]['bintang']);
                    return Center(
                      child: Flexible(
                        child: Container(
                          padding: EdgeInsets.all(1),
                          margin: EdgeInsets.all(7),
                          color: Colors.blue[300],
                          child: Card(
                            child: ListTile(
                              leading: Icon(
                                Icons.person_sharp,
                                size: 41,
                              ),
                              title: Text(
                                snapshot.data[i]['nama_pengulas'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(snapshot.data[i]['deskripsi']),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      for (i = 0; i < iterasi; i++)
                                        Icon(
                                          Icons.star,
                                          color: Colors.blue,
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Icon(Icons.center_focus_strong_sharp),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
