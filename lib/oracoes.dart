import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OracoesPage extends StatefulWidget {
  @override
  _OracoesPageState createState() => _OracoesPageState();
}

class _OracoesPageState extends State<OracoesPage> {
  String versiculo = "Carregando...";

  // Mapeamento de livros em inglês para português
  final Map<String, String> livroTraduzido = {
    "Genesis": "Gênesis",
    "Exodus": "Êxodo",
    "Leviticus": "Levítico",
    "Numbers": "Números",
    "Deuteronomy": "Deuteronômio",
    "Joshua": "Josué",
    "Judges": "Juízes",
    "Ruth": "Rute",
    "1 Samuel": "1 Samuel",
    "2 Samuel": "2 Samuel",
    "1 Kings": "1 Reis",
    "2 Kings": "2 Reis",
    "1 Chronicles": "1 Crônicas",
    "2 Chronicles": "2 Crônicas",
    "Ezra": "Esdras",
    "Nehemiah": "Neemias",
    "Esther": "Ester",
    "Job": "Jó",
    "Psalms": "Salmos",
    "Proverbs": "Provérbios",
    "Ecclesiastes": "Eclesiastes",
    "Song of Solomon": "Cânticos",
    "Isaiah": "Isaías",
    "Jeremiah": "Jeremias",
    "Lamentations": "Lamentações",
    "Ezekiel": "Ezequiel",
    "Daniel": "Daniel",
    "Hosea": "Oséias",
    "Joel": "Joel",
    "Amos": "Amós",
    "Obadiah": "Obadias",
    "Jonah": "Jonas",
    "Micah": "Miquéias",
    "Nahum": "Naum",
    "Habakkuk": "Habacuque",
    "Zephaniah": "Sofonias",
    "Haggai": "Ageu",
    "Zechariah": "Zacarias",
    "Malachi": "Malaquias",
    "Matthew": "Mateus",
    "Mark": "Marcos",
    "Luke": "Lucas",
    "John": "João",
    "Acts": "Atos",
    "Romans": "Romanos",
    "1 Corinthians": "1 Coríntios",
    "2 Corinthians": "2 Coríntios",
    "Galatians": "Gálatas",
    "Ephesians": "Efésios",
    "Philippians": "Filipenses",
    "Colossians": "Colossenses",
    "1 Thessalonians": "1 Tessalonicenses",
    "2 Thessalonians": "2 Tessalonicenses",
    "1 Timothy": "1 Timóteo",
    "2 Timothy": "2 Timóteo",
    "Titus": "Tito",
    "Philemon": "Filemom",
    "Hebrews": "Hebreus",
    "James": "Tiago",
    "1 Peter": "1 Pedro",
    "2 Peter": "2 Pedro",
    "1 John": "1 João",
    "2 John": "2 João",
    "3 John": "3 João",
    "Jude": "Judas",
    "Revelation": "Apocalipse"
  };

  @override
  void initState() {
    super.initState();
    carregarVersiculo();
  }

  Future<void> carregarVersiculo() async {
    try {
      final response = await http.get(
        Uri.parse('https://labs.bible.org/api/?passage=random&type=json'),
      );

      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        final String book = data[0]['bookname'];
        final String chapter = data[0]['chapter'].toString();
        final String verse = data[0]['verse'].toString();

        final String? livroPT = livroTraduzido[book];

        if (livroPT == null) {
          setState(() {
            versiculo = "Livro '$book' não mapeado para português.";
          });
          return;
        }

        final bibleApiUrl =
            'https://bible-api.com/$livroPT $chapter:$verse?translation=almeida';
        final traducaoResponse = await http.get(Uri.parse(bibleApiUrl));

        if (traducaoResponse.statusCode == 200) {
          final traducao = json.decode(traducaoResponse.body);
          setState(() {
            versiculo =
                "${traducao['text'].trim()}\n\n(${traducao['reference']})";
          });
        } else {
          setState(() {
            versiculo =
                "Erro ao buscar tradução: ${traducaoResponse.statusCode}";
          });
        }
      } else {
        setState(() {
          versiculo = "Erro ao carregar versículo: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        versiculo = "Erro inesperado: $e";
      });
    }
  }

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
              SizedBox(height: 100),
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
              Text(
                'Versículo do Dia',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown,
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Color(0xFFC29A51),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    versiculo,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
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
