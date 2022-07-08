/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_shop/model/oggetti/Prodotto.dart';
import 'package:front_shop/Admin/ProdProv.dart';
import 'package:front_shop/model/support/Widget/MyButton.dart';
import 'package:provider/provider.dart';

class AggiungiProdDraw extends StatefulWidget {
  const AggiungiProdDraw({Key? key}) : super(key: key);

  @override
  State<AggiungiProdDraw> createState() => _AggiungiProdDrawState();
}

class _AggiungiProdDrawState extends State<AggiungiProdDraw> {
  late final Prodotto _nuovoProdotto = Prodotto.empty();
  Prodotto? _prodottoModificato;
  TextEditingController nomeController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController prezzoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _prodottoModificato=
          Provider.of<ProdProv>(context, listen: false).prodottoDaMod;
      if(_prodottoModificato!=null){
        nomeController=TextEditingController(text: _prodottoModificato!.nome);
        descController=TextEditingController(text: _prodottoModificato!.descrizione);
        imageController=TextEditingController(text: _prodottoModificato!.image);
        prezzoController=TextEditingController(text: _prodottoModificato!.prezzo.toString());
        setState((){});
      }
    });
  }//initState

  @override
  Widget build(BuildContext context){
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            Text(
              _prodottoModificato==null? 'Aggiungi Prodotto':'Modifica Prodotto',
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
              onChanged: (value) {
                if(_prodottoModificato==null){
                  _nuovoProdotto.nome=value;
                }else{
                  _prodottoModificato!.nome=value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: descController,
              decoration: const InputDecoration(labelText: "Descrizione"),
              maxLines: 5,
              onChanged: (value) {
                if(_prodottoModificato==null){
                  _nuovoProdotto.descrizione=value;
                }else{
                  _prodottoModificato!.descrizione=value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: "Link Immagine"),
              onChanged: (value) {
                if(_prodottoModificato==null){
                  _nuovoProdotto.image=value;
                }else{
                  _prodottoModificato!.image=value;
                }
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: prezzoController,
              decoration: const InputDecoration(labelText: "Prezzo \€"),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onChanged: (value) {
                if(_prodottoModificato==null){
                  _nuovoProdotto.prezzo=double.parse(value);
                }else{
                  _prodottoModificato!.prezzo=double.parse(value);
                }
              },
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MyButton(
                    text: _prodottoModificato==null?"Aggiungi Prodotto":"Modifica",
                    icon: _prodottoModificato==null?Icons.add:Icons.edit,
                    onPressed: () {
                      if(_prodottoModificato==null){
                        Provider.of<ProdProv>(context, listen: false).aggiungiProdotto(_nuovoProdotto);
                      }else{
                        Provider.of<ProdProv>(context, listen: false).modificaProdotto(_prodottoModificato!);
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                _prodottoModificato != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: MyButton(
                        text: "Elimina",
                        icon: Icons.delete,
                        color: Colors.red,
                        onPressed: () {
                          Provider.of<ProdProv>(context, listen: false).eliminaProdotto(_prodottoModificato!);
                          Navigator.of(context).pop();
                        },
                      ),
                    )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }//build

}

 */
