import 'dart:convert';

import 'package:dmi_app/controller/databasehelper.dart';
import 'package:dmi_app/detailjasa_page.dart';
import 'package:dmi_app/gradasi_appbar.dart';
import 'package:dmi_app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class JasaPage extends StatefulWidget {
  @override
  _JasaPageState createState() => _JasaPageState();
}

class _JasaPageState extends State<JasaPage> {
  String selectedValue;
  List categoryItemList = List();
  String caridata;

  DataBaseHelper databaseHelper = new DataBaseHelper();

  Future getAllCategory() async {
    var response = await http.get(databaseHelper.serverUrlKategori);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      setState(() {
        categoryItemList = jsonData;
      });
      print(categoryItemList);
    }
  }

  Future getPostByCategory() async {
    var response = await http.post(databaseHelper.urlGetJasaByIdKategori,
        body: {"id_kategori": selectedValue});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      return jsonData;
    }
    print(response);
  }

  Future getPostByPencarian() async {
    var response = await http.post(databaseHelper.urlGetJasaByPencarian,
        body: {"cari": cariController.text.trim()});
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      return jsonData;
    }
    print(response);
  }

  @override
  void initState() {
    super.initState();
    this.getAllCategory();
  }

  TextEditingController cariController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Jasa Jamaah"),
        flexibleSpace: GradasiAppBar(),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return HomePage();
                }));
              })
        ],
      ),
      body: Container(
        // padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                child: TextFormField(
                  controller: cariController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Tidak Boleh Kosong";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: "Cari Disini",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Container(
              child: RaisedButton(
                  child: Text("Cari"),
                  color: Colors.purple,
                  textColor: Colors.white,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        caridata = cariController.text.trim();
                        getPostByPencarian();
                        print(caridata);
                      });
                    }
                  }),
            ),
            Container(
                padding: EdgeInsets.all(7),
                margin: EdgeInsets.only(top: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  gradient: LinearGradient(
                      colors: [Colors.blue[300], Colors.purple[400]],
                      begin: FractionalOffset.topRight,
                      end: FractionalOffset.topLeft),
                ),
                child: DropdownButton(
                  dropdownColor: Colors.purple[300],
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                    size: 50,
                  ),
                  isExpanded: true,
                  hint: Text(
                    "-- Pilih Kategori --",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 17),
                  ),
                  underline: SizedBox(),
                  value: selectedValue,
                  items: categoryItemList.map((kategori) {
                    return DropdownMenuItem(
                      value: kategori['id_kategori'].toString(),
                      child: Text(kategori['nama_kategori'],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                      caridata = null;
                    });
                    print(selectedValue);
                  },
                )),
            selectedValue != null
                ? Flexible(
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: FutureBuilder(
                          future: caridata != null
                              ? getPostByPencarian()
                              : getPostByCategory(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length == 0) {
                                return Text(
                                  "-- Tidak Ada Data --",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                );
                              }
                              return ListJasa(
                                list: snapshot.data,
                              );
                            }
                            return CircularProgressIndicator();
                          }),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Text(
                        "Pilih Kategori Dulu !!!",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.w700),
                      )
                    ],
                  )),
          ],
        ),
      ),
    );
  }
}

class ListJasa extends StatefulWidget {
  final List list;
  ListJasa({this.list});
  @override
  _ListJasaState createState() => _ListJasaState();
}

class _ListJasaState extends State<ListJasa> {
  DataBaseHelper databaseHelper = new DataBaseHelper();
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.list == null ? 0 : widget.list.length,
      itemBuilder: (context, i) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            gradient: LinearGradient(
                colors: [Colors.blue[300], Colors.purple[400]],
                begin: FractionalOffset.topLeft,
                end: FractionalOffset.topRight),
          ),
          height: 100,
          margin: EdgeInsets.only(bottom: 7),
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 100,
                margin: EdgeInsets.all(5),
                child: FlatButton(
                  padding: EdgeInsets.all(5),
                  color: Colors.blue[50],
                  // child: Image.network(databaseHelper.serverUrlImage +
                  //     widget.list[i]['foto_jasa'], fit: BoxFit.contain, repeat: ImageRepeat.repeat,),
                  child: Image(
                    image: NetworkImage(databaseHelper.serverUrlImage +
                       widget.list[i]['foto_jasa']),
                       fit: BoxFit.contain,
                       repeat: ImageRepeat.repeat,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return DetailJasaPage(
                        list: widget.list,
                        index: i,
                      );
                    }));
                  },
                ),
              ),
              Flexible(
                child: Container(
                  color: Colors.blue[100],
                  margin: EdgeInsets.all(5),
                  padding: EdgeInsets.all(5),
                  height: 100,
                  child: Column(
                    children: <Widget>[
                      new Text(
                        widget.list[i]['nama_jasa'],
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Icon(
                                Icons.location_pin,
                                size: 15,
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              child: Text(
                                widget.list[i]['alamat_pemilik'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        child: Row(
                          children: [
                            Container(
                              child: Icon(
                                Icons.person,
                                size: 15,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.list[i]['nama_pemilik'],
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        decimalDigits: 0,
                                        symbol: 'Rp ')
                                    .format(widget.list[i]['harga']),
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.red,
                                    fontSize: 20),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
