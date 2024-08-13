import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:intl/intl.dart';

class DescuentosPage extends StatefulWidget {
  const DescuentosPage({super.key, required this.title});
  final String title;

  @override
  State<DescuentosPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DescuentosPage> {
  //para controlar el texto de las cajas
  final textoCajaValor = TextEditingController();
  final textoCajaDescuento = TextEditingController();
  //variable global para el resultado
  String descuentoDetalle = '-';
  int descuentoDetalleValor = 0;
  var formatoDescuento =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});
  final formatoPrecioDescuento =
      NumberFormat.currency(locale: 'es_MX', symbol: "\$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            //Aqui va el resultado
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  descuentoDetalle,
                  style: TextStyle(color: Colors.green[900], fontSize: 18),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  formatoPrecioDescuento.format(descuentoDetalleValor),
                  style: TextStyle(color: Colors.red[600], fontSize: 22),
                ),
              ),
            ),
            const Text(
              'Ingrese el costo original del producto:',
            ),
            TextField(
              inputFormatters: [
                CurrencyInputFormatter(
                    leadingSymbol: CurrencySymbols.DOLLAR_SIGN)
              ],
              //se asigan el controlador
              controller: textoCajaValor,
              //acepta numeros solamente
              keyboardType: TextInputType.number,
              //se pone un borde en toda la caja
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const Text(
              'Ingrese el descuento a calcular:',
            ),
            TextField(
              inputFormatters: [formatoDescuento],
              controller: textoCajaDescuento,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            MaterialButton(
              onPressed: () {
                setState(() {
                  //variable local
                  double descuento = 0;
                  double valProducto = 0;
                  String textoCajaValorSinFormato;

                  //Se quitan simbolos
                  textoCajaValorSinFormato = textoCajaValor.text
                      .replaceAll('\$', '')
                      .replaceAll(',', '')
                      .replaceAll('.', '');
                  // se quitan los 2 ultimos numeros innecesarios
                  textoCajaValorSinFormato = textoCajaValorSinFormato.substring(
                      0, textoCajaValorSinFormato.length - 2);

                  if ((double.parse(textoCajaValorSinFormato) != 0) &&
                      (double.parse(textoCajaDescuento.text) != 0)) {
                    descuento = double.parse(textoCajaValorSinFormato) *
                        (double.parse(textoCajaDescuento.text) / 100);
                    valProducto =
                        double.parse(textoCajaValorSinFormato) - descuento;
                  }

                  descuentoDetalle = 'El valor del producto, aplicando el ' +
                      textoCajaDescuento.text +
                      '% de descuento es de: ';
                  descuentoDetalleValor = valProducto.toInt();
                });
              },
              color: Colors.green[100],
              child: const Text(
                'Calcular',
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
