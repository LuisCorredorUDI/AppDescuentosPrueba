import 'package:flutter/material.dart';

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
            //Aqui a el resultado
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
                  '\$' + descuentoDetalleValor.toString(),
                  style: TextStyle(color: Colors.red[600], fontSize: 22),
                ),
              ),
            ),
            const Text(
              'Ingrese el costo original del producto:',
            ),
            TextField(
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
                  if ((double.parse(textoCajaValor.text) != 0) &&
                      (double.parse(textoCajaDescuento.text) != 0)) {
                    descuento = double.parse(textoCajaValor.text) *
                        (double.parse(textoCajaDescuento.text) / 100);
                    valProducto = double.parse(textoCajaValor.text) - descuento;
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
