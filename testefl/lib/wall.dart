import 'package:flutter/material.dart';

class wallProfile extends StatefulWidget {
  @override
  _wallProfileState createState() => _wallProfileState();
}

class _wallProfileState extends State<wallProfile> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  List device = [0];

  @override
  void initState() {
    super.initState();
    this._getData();
  }


  void _getData() async{
    if (Platform.isAndroid){
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      this.device.add(androidInfo.androidId);
      this.device.add(androidInfo.model);
      this.device.add(androidInfo.device);
      this.device.add(androidInfo.bootloader);
      this.device.add(androidInfo.brand);
      this.device.add(androidInfo.manufacturer);
      this.device.add(androidInfo.product);
      print(device);
    }
    if (Platform.isIOS){
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print(iosInfo.identifierForVendor);
      print(iosInfo.model);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 2000,
            color: Colors.black,
          ),
          Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width-50,
                          height: 200,
                          child: Stack(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.rtl,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(Icons.more_vert, color: Colors.grey),
                                    onPressed: (){
                                      return showDialog(
                                          context: context,
                                          builder: (context) {
                                        return AlertDialog(
                                          content: Container(
                                            width: MediaQuery.of(context).size.width,
                                            height: 150,
                                            child: Column(
                                              children: <Widget>[
                                                Text(
                                                    "Android ID: "+device[1]+"\n"+"Modelo: "+device[2]+"\n"+"Device: "+device[3]+"\n"+"bootLoader: "+device[4]+"\n"+"Brand: "+device[5]+"\n"+"Monafacturer: "+device[6]+"\n"+"Product: "+device[7]
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      );
                                    },
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.all(15),//alinhamento da imagem ícone do NOme user
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: BorderRadius.circular(90),
                                              ),
                                            ),
                                            Padding( //Padding da imagem do icone para o nome o usuário
                                              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text('Daniel B.'),
                                                  Text('15 minutos atrás')
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          color: Colors.yellow,
                          width: MediaQuery.of(context).size.width-50,
                          height: 150,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          color: Colors.yellow,
                          width: MediaQuery.of(context).size.width-50,
                          height: 150,
                        ),

                      ],
                    ),
                  ),
                )
              ),
            ],
          ),
          //App bar type
          Column(
            children: <Widget>[
              AppBar(
                title: Text(
                  "Mural do Daniel",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor:  Colors.transparent,
                elevation: 0.0,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: null,
                  ),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    onPressed: null,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
