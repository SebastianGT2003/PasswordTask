import 'dart:math';

import 'package:flutter/material.dart';
import 'package:passwordtask/controller/passwordController.dart';

class formfield extends StatefulWidget {
  @override
  State<formfield> createState() => _formfieldState();
}

class _formfieldState extends State<formfield> {
  passwordController? _controller;
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = passwordController();
  }

  TextEditingController _controllerPassword = TextEditingController();
  String password = "";

//////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controllerPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contraseña',
              suffixIcon: IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    bool minusculas =
                        _controller!.values?["minusculas"] as bool;
                    bool mayusculas =
                        _controller!.values?["mayusculas"] as bool;
                    bool numeros = _controller!.values?["numeros"] as bool;
                    bool simbolos = _controller!.values?["simbolos"] as bool;

                    password = generarContrasena(
                        25, minusculas, mayusculas, numeros, simbolos);
                    _controllerPassword.text = password;
                  });
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Checkbox()
        ],
      ),
    );
  }

  Column Checkbox() {
    return Column(children: [
      CheckboxListTile(
        title: const Text("Mayusculas"),
        value: _controller!.values?["mayusculas"] as bool,
        onChanged: (newValue) {
          _controller!.values?["mayusculas"] = newValue as bool;
          setState(() {});
        },
        controlAffinity:
            ListTileControlAffinity.leading, // Checkbox a la izquierda
      ),
      CheckboxListTile(
        title: const Text("Minisculas"),
        value: _controller!.values?["minusculas"] as bool,
        onChanged: (newValue) {
          _controller!.values?["minusculas"] = newValue as bool;
          setState(() {});
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
      CheckboxListTile(
        title: const Text("Numeros"),
        value: _controller!.values?["numeros"] as bool,
        enabled: _controller!.values?["enableNumber"] as bool,
        onChanged: (newValue) {
          _controller!.values?["numeros"] = newValue as bool;
          setState(() {});
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
      CheckboxListTile(
        title: const Text("Simbolos"),
        value: _controller!.values?["simbolos"] as bool,
        enabled: _controller!.values?["enableSimbol"] as bool,
        onChanged: (newValue) {
          _controller!.values?["simbolos"] = newValue as bool;
          setState(() {});
        },
        controlAffinity: ListTileControlAffinity.leading,
      ),
      radiosButton()
    ]);
  }

  Column radiosButton() {
    return Column(
      children: [
        RadioListTile(
          title: const Text("Facil de leer"),
          value: 'facil',
          groupValue: _controller!.values?["okey"],
          onChanged: (newValue) {
            _controller!.values?["okey"] = newValue!;
            _controller!.values?["mayusculas"] = true;
            _controller!.values?["minusculas"] = true;
            _controller!.values?["enableNumber"] = false;
            _controller!.values?["enableSimbol"] = false;
            _controller!.values?["simbolos"] = false;
            _controller!.values?["numeros"] = false;

            setState(() {});
          },
        ),
        RadioListTile(
          title: const Text("Todos los caracteres"),
          value: 'todos',
          groupValue: _controller!.values?["okey"],
          onChanged: (newValue) {
            _controller!.values?["okey"] = newValue!;
            _controller!.values?["mayusculas"] = true;
            _controller!.values?['minusculas'] = true;
            _controller!.values?["numeros"] = true;
            _controller!.values?["simbolos"] = true;
            _controller!.values?["enableNumber"] = true;
            _controller!.values?["enableSimbol"] = true;
            setState(() {});
          },
        ),
      ],
    );
  }
}

String generarContrasena(int longitud, bool minusculasP, bool mayusculasP,
    bool numerosP, bool simbolosP) {
  final todosCaracteres =
      'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*';
  final numeros = '0123456789';
  final mayusculas = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final minusculas = 'abcdefghijklmnopqrstuvwxyz';
  final simbolos = '!@#%^&*';
  Random random = Random();
  int caracteresPosibles = 0;
  String contrasena = '';
  if (minusculasP) caracteresPosibles++;
  if (mayusculasP) caracteresPosibles++;
  if (numerosP) caracteresPosibles++;
  if (simbolosP) caracteresPosibles++;

  if (caracteresPosibles == 0) {
    return '';
  }
  for (int i = 0; i < longitud; i++) {
    int tipoCaracter = random.nextInt(caracteresPosibles);

    if (minusculasP && tipoCaracter-- == 0) {
      contrasena += minusculas[random.nextInt(minusculas.length)];
    } else if (mayusculasP && tipoCaracter-- == 0) {
      contrasena += mayusculas[random.nextInt(mayusculas.length)];
    } else if (numerosP && tipoCaracter-- == 0) {
      contrasena += numeros[random.nextInt(numeros.length)];
    } else if (simbolosP && tipoCaracter-- == 0) {
      contrasena += simbolos[random.nextInt(simbolos.length)];
    } else {}
  }

  return contrasena;
}
