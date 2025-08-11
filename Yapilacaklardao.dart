import 'package:todolist_proje_uygulamasi/VeritabaniYardimcisi.dart';
import 'package:todolist_proje_uygulamasi/Yapilacaklar.dart';

class Yapilacaklardao{

  Future<List<Yapilacaklar>> tumYapilacaklariEkranaGetir() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String, dynamic>> maps = await db.rawQuery("SELECT * FROM liste");


    return List.generate(maps.length, (index) {
      var satir = maps[index];

      return Yapilacaklar(satir["todo_id"], satir["todo_ad"]);
    });

  }
  Future<void> veriEkle(String todo_ad) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    var bilgiler=Map<String,dynamic>();
    bilgiler["todo_ad"]=todo_ad;
    await db.insert("liste", bilgiler);
  }
  
  
  Future<void> veriSil(int todo_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    await db.delete("liste",where: "todo_id=?",whereArgs: [todo_id]);
  }
}