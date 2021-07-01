import 'package:aniversaris/helpers/db_helper.dart';
import 'package:aniversaris/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';

import '../models/aniversari.dart';

class Aniversaris with ChangeNotifier {
  List<Aniversari> _aniversaris = [];

  List<Aniversari> get aniversaris {
    _aniversaris.sort(
      (a, b) => a.id.compareTo(b.id),
    );
    return [..._aniversaris];
  }

  List<Aniversari> aniversarisOrdenados(orderAniversariBy orden) {
    switch (orden) {
      case orderAniversariBy.id:
        {
          _aniversaris.sort((a, b) => a.id.compareTo(b.id));
        }
        break;
      case orderAniversariBy.nom:
        {
          _aniversaris.sort(
              (a, b) => a.nom.toLowerCase().compareTo(b.nom.toLowerCase()));
        }
        break;
      case orderAniversariBy.cognom1:
        {
          _aniversaris.sort((a, b) =>
              a.cognom1.toLowerCase().compareTo(b.cognom1.toLowerCase()));
        }
        break;
      case orderAniversariBy.cognom2:
        {
          _aniversaris.sort((a, b) =>
              a.cognom2.toLowerCase().compareTo(b.cognom2.toLowerCase()));
        }
        break;
      case orderAniversariBy.data:
        {
          _aniversaris
              .sort((a, b) => a.dataNaixement.compareTo(b.dataNaixement));
        }
        break;
      case orderAniversariBy.mes:
        {
          _aniversaris.sort(
              (a, b) => a.dataNaixement.month.compareTo(b.dataNaixement.month));
        }
        break;
      default:
        {
          _aniversaris.sort((a, b) => a.id.compareTo(b.id));
        }
    }
    return [..._aniversaris];
  }

  Future<void> addAniversari(
    String nomEscollit,
    String cognom1Escollit,
    String cognom2Escollit,
    DateTime dataNaixementEscollida,
  ) async {
    final mapGuardar = {
      'nom': nomEscollit,
      'cognom1': cognom1Escollit,
      'cognom2': cognom2Escollit,
      'dataNaixement': dataNaixementEscollida.toIso8601String(),
    };
    //print(mapGuardar);
    await DBHelper.insert('aniversaris', mapGuardar).then((autogeneratedId) {
      final nouAniversari = Aniversari(
        id: autogeneratedId,
        nom: nomEscollit,
        cognom1: cognom1Escollit,
        cognom2: cognom2Escollit,
        dataNaixement: dataNaixementEscollida,
      );
      _aniversaris.add(nouAniversari);
    });

    notifyListeners();
  }

  Future<void> fetchAndSetAniversaris(orderAniversariBy orden) async {
    final dataList = await DBHelper.getData('aniversaris');
    _aniversaris = dataList.map(
      (item) {
        //print(item);
        return Aniversari(
          id: item['id'],
          nom: item['nom'],
          cognom1: item['cognom1'],
          cognom2: item['cognom2'],
          dataNaixement: DateTime.parse(item['dataNaixement']),
        );
      },
    ).toList();
    notifyListeners();
  }
}
