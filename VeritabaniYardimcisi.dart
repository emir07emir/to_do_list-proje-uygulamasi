import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeritabaniYardimcisi{

  static final String veritabaniAdi="liste.sqlite";

  static Future<Database> veritabaniErisim() async{
    String veritabaniYolu=join(await getDatabasesPath(),veritabaniAdi);//join databasenin kurulu olduğu uzantıyla veritabanı adını birleştirir örnek c:users/dosyalar/rehber.sqlite gibi

    if(await databaseExists(veritabaniYolu))//database varsa alttakı yazı yoksa else e geçiyor
        {
      print("VeriTabanı zaten var kopyalamaya gerek yok");
    }
    else
    {
      ByteData data= await rootBundle.load("veritabani/$veritabaniAdi");//Uygulamanın assets klasöründeki veritabanı dosyasını okur.(rootBundle.load)
      List<int> bytes=data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);//offsetInBytes: dönüştürmeye nereden başlayacağını belirler, lengthInBytes: boyutunu belirledik
      //asUint8List: Veritabanı dosyasını byte dizisine çevirir.
      await File(veritabaniYolu).writeAsBytes(bytes,flush: true);// Yazma işleminin garanti edilmesini sağlar, yani dosya tamamen yazılmadan işlem tamamlanmaz.
      print("Veritabanı kopyalandı");
    }

    return openDatabase(veritabaniYolu);


  }



}