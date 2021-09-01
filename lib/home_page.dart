import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _tipCalculation() {
    switch (selectedRadio) {
      case 0:
        tip = double.parse(tipController.text) * 0.20;
        break;
      case 1:
        tip = double.parse(tipController.text) * 0.18;
        break;
      default:
        tip = double.parse(tipController.text) * 0.15;
    }

    // Round up?
    tip = switchEnabled ? tip.ceil().toDouble() : tip;
  }

  bool switchEnabled = false;
  var tipController = TextEditingController();
  var radioGroupValues = {
    0: 'Amazing 20%',
    1: 'Good 18%',
    2: 'Okay 15%',
  };
  int selectedRadio = 0;
  double tip = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Cost of service',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          // Text("Aqui agregar el GRUPO de radio buttons"),
          Column(
            // Las columnas por default agarran todo el tamaño de la pantalla. Si no queremos eso hay que especificarlo.
            mainAxisSize: MainAxisSize.min,
            children: radioGroupValues.entries.map(
              (element) => ListTile(
                leading: Radio(value: element.key, groupValue: selectedRadio, onChanged: (currentSelectedRadio){
                  selectedRadio = currentSelectedRadio;
                  setState(() {
                    
                  });
                }),
                title: Text('${element.value}'),
              )).toList(),
          ),
          ListTile(
            // Se divide en 3 partes. Es como una fila pero que ya tiene componentes definidos. Leading(izquierda), title(centro) y trailing(derecha)
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
              value: switchEnabled,
              onChanged: (switchState){
                switchEnabled = switchState;
                setState(() {
                  // Solo es para cambiar el estado del switch.
                });
            }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(
                        color: Colors.grey[200],
                      ),
                      ),
                    onPressed: (){
                      setState(() {
                        _tipCalculation();
                      });
                    },
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 18, right: 12),
                child: Text('Tip amount: \$${tip.toStringAsFixed(2)}',),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
