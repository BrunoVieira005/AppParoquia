import 'package:flutter/material.dart';

class ContatosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contatos'),
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Remover a sombra da AppBar
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/fundo.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
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
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 100),
              SizedBox(height: 20),
              Text(
                'PARÓQUIA SANTA MONICA',
                style: TextStyle(
                  fontFamily: 'Castellar',
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC29A51),
                ),
              ),
              SizedBox(height: 20),

              // Card: Informações da Paróquia
              _buildInfoCard(
                title: 'Informações da Paróquia',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Endereço: R. Reynaldo Bolliger, 450 - Jardim Santa Monica, Campinas - SP, 13082-060, Brasil',
                    ),
                    SizedBox(height: 10),
                    Text('📞 Telefone | Whatsapp: \n+55 (19) 3246-3398'),
                    SizedBox(height: 10),
                    Text('✉️ E-mail: \nparoquiasantamonica@email.com'),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Card: Desenvolvedores
              _buildInfoCard(
                title: 'Desenvolvedores',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bruno Vieira'),
                    Text('brunov.2612@gmail.com'),
                    Text('www.linkedin.com/in/bruno-rvieira/'),

                    SizedBox(height: 10),
                    Text('Camila Tamires'),
                    Text('camilatg418@gmail.com'),
                    Text('www.linkedin.com/in/camilaramos-ti/'),

                    SizedBox(height: 10),
                    Text('Murilo Silva'),
                    Text('murilo.sxv@gmail.com'),
                    Text('www.linkedin.com/in/murilosxv/'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required Widget content}) {
    return Card(
      color: Color(0xFFC29A51),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 40, 27, 22),
              ),
            ),
            SizedBox(height: 10),
            DefaultTextStyle(
              style: TextStyle(
                color: Color.fromARGB(255, 97, 64, 2),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}
