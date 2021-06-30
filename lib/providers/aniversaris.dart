import 'package:aniversaris/helpers/db_helper.dart';
import 'package:flutter/cupertino.dart';

import '../models/aniversari.dart';

class Aniversaris with ChangeNotifier {
  List<Aniversari> _aniversaris = [];

  List<Aniversari> get aniversaris {
    return [..._aniversaris];
  }

  Future<void> addAniversari(
    String nomEscollit,
    DateTime dataNaixementEscollida,
  ) async {
    final mapGuardar = {
      'nom': nomEscollit,
      'dataNaixement': dataNaixementEscollida.toIso8601String(),
    };
    await DBHelper.insert('aniversaris', mapGuardar).then((autogeneratedId) {
      final nouAniversari = Aniversari(
        id: autogeneratedId,
        nom: nomEscollit,
        dataNaixement: dataNaixementEscollida,
      );
      _aniversaris.add(nouAniversari);
    });

    notifyListeners();
  }
}
