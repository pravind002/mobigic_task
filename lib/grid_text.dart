import 'package:flutter/material.dart';
import 'package:mobigic_task/grid_view.dart';
import 'package:mobigic_task/utils/custom_app_bar.dart';
import 'widgets/custom_widget.dart';

class GridText extends StatefulWidget {
  final int row;
  final int col;
  const GridText({super.key, required this.row, required this.col});

  @override
  _GridTextState createState() => _GridTextState();
}

class _GridTextState extends State<GridText> {
  TextEditingController characters = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'G R I D   A L P H A B E T S'),
      //  AppBar(
      //   title: const Text('Grid Alphabets'),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Form(
          key: _form,
          child: ListView(
            children: [
              Text(
                'Please Enter ${widget.row * widget.col} Alphabets for build Grid',
                textAlign: TextAlign.center,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Enter alphabets'),
                style: const TextStyle(fontWeight: FontWeight.bold),
                controller: characters,
                maxLength: widget.row * widget.col,
                validator: (characters) {
                  if (characters!.isEmpty) {
                    return 'Please provide value.';
                  }
                  if (characters.length != widget.row * widget.col) {
                    return 'Length should be ${widget.row * widget.col}';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    final isValid = _form.currentState!.validate();

                    if (!isValid) {
                      return;
                    }

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => GridScreen(
                                rowC: widget.row,
                                colC: widget.col,
                                characters: characters.text,
                              )),
                    );
                  },
                  child: customButton('Next'))
            ],
          ),
        )),
      ),
    );
  }
}
