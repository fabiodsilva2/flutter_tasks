import 'package:curso_flutter/data/task_dao.dart';
import 'package:flutter/material.dart';

import 'difficulty.dart';

class Task extends StatefulWidget {
  final String nome;
  final String foto;
  final int dificuldade;

  Task(this.nome, this.foto, this.dificuldade, {super.key});

  int nivel = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool assetOrNetwork() {
    if (widget.foto.contains('http')) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4), color: Colors.blue),
            height: 140,
          ),
          Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white),
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.black26),
                        width: 72,
                        height: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: assetOrNetwork()
                              ? Image.asset(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  widget.foto,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Text(
                                widget.nome,
                                style: const TextStyle(
                                    fontSize: 24,
                                    overflow: TextOverflow.ellipsis),
                              )),
                          Difficulty(
                            difficultyLevel: widget.dificuldade,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 52,
                        width: 52,
                        child: ElevatedButton(
                            onLongPress: () async {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        'Tem certeza que deseja excluir a tarefa?'),
                                    actions: <Widget>[
                                      TextButton(

                                        onPressed: () =>
                                            //print('não'),
                                            Navigator.of(context).pop(),
                                        child: const Text('Não'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          await TaskDao().delete(widget.nome);
                                          setState(() {});
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Sim'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            onPressed: () {
                              setState(() {
                                widget.nivel++;
                              });

                              //print(nivel);
                            },
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(Icons.arrow_drop_up),
                                Text(
                                  'UP',
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            )),
                      )
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        value: (widget.dificuldade > 0)
                            ? (widget.nivel / widget.dificuldade) / 10
                            : 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      'Nível: ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
