import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_task/grid_text.dart';
import 'package:mobigic_task/utils/custom_app_bar.dart';
import 'package:mobigic_task/widgets/custom_widget.dart';

class GridDimensions extends StatefulWidget {
  const GridDimensions({super.key});

  @override
  _GridDimensionsState createState() => _GridDimensionsState();
}

class _GridDimensionsState extends State<GridDimensions> {
  TextEditingController row = TextEditingController();
  TextEditingController column = TextEditingController();
  final _form = GlobalKey<FormState>();

  int rowC = 0;
  int colC = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'G R I D    D I M E N S I O N S'),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
            child: Form(
          key: _form,
          child: Column(
            children: [
              const Text(
                'Please Enter Grid Dimensions',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Enter number of Rows(Max-6)'),
                controller: row,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (row) {
                  if (row!.isEmpty) {
                    return 'Please provide a number.';
                  }
                  if (int.parse(row) > 6) {
                    return 'value should be 6 or less than 6';
                  }
                  if (int.parse(row) == 0) {
                    return 'value can not be zero';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Enter number of Columns(Max-4)'),
                controller: column,
                keyboardType: TextInputType.number,
                validator: (column) {
                  if (column!.isEmpty) {
                    return 'Please provide a number.';
                  }
                  if (int.parse(column) > 4) {
                    return 'value should be 4 or less than 4';
                  }
                  if (int.parse(column) == 0) {
                    return 'value can not be zero';
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
                    rowC = int.parse(row.text);
                    colC = int.parse(column.text);

                    setState(() {});
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => GridText(
                                row: rowC,
                                col: colC,
                              )),
                    );
                  },
                  child: customButton('Next')),
            ],
          ),
        )),
      ),
    );
  }
}
