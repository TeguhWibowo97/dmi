import 'package:dmi_app/gradasi_appbar.dart';
import 'package:dmi_app/inputproduk_page.dart';
import 'package:dmi_app/jasa_page.dart';
import 'package:dmi_app/produk_page.dart';
import 'package:flutter/material.dart';

class UmkmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pusat UMKM Jamaah"),
        flexibleSpace: GradasiAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TombolJualBarang(),
            Spacer(
              flex: 3,
            ),
            TombolProduk(),
            Spacer(
              flex: 1,
            ),
            TombolLayananJasa(),
            Spacer(
              flex: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class TombolProduk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: [Colors.blue[300], Colors.purple[400]],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight),
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.shopping_bag,
                size: 50,
              ),
            ),
            Container(
              child: Text(
                "Produk",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        textColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProdukPage();
          }));
        },
      ),
    );
  }
}

class TombolLayananJasa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
            colors: [Colors.blue[300], Colors.purple[400]],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight),
      ),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.verified_user,
                size: 50,
              ),
            ),
            Container(
              child: Text(
                "Layanan Jasa",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
        textColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return JasaPage();
          }));
        },
      ),
    );
  }
}

class TombolJualBarang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
              width: 180,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Colors.blue[300], Colors.pink],
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.topRight),
              ),
              child: RaisedButton(
                color: Colors.transparent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: <Widget>[
                    Container(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Container(
                        child: Text(
                      "Jual Sesuatu",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return InputProdukPage();
                  }));
                },
              )),
        ],
      ),
      width: 500,
      height: 70,
    );
  }
}
