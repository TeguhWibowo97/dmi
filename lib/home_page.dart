import 'package:dmi_app/gradasi_appbar.dart';
import 'package:dmi_app/umkm_page.dart';
// import 'package:dmi_app/users_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Dewan Masjid Indonesia",
            style: TextStyle(color: Colors.white),
          ),
        ),
        flexibleSpace: GradasiAppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 2,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                ButtonKesatu(),
                Spacer(),
                ButtonKedua(),
                Spacer(),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            Row(
              children: <Widget>[
                Spacer(),
                ButtonKetiga(),
                Spacer(),
                ButtonKeempat(),
                Spacer(),
              ],
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonKedua extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RaisedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage(
                  "images/jadwalsholat.png",
                ),
              ),
            ),
            Container(
              child: Text(
                "Jadwal Sholat",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return ;
          }));
        },
      ),
    );
  }
}

class ButtonKesatu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RaisedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage(
                  "images/carimasjid.png",
                ),
                height: 100,
              ),
            ),
            Container(
              child: Text(
                "Cari Masjid",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context){
          //   return UserPages();
          // }));
        },
      ),
    );
  }
}
class ButtonKetiga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RaisedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage(
                  "images/kompas.png",
                ),
                height: 100,
              ),
            ),
            Container(
              child: Text(
                "Arah Kiblat",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {},
      ),
    );
  }
}
class ButtonKeempat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      child: RaisedButton(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image(
                image: AssetImage(
                  "images/store.png",
                ),
                height: 100,
              ),
            ),
            Container(
              child: Text(
                "UMKM",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blue),
        ),
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return UmkmPage();
          }));
        },
      ),
    );
  }
}
