import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolist_proje_uygulamasi/Yapilacaklar.dart';
import 'package:todolist_proje_uygulamasi/Yapilacaklardao.dart';





void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,secondary: Colors.deepOrange),
          useMaterial3:true,
        ),
        home: Anasayfa()
    );
  }
}

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}




class _AnasayfaState extends State<Anasayfa> {



  var tfcontrol=TextEditingController();
  final scaffoldDurum=GlobalKey<ScaffoldState>();
  bool gorunuyorMu=false;
  List<Yapilacaklar> tumtodolistesi=[];


  Future<void>ekranaGetir() async{
    var list= await Yapilacaklardao().tumYapilacaklariEkranaGetir();
    setState(() {
      tumtodolistesi=list;
    });

    }
  Future<void>konsolaYazdir() async{
    var list= await Yapilacaklardao().tumYapilacaklariEkranaGetir();
    for(Yapilacaklar k in list){
      print("***************");
      print("todo_id: ${k.todo_id}");
      print("todo_ad: ${k.todo_ad}");
    }

  }
  Future<void>veriEkle() async{
   await Yapilacaklardao().veriEkle(tfcontrol.text);

  }

  Future<void>veriSil(int id) async{
    await Yapilacaklardao().veriSil(id);

  }

    @override
  void initState() {
    super.initState();
    ekranaGetir();
  }



  @override
  Widget build(BuildContext context) {
    DateTime now=DateTime.now();
    String guncelTarih="${now.day}/${now.month}/${now.year}";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF174513),
          centerTitle: true,
          title: Text("TODO SAYFASI",style: TextStyle(color: Colors.white),),
        ),

        body:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50,left: 8.0,right: 8.0),
                child: TextField(
                  controller: tfcontrol,
                  decoration: InputDecoration(
                    label: Text("Yazınız",style: TextStyle(fontSize: 20),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45,width: 1.5)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Color(0xff5A1717),width: 3)
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children: [
                      ElevatedButton(
                        child: Text("Ekle",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        onPressed: (){
                          if(tfcontrol.text==""){
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Alan boş bırakılamaz"),
                              duration: Duration(seconds: 3),
                            ));
                          }else{
                            setState(() {
                              veriEkle();
                              tfcontrol.text="";
                              ekranaGetir();
                            });
                          }  
                          },
                          
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                            shadowColor: Color(0xff042bec),
                          foregroundColor: Color(0xffebfaf7),
                          backgroundColor: Colors.black
                        ),
                      ),
                      ElevatedButton(
                        child: Text("Veri Göster",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        onPressed: () async{
                          await ekranaGetir();
                          setState(() {
                            gorunuyorMu=true;
                            ekranaGetir();
                          });



                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 7,
                          shadowColor: Color(0xff068f1f),
                            foregroundColor: Color(0xffebfaf7),
                            backgroundColor: Colors.black,
                        ),
                      ),
                      ElevatedButton(
                        child: Text("Veri Gizle",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                        onPressed: () async{

                          setState(() {
                            gorunuyorMu=false;
                          });

                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 7,
                            shadowColor: Color(0xffec0404),
                            foregroundColor: Color(0xffebfaf7),
                            backgroundColor: Colors.black
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
                  visible: gorunuyorMu,
                  child: Text("YAPILACAKLAR LİSTESİ -- ${guncelTarih}",style:
                  TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      shadows: [Shadow(
                        //offset: Offset(2, 2) 3D şekilde harflerin kayması
                        //blurRadius: 4, bulanıklık ekliyor
                        color: Colors.red
                      )],
                  )),
                ),
              ),
              Visibility(
                visible: gorunuyorMu,
                child: Expanded(//expanded kullanmak zorundayız
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ListView.builder(
                      itemCount: tumtodolistesi.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  tumtodolistesi[index].todo_ad,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff0B9868),
                                  ),
                                ),
                                PopupMenuButton(
                                  child: Icon(
                                    Icons.more_vert_sharp,
                                    color: Colors.grey[700],
                                  ),
                                  onSelected: (value) {
                                    if (value == 1) {
                                      veriSil(tumtodolistesi[index].todo_id);
                                      setState(() {
                                        ekranaGetir();
                                      });
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    PopupMenuItem(
                                      value: 1,
                                      child: Text(
                                        "Sil",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )

                ),
              ),
            ],

          ),
        )

    );
  }
}
