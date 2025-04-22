import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  DateTime currentMonth = DateTime.now();
  late List<String> daysOfWeek;
  late List<String> daysInMonth;
  List<dynamic> eventosDoMes = [];
  Map<String, String> tipoPorData = {};

  @override
  void initState() {
    super.initState();
    daysOfWeek = ['D', 'S', 'T', 'Q', 'Q', 'S', 'S'];
    _generateDaysInMonth(currentMonth);
    _loadEventosDoMes();
  }

  void nextMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month + 1);
      _generateDaysInMonth(currentMonth);
      _loadEventosDoMes();
    });
  }

  void previousMonth() {
    setState(() {
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1);
      _generateDaysInMonth(currentMonth);
      _loadEventosDoMes();
    });
  }

  void _generateDaysInMonth(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    final lastDayOfMonth = DateTime(date.year, date.month + 1, 0);
    final numDays = lastDayOfMonth.day;
    final firstDayOffset = firstDayOfMonth.weekday;

    daysInMonth = List.generate(numDays, (index) {
      final day = index + 1;
      return (day < 10) ? '0$day' : '$day';
    });

    for (int i = 0; i < firstDayOffset % 7; i++) {
      daysInMonth.insert(0, '');
    }
  }

  Future<void> _loadEventosDoMes() async {
    final arquivos = [
      'assets/json/municipal2025.json',
      'assets/json/nacional2025.json',
      'assets/json/facultativo2025.json',
    ];

    final List<dynamic> todosEventos = [];
    tipoPorData.clear();

    for (var arquivo in arquivos) {
      final tipo = arquivo.contains('municipal')
          ? 'MUNICIPAL'
          : arquivo.contains('nacional')
              ? 'NACIONAL'
              : 'FACULTATIVO';

      final String conteudo = await rootBundle.loadString(arquivo);
      final List<dynamic> eventos = jsonDecode(conteudo);

      for (var evento in eventos) {
        final dataEvento = DateFormat('dd/MM/yyyy').parse(evento['data']);
        if (dataEvento.month == currentMonth.month &&
            dataEvento.year == currentMonth.year) {
          todosEventos.add(evento);
          tipoPorData[evento['data']] = tipo;
        }
      }
    }

    setState(() {
      eventosDoMes = todosEventos;
    });
  }

  Color? _corDoDia(String dia) {
    if (dia.isEmpty) return null;
    final data = DateFormat('dd/MM/yyyy')
        .format(DateTime(currentMonth.year, currentMonth.month, int.parse(dia)));

    if (data == DateFormat('dd/MM/yyyy').format(DateTime.now())) {
      return Colors.orangeAccent;
    }
    switch (tipoPorData[data]) {
      case 'MUNICIPAL':
        return Colors.lightBlueAccent;
      case 'NACIONAL':
        return const Color.fromARGB(255, 160, 203, 165);
      case 'FACULTATIVO':
        return const Color.fromARGB(255, 209, 179, 214);
      default:
        return null;
    }
  }

  Widget _buildLegenda(Color cor, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          margin: EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: cor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final String monthYear = DateFormat.yMMMM('pt_BR').format(currentMonth);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.brown),
          onPressed: () {},
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fundo.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60),
              Image.asset('assets/images/logo.png', height: 100),
              Text(
                'PARÓQUIA SANTA MONICA',
                style: TextStyle(
                  fontFamily: 'Castellar',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC29A51),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Calendário Litúrgico',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left, color: Colors.brown),
                    onPressed: previousMonth,
                  ),
                  Text(
                    monthYear.toUpperCase(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right, color: Colors.brown),
                    onPressed: nextMonth,
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: daysOfWeek.map((day) {
                        return Expanded(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.brown,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 7,
                        childAspectRatio: 1.0,
                      ),
                      itemCount: daysInMonth.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final day = daysInMonth[index];
                        return Container(
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: _corDoDia(day),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              day,
                              style: TextStyle(
                                fontSize: 18,
                                color: day.isEmpty ? Colors.transparent : Colors.brown,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegenda(Colors.lightBlueAccent, 'Municipal '),
                    _buildLegenda(const Color.fromARGB(255, 160, 203, 165), 'Nacional '),
                    _buildLegenda(const Color.fromARGB(255, 220, 194, 224), 'Facultativo '),
                    _buildLegenda(Colors.orangeAccent, 'Hoje'),
                  ],
                ),
              ),
              SizedBox(height: 10),
              ...eventosDoMes.map((evento) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 4.0),
                    child: Card(
                      color: Colors.white.withOpacity(0.95),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(
                          evento['nome'],
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown),
                        ),
                        subtitle: Text(evento['descricao'] ?? ''),
                        trailing: Text(
                          evento['data'],
                          style: TextStyle(color: Colors.brown),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
