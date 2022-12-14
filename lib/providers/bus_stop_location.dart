import 'package:flutter/material.dart';

class BusStopLocation with ChangeNotifier {
  final List<Map> _locations = [
    {
      "id": 1,
      "address": "Koteshwor Bus Stop",
      "latitude": 27.6798605245896,
      "longitude": 85.3494035566909
    },
    {
      "id": 2,
      "address": "Balkumari Bus Stop",
      "latitude": 27.6728968589586,
      "longitude": 85.3413558343367
    },
    {
      "id": 3,
      "address": "Khari Ko Bot",
      "latitude": 27.6695162348009,
      "longitude": 85.3363341495496
    },
    {
      "id": 4,
      "address": "Gwarko Bus Stop",
      "latitude": 27.6666041990882,
      "longitude": 85.3319100367766
    },
    {
      "id": 5,
      "address": "B And B",
      "latitude": 27.6661451,
      "longitude": 85.3308219
    },
    {
      "id": 6,
      "address": "Bodhigram Bus Stop",
      "latitude": 27.6609588462165,
      "longitude": 85.3272068137403
    },
    {
      "id": 7,
      "address": "Satdobato Bus Stop",
      "latitude": 27.6590753500787,
      "longitude": 85.3248821671983
    },
    {
      "id": 8,
      "address": "Satdobato Bus Stop",
      "latitude": 27.6586819608226,
      "longitude": 85.3241486835878
    },
    {
      "id": 9,
      "address": "Chakrapath Bus Stop",
      "latitude": 27.6580436040866,
      "longitude": 85.3237470348444
    },
    {
      "id": 10,
      "address": "Talchikhela Choke",
      "latitude": 27.6579240260889,
      "longitude": 85.3225273266858
    },
    {
      "id": 11,
      "address": "JRC Chowk Bus Stop",
      "latitude": 27.6590947959865,
      "longitude": 85.3208635281757
    },
    {
      "id": 12,
      "address": "Mahalaxmisthan Chowk",
      "latitude": 27.6617540800029,
      "longitude": 85.3181909595773
    },
    {
      "id": 13,
      "address": "Thasikhel Chowk",
      "latitude": 27.6638900067431,
      "longitude": 85.3149007509163
    },
    {
      "id": 14,
      "address": "Kusunti Bus Stop",
      "latitude": 27.665365733135,
      "longitude": 85.3124129795437
    },
    {
      "id": 15,
      "address": "Ekantakuna Bus Station",
      "latitude": 27.6671042261907,
      "longitude": 85.3081038710953
    },
    {
      "id": 16,
      "address": "Dhobighat Bus Stop",
      "latitude": 27.6749969429545,
      "longitude": 85.3023297991198
    },
    {
      "id": 17,
      "address": "Sanepa Bus Stop",
      "latitude": 27.6843134970861,
      "longitude": 85.3015217677371
    },
    {
      "id": 18,
      "address": "Balkhu Bus Stop",
      "latitude": 27.6847559353449,
      "longitude": 85.2976424730417
    },
    {
      "id": 19,
      "address": "Kalanki Bus Stop",
      "latitude": 27.6945162195328,
      "longitude": 85.28146253069
    },
    {
      "id": 20,
      "address": "Sitapaila Bus Stop",
      "latitude": 27.7078207893713,
      "longitude": 85.2824709245443
    },
    {
      "id": 21,
      "address": "Swayambhunath Bus Stop",
      "latitude": 27.7160227749464,
      "longitude": 85.2835400303772
    },
    {
      "id": 22,
      "address": "Thulo Bharyang Bus  Stop",
      "latitude": 27.719655554971,
      "longitude": 85.2867550071243
    },
    {
      "id": 23,
      "address": "Sano Bharyang Bus Stop",
      "latitude": 27.7208220782141,
      "longitude": 85.289235751028
    },
    {
      "id": 24,
      "address": "Dhungedhara Bus Stop",
      "latitude": 27.7233824606722,
      "longitude": 85.2946557458332
    },
    {
      "id": 25,
      "address": "Banasthali Chowk",
      "latitude": 27.7249784098851,
      "longitude": 85.297919191683
    },
    {
      "id": 26,
      "address": "Balaju Chowk",
      "latitude": 27.727370707132,
      "longitude": 85.3047845415237
    },
    {
      "id": 27,
      "address": "Machha Pokhari",
      "latitude": 27.7350923432999,
      "longitude": 85.305607916312
    },
    {
      "id": 28,
      "address": "Gongabu Bus Stop",
      "latitude": 27.7350475384409,
      "longitude": 85.3145981398431
    },
    {
      "id": 29,
      "address": "Samakhusi Chowk Bus Stop",
      "latitude": 27.7352039677041,
      "longitude": 85.3183100026393
    },
    {
      "id": 30,
      "address": "Taalim Kendra Bus Stop",
      "latitude": 27.7385260066945,
      "longitude": 85.3257544182211
    },
    {
      "id": 31,
      "address": "Basundhara Chowk Bus Stop",
      "latitude": 27.7422024187004,
      "longitude": 85.3325436481297
    },
    {
      "id": 32,
      "address": "Narayan Gopal Chowk Bus Stop",
      "latitude": 27.7399640384181,
      "longitude": 85.3372380120109
    },
    {
      "id": 33,
      "address": "Chapal Karkhana Bus Stop",
      "latitude": 27.734955356927,
      "longitude": 85.3423343511226
    },
    {
      "id": 34,
      "address": "Dhumbarahi",
      "latitude": 27.7318661633805,
      "longitude": 85.3443264709615
    },
    {
      "id": 35,
      "address": "Sukedhara Bus Stop",
      "latitude": 27.727818398087,
      "longitude": 85.3456822881032
    },
    {
      "id": 36,
      "address": "Gopikrishna",
      "latitude": 27.7216359473363,
      "longitude": 85.3456350201809
    },
    {
      "id": 37,
      "address": "Chabahil",
      "latitude": 27.717644249634,
      "longitude": 85.3465586212818
    },
    {
      "id": 38,
      "address": "Mitrapark",
      "latitude": 27.713123136781,
      "longitude": 85.345497988755
    },
    {
      "id": 39,
      "address": "Jay Bijeshwori",
      "latitude": 27.7103804212202,
      "longitude": 85.3442050613707
    },
    {
      "id": 40,
      "address": "Gaushala",
      "latitude": 27.7074655060081,
      "longitude": 85.3439897378612
    },
    {
      "id": 41,
      "address": "Tilganga Bus Stop",
      "latitude": 27.7062009245992,
      "longitude": 85.3494869813888
    },
    {
      "id": 42,
      "address": "Airport Bus Stop",
      "latitude": 27.700376946417,
      "longitude": 85.3540319393646
    },
    {
      "id": 43,
      "address": "Sinamangal Bus Stop",
      "latitude": 27.694948186201,
      "longitude": 85.3548806910697
    },
    {
      "id": 44,
      "address": "Tinkune Bus Stop",
      "latitude": 27.6875993915326,
      "longitude": 85.3507724251575
    },
    { 
      "id": 45,
      "address": "Koteshwore Bus Stand",
      "latitude": 27.6790049105266,
      "longitude": 85.34972579884
    },
    {
      "id": 46,
      "address": "Soaltee Dobato Chowk",
      "latitude": 27.6765254261313,
      "longitude": 85.3460958782904
    }
  ];

  

  List get locations {
    return [..._locations];
  }

  void addLocation() {
    //_locations.add(value);
    notifyListeners();
  }
}
