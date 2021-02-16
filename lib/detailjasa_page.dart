import 'dart:convert';

import 'package:dmi_app/controller/databasehelper.dart';
import 'package:dmi_app/inputulasan_page.dart';
import 'package:dmi_app/gradasi_appbar.dart';
import 'package:dmi_app/ulasan_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class DetailJasaPage extends StatefulWidget {
  List list;
  int index;

  DetailJasaPage({this.list, this.index});
  @override
  _DetailJasaPageState createState() => _DetailJasaPageState();
}

class _DetailJasaPageState extends State<DetailJasaPage> {
  DataBaseHelper databaseHelper = new DataBaseHelper();
  int jumlah = 1;
  String idnya;

  void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('could not launch $command');
    }
  }

  void launchWhatsapp({@required number, @required message}) async {
    String url = "whatsapp://send?phone=$number&text=$message";

    await canLaunch(url) ? launch(url) : print("Tidak bisa buka Whatsapp");
  }

  Future getPostByIdJasa() async {
    var response = await http.post(databaseHelper.urlGetUlasanByIdJasa,
        body: {"id_jasa": widget.list[widget.index]['id'].toString()});
    // print(widget.list[widget.index]['id']);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData;
    }
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    this.getPostByIdJasa();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Jasa"),
        flexibleSpace: GradasiAppBar(),
        // leading: IconButton(icon: Icon(Icons.home, color: Colors.white,), onPressed: null),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                // Navigator.pushNamedAndRemoveUntil(
                //     context, "/home_page", (route) => false);
              })
        ],
      ),
      body: Center(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Flexible(
                    child: Container(
                      padding: EdgeInsets.all(3),
                  margin: EdgeInsets.all(10),
                  height: 300,
                  width: 500,
                  color: Colors.blue,
                  child: Image.network(
                      databaseHelper.serverUrlImage +
                          widget.list[widget.index]['foto_jasa'],
                      fit: BoxFit.contain,
                      repeat: ImageRepeat.repeat),
                )),
                // isi konten
                Flexible(
                  child: Container(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(7),
                          color: Colors.blue[50],
                          child: Flexible(
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  height: 20,
                                  thickness: 3,
                                  color: Colors.blue[200],
                                ),
                                Container(
                                  child: Text(
                                    widget.list[widget.index]['nama_jasa'],
                                    style: TextStyle(
                                        fontSize: 19,
                                        color: Colors.blue[700],
                                        fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Divider(
                                  height: 20,
                                  thickness: 3,
                                  color: Colors.blue[200],
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    widget.list[widget.index]['nama_pemilik'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 7),
                                  child: Text(
                                    widget.list[widget.index]['nomor_pemilik'],
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: 17,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  child: Text(
                                    widget.list[widget.index]['alamat_pemilik'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 15),
                                  child: Text(
                                    NumberFormat.currency(
                                      locale: 'id',
                                      decimalDigits: 0,
                                      symbol: 'Rp ',
                                    ).format(
                                        widget.list[widget.index]['harga']),
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 21,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(right: 10, left: 10, bottom: 10),
                          padding: EdgeInsets.all(7),
                          color: Colors.blue[200],
                          child: Column(
                            children: <Widget>[
                              Divider(
                                height: 20,
                                thickness: 3,
                                color: Colors.black,
                              ),
                              Container(
                                child: Text(
                                  "Deskripsi Jasa",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 21),
                                ),
                              ),
                              Divider(
                                height: 20,
                                thickness: 3,
                                color: Colors.black,
                              ),
                              Container(
                                child: Text(
                                    widget.list[widget.index]['deskripsi']),
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: <Widget>[
                                Spacer(),
                                RaisedButton(
                                  color: Colors.pink[400],
                                  child:
                                      Text("-", style: TextStyle(fontSize: 30)),
                                  onPressed: () {
                                    setState(() {
                                      jumlah--;
                                    });
                                  },
                                ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    jumlah.toString(),
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: RaisedButton(
                                    color: Colors.pink[400],
                                    child: Text("+",
                                        style: TextStyle(fontSize: 30)),
                                    onPressed: () {
                                      setState(() {
                                        jumlah++;
                                      });
                                    },
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [Colors.blue[300], Colors.purple[400]],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child:
                                        Icon(Icons.phone, color: Colors.white),
                                  ),
                                  Container(
                                      child: Text(
                                    "Hubungi Sekarang",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                            ),
                            onPressed: () {
                              customLaunch('tel:' +
                                  widget.list[widget.index]['nomor_pemilik']);
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [Colors.blue[300], Colors.green],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Image.asset(
                                        "images/whatsapp.png",
                                        width: 30,
                                      )),
                                  Container(
                                      child: Text(
                                    "Hubungi Whatsapp",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                            ),
                            onPressed: () {
                              String judul =
                                  widget.list[widget.index]['nama_jasa'];
                              launchWhatsapp(
                                  number: '+62' +
                                      widget.list[widget.index]['nomor_wa'],
                                  message:
                                      'Assalamualaikum wr.wb saya berminat untuk bertanya lebih lanjut mengenai *$judul* dengan ketersediaan = ' +
                                          jumlah.toString());
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [Colors.blue[300], Colors.pink],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.edit_outlined,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      child: Text(
                                    "Beri Ulasan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return InputUlasanPage(
                                  idjasa: widget.list[widget.index]['id']
                                      .toString(),
                                  idproduk: null,
                                );
                              }));
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                          width: 500,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: LinearGradient(
                                colors: [Colors.blue[300], Colors.orange],
                                begin: FractionalOffset.topLeft,
                                end: FractionalOffset.bottomRight),
                          ),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            color: Colors.transparent,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.remove_red_eye_outlined,
                                        color: Colors.white),
                                  ),
                                  Container(
                                      child: Text(
                                    "Lihat Semua Ulasan",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  )),
                                ],
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return UlasanPage(
                                  idjasa: widget.list[widget.index]['id']
                                      .toString(),
                                  idproduk: null,
                                );
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
