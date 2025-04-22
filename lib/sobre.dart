import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 10),
              Text(
                'PARÓQUIA SANTA MONICA',
                style: TextStyle(
                  fontFamily: 'Castellar',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC29A51),
                ),
              ),
              SizedBox(height: 20),
              Card(
                color: Color(0xFFC29A51),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.church, color: Color(0xFF7B5101), size: 40),
                          SizedBox(width: 10),
                          Text(
                            'Nossa História',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'A Paróquia Santa Mônica foi criada no dia 04/01/2007. Durante anos, enquanto quase-paróquia, esteve aos cuidados dos padres Salesianos e depois de criada canonicamente foi entregue aos cuidados diocesanos. '
                        'A Paróquia tem como padroeira Santa Mônica, mãe do célebre Santo Agostinho. Mônica nasceu em Tagaste (África do Norte) no ano 332. Com seu esposo, Patrício, teve três filhos; dois homens e uma mulher. '
                        'Os dois menores foram sua alegria e consolo, mas o mais velho, Agostinho, a fez sofrer por dezenas de anos, até sua conversão. Sua festa é celebrada no dia 27 de agosto. '
                        'Nossa prioridade é Evangelizar! A Pastoral Litúrgica tem uma missão importante: celebrar o Cristo que vive e que se encontra no meio do povo, de maneira especial entre os humildes. '
                        'Justamente, por essa necessidade, foi criada também, a Comunidade Santa Rita de Cássia, a primeira comunidade da Paróquia. '
                        'Por ser jovem, a Paróquia Santa Mônica, enfrenta as dificuldades comuns de uma paróquia emergente. Possui um Conselho Pastoral renovado e participativo nas decisões; um Conselho Administrativo preocupado com as necessidades e desafios! '
                        'O Cemitério dos Amarais também está localizado na região paroquial: nele, realizamos celebrações no Dia das Mães, Dia dos Pais e principalmente no dia de Finados.',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
