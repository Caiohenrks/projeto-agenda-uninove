import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class Contato {
  String nome;
  String numeroTelefone;
  String? urlFoto;

  Contato(this.nome, this.numeroTelefone, {this.urlFoto});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Agenda UNI9',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaContatos(),
    );
  }
}

class ListaContatos extends StatefulWidget {
  @override
  _ListaContatosState createState() => _ListaContatosState();
}

class _ListaContatosState extends State<ListaContatos> {
  List<Contato> contatos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda - UNI9'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: contatos[index].urlFoto != null
                  ? NetworkImage(contatos[index].urlFoto!)
                  : AssetImage('assets/images/default_contact.png')
                      as ImageProvider<Object>?,
            ),
            title: Text(contatos[index].nome),
            subtitle: Text(contatos[index].numeroTelefone),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  contatos.removeAt(index);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaEditarContato(
                    contato: contatos[index],
                    aoSalvar: (contatoEditado) {
                      setState(() {
                        contatos[index] = contatoEditado;
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaAdicionarContato(
                aoSalvar: (novoContato) {
                  setState(() {
                    contatos.add(novoContato);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class TelaAdicionarContato extends StatefulWidget {
  final Function(Contato) aoSalvar;

  TelaAdicionarContato({required this.aoSalvar});

  @override
  _TelaAdicionarContatoState createState() => _TelaAdicionarContatoState();
}

class _TelaAdicionarContatoState extends State<TelaAdicionarContato> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController numeroTelefoneController = TextEditingController();
  String? urlFotoSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Contato'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: urlFotoSelecionada != null
                    ? NetworkImage(urlFotoSelecionada!)
                    : AssetImage('assets/images/default_contact.png')
                        as ImageProvider<Object>?,
                radius: 50,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Selecionar Foto'),
                onPressed: () async {
                  final imagem =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (imagem != null && imagem.path != null) {
                    setState(() {
                      urlFotoSelecionada = imagem.path;
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: numeroTelefoneController,
                decoration: InputDecoration(
                  labelText: 'Número de telefone',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: () {
                  String nome = nomeController.text;
                  String numeroTelefone = numeroTelefoneController.text;
                  Contato novoContato = Contato(nome, numeroTelefone,
                      urlFoto: urlFotoSelecionada);
                  widget.aoSalvar(novoContato);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaEditarContato extends StatefulWidget {
  final Contato contato;
  final Function(Contato) aoSalvar;

  TelaEditarContato({required this.contato, required this.aoSalvar});

  @override
  _TelaEditarContatoState createState() => _TelaEditarContatoState();
}

class _TelaEditarContatoState extends State<TelaEditarContato> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController numeroTelefoneController = TextEditingController();
  String? urlFotoSelecionada;

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.contato.nome;
    numeroTelefoneController.text = widget.contato.numeroTelefone;
    urlFotoSelecionada = widget.contato.urlFoto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Contato'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: urlFotoSelecionada != null
                    ? NetworkImage(urlFotoSelecionada!)
                    : AssetImage('assets/images/default_contact.png')
                        as ImageProvider<Object>?,
                radius: 50,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Selecionar Foto'),
                onPressed: () async {
                  final imagem =
                      await ImagePicker().getImage(source: ImageSource.gallery);
                  if (imagem != null && imagem.path != null) {
                    setState(() {
                      urlFotoSelecionada = imagem.path;
                    });
                  }
                },
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: nomeController,
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: numeroTelefoneController,
                decoration: InputDecoration(
                  labelText: 'Número de telefone',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                child: Text('Salvar'),
                onPressed: () {
                  String nome = nomeController.text;
                  String numeroTelefone = numeroTelefoneController.text;
                  Contato contatoEditado = Contato(nome, numeroTelefone,
                      urlFoto: urlFotoSelecionada);
                  widget.aoSalvar(contatoEditado);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
