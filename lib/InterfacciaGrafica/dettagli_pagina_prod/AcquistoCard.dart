import 'package:flutter/material.dart';
import 'package:front_shop/model/oggetti/Acquisto.dart';

class AcquistoCard extends StatefulWidget {
  const AcquistoCard({Key? key, required this.acquisto}) : super(key: key);
  final Acquisto acquisto;
  @override
  State<AcquistoCard> createState() => _AcquistoCardState();
}

class _AcquistoCardState extends State<AcquistoCard> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    print("AcquistoCardState");
    return Stack(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orangeAccent,
              boxShadow: [
                BoxShadow(
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                    offset: Offset(0, 10),
                    blurRadius: 20)
              ]),
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius:BorderRadius.only(topLeft: Radius.circular(16),bottomLeft: Radius.circular(16)),
                    child:Container(
                      width: 300,
                      height: 300,
                      child: Image.network(widget.acquisto.prodotto_a.image),
                    ),),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Prodotto",),
                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.acquisto.prodotto_a.nome}",),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text("${widget.acquisto.prodotto_a.prezzo}€",),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Column(
                  children: [
                    Text("Quantità",),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text("${widget.acquisto.quantita}",),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Pagato",),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text("${widget.acquisto.quantita*widget.acquisto.prodotto_a.prezzo}€",),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Data",),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Text(formatData(widget.acquisto.dataAcquisto.toString())),),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }//build

  String formatData(String data){
    List<String> ymd=data.split(" ")[0].split("-");
    print(ymd);
    String res="";
    res+=ymd[2]+"-";
    res+=ymd[1]+"-";
    res+=ymd[0];
    print("res: "+res);
    return res;
  }

}
