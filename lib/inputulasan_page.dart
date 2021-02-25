import 'package:dmi_app/controller/databasehelper.dart';
import 'package:dmi_app/umkm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class InputUlasanPage extends StatefulWidget {
  String idproduk;
  String idjasa;
  InputUlasanPage({this.idproduk, this.idjasa});

  @override
  _InputUlasanPageState createState() => _InputUlasanPageState();
}

class _InputUlasanPageState extends State<InputUlasanPage> {
  String selectedBintang;
  List bintangList = ['1', '2', '3', '4', '5'];
  final _formKey = GlobalKey<FormState>();

  DataBaseHelper databaseHelper = new DataBaseHelper();
  TextEditingController deskripsiController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();

  tambahUlasan() async {
    if(widget.idjasa != null){
      var response = await http.post(databaseHelper.serverUrlUlasan, body: {
        "nama_pengulas": namaController.text.trim(),
        "bintang": selectedBintang.toString(),
        "deskripsi": deskripsiController.text.trim(),
        "id_jasa": widget.idjasa.toString(),
      });
      if (response.statusCode == 200) {
        print("berhasil");
        showInformationDialog(context);
      } else {
        showDialogGagal();
      }
    }else{
      var response = await http.post(databaseHelper.serverUrlUlasan, body: {
        "nama_pengulas": namaController.text.trim(),
        "bintang": selectedBintang.toString(),
        "deskripsi": deskripsiController.text.trim(),
        "id_produk": widget.idproduk.toString(),
      });
      if (response.statusCode == 200) {
        print("berhasil");
        showInformationDialog(context);
      } else {
        showDialogGagal();
      }
    }
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Terimakasih, Ulasan Berhasil Disimpan",
              textAlign: TextAlign.center,
            ),
            content: Text(
                "Ulasan anda akan segera ditampilkan, dan admin berhak menghapus ulasan anda jika dirasa ulasan tidak relevan atau mengandung unsur yang tidak layak untuk ditampilkan.",
                textAlign: TextAlign.center),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UmkmPage();
                    }));
                  },
                  child: Text("OKE"))
            ],
          );
        });
  }

  Future showDialogProgress() async {
    return await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Sedang Dalam Proses",
              textAlign: TextAlign.center,
            ),
            content: LinearProgressIndicator(),
            actions: <Widget>[],
          );
        });
  }

  Future showDialogGagal() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              "Gagal !!!",
              textAlign: TextAlign.center,
            ),
            content: Text("Inputan Belum anda isi semua"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Input Ulasan"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black54),
                    borderRadius: BorderRadius.circular(5)),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 40,
                  ),
                  isExpanded: true,
                  hint: Text(
                    "-- Pilih Bintang --",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  underline: SizedBox(),
                  value: selectedBintang,
                  items: bintangList.map((value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text("Bintang " + value,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 17)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedBintang = value;
                    });
                    print(selectedBintang);
                  },
                ),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Inputan Tidak Boleh Kosong";
                  }
                  return null;
                },
                controller: namaController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: "Masukkan Nama Anda",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return "Inputan Tidak Boleh Kosong";
                  }
                  return null;
                },
                controller: deskripsiController,
                minLines: 1,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.description_outlined),
                    hintText: "Masukkan Ulasan Anda",
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white))),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 100,
                height: 70,
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
                    textColor: Colors.white,
                    child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 21),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        if (selectedBintang == null) {
                          showDialogGagal();
                        } else {
                          showDialogProgress();
                          await Future.delayed(Duration(seconds: 3));
                          tambahUlasan();
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
