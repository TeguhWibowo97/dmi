import 'dart:convert';
import 'dart:io';

import 'package:dmi_app/controller/databasehelper.dart';
import 'package:dmi_app/gradasi_appbar.dart';
import 'package:dmi_app/umkm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class InputProdukPage extends StatefulWidget {
  @override
  _InputProdukPageState createState() => _InputProdukPageState();
}

class _InputProdukPageState extends State<InputProdukPage> {
  File _imageFile;
  final picker = ImagePicker();

  DataBaseHelper databaseHelper = new DataBaseHelper();

  final TextEditingController _namaprodukController =
      new TextEditingController();
  final TextEditingController _hargaController = new TextEditingController();
  final TextEditingController _namapemilikController =
      new TextEditingController();
  final TextEditingController _alamatpemilikController =
      new TextEditingController();
  final TextEditingController _nomorpemilikController =
      new TextEditingController();
  final TextEditingController _nomorwaController = new TextEditingController();
  final TextEditingController _deskripsiController = new TextEditingController();

  List kategoriItemList = List();
  String selectedValue;
  String selectedLayanan;
  List layanan = ["Produk", "Layanan Jasa"];
  final _formKey = GlobalKey<FormState>();

  Future<void> showInformationDialog(BuildContext context)async{
    return await showDialog(
      barrierDismissible: false,
      context: context, builder: (context){
      return CupertinoAlertDialog(
        title: Text("Terimakasih, Data Berhasil Disimpan", textAlign: TextAlign.center,),
        content: Text("Produk anda akan diverifikasi terlebih dahulu oleh admin dan akan ditampilkan dalam waktu 1x24 Jam, Untuk info lebih lanjut mengenai perubahan data dan lain-lain silahkan bisa hubungi ke email admin-dmi@gmail.com ", textAlign: TextAlign.center),
        actions: <Widget>[
          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return UmkmPage();
            }));
          }, child: Text("OKE"))
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

  Future getAllCategory() async {
    var response = await http.get(databaseHelper.serverUrlKategori);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);

      setState(() {
        kategoriItemList = jsonData;
      });
    }
    print(kategoriItemList);
  }

  Future chooseImage() async {
    // ignore: deprecated_member_use
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedImage.path);
    });
  }

  Future submit() async {
    if (selectedLayanan == "Produk") {
      var uri = Uri.parse(databaseHelper.serverUrlProduk);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_produk'] = _namaprodukController.text.trim();
      request.fields['harga'] = _hargaController.text.trim();
      request.fields['nama_pemilik'] = _namapemilikController.text.trim();
      request.fields['alamat_pemilik'] = _alamatpemilikController.text.trim();
      request.fields['nomor_pemilik'] = _nomorpemilikController.text.trim();
      request.fields['nomor_wa'] = _nomorwaController.text.trim();
      request.fields['id_kategori'] = selectedValue;
      request.fields['deskripsi'] = _deskripsiController.text.trim();
      var pic =
          await http.MultipartFile.fromPath("foto_produk", _imageFile.path);

      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("image upload");
        showInformationDialog(context);
      } else {
        print("image failed");
        print(request.files);
        showDialogGagal();
      }
    } else {
      var uri = Uri.parse(databaseHelper.serverUrlJasa);
      var request = http.MultipartRequest("POST", uri);
      request.fields['nama_jasa'] = _namaprodukController.text.trim();
      request.fields['harga'] = _hargaController.text.trim();
      request.fields['nama_pemilik'] = _namapemilikController.text.trim();
      request.fields['alamat_pemilik'] = _alamatpemilikController.text.trim();
      request.fields['nomor_pemilik'] = _nomorpemilikController.text.trim();
      request.fields['nomor_wa'] = _nomorwaController.text.trim();
      request.fields['id_kategori'] = selectedValue;
      request.fields['deskripsi'] = _deskripsiController.text.trim();
      var pic = await http.MultipartFile.fromPath("foto_jasa", _imageFile.path);

      request.files.add(pic);
      var response = await request.send();
      if (response.statusCode == 200) {
        print("image upload");
        showInformationDialog(context);
      } else {
        print("image failed");
        print(request.files);
        showDialogGagal();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this.getAllCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Input Jual Barang / Jasa"),
        flexibleSpace: GradasiAppBar(),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                        colors: [Color(0xff0096ff), Color(0xffe040fb)],
                        begin: FractionalOffset.topLeft,
                        end: FractionalOffset.bottomRight),
                  ),
                  height: 300,
                  child: Image(
                    image: AssetImage("images/dmi.png"),
                    width: 300,
                  )),
              Flexible(
                child: Container(
                  color: Colors.blue[50],
                  padding: EdgeInsets.all(7),
                  margin: EdgeInsets.only(top: 10),
                  child: ListView(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black54),
                            borderRadius: BorderRadius.circular(5)),
                        child: DropdownButton(
                          isExpanded: true,
                          hint: Text("-- Pilih Layanan --"),
                          value: selectedLayanan,
                          underline: SizedBox(),
                          items: layanan.map((value) {
                            return DropdownMenuItem(
                              child: Text(value),
                              value: value,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedLayanan = value;
                            });
                            print(selectedLayanan);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black54),
                              borderRadius: BorderRadius.circular(5)),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text("-- Pilih Kategori --"),
                            underline: SizedBox(),
                            value: selectedValue,
                            items: kategoriItemList.map((kategori) {
                              return DropdownMenuItem(
                                value: kategori['id_kategori'].toString(),
                                child: Text(kategori['nama_kategori']),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value;
                              });
                              print(selectedValue);
                            },
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _namaprodukController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.shopping_bag),
                            hintText: "Nama Produk / Jasa",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _namapemilikController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: "Nama Pemilik",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nomorpemilikController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Nomor yang bisa dihubungi",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nomorwaController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Image.asset(
                              "images/whatsapp.png",
                              width: 10,
                            ),
                            hintText: "Nomor Whatsapp",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _alamatpemilikController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_pin),
                            hintText: "Alamat Jamaah",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _hargaController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.attach_money),
                            hintText: "Harga Produk / Jasa",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _deskripsiController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Inputan Tidak Boleh Kosong";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.multiline,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.description_outlined),
                            hintText: "Deskripsi",
                            border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.blue[200],
                          child: Column(
                            children: [
                              Icon(Icons.image_search),
                              Text("Upload Foto")
                            ],
                          ),
                          onPressed: () {
                            chooseImage();
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: _imageFile == null
                            ? Image.asset("images/default.jpg")
                            : Image.file(_imageFile),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 10, left: 10, top: 10),
                        width: 500,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                              colors: [Color(0xff0096ff), Color(0xffe040fb)],
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
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.white,
                                    )),
                                Container(
                                    child: Text(
                                  "Kirim",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w700),
                                )),
                              ],
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if(selectedValue == null || selectedLayanan == null || _imageFile == null){
                                showDialogGagal();
                              }else{
                                print("validate");
                                showDialogProgress();
                                await Future.delayed(Duration(seconds: 3));
                                submit();
                              }
                            }else{
                              print("no vallidate");
                            }
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
    );
  }
}
