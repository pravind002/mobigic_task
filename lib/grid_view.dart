
import 'package:flutter/material.dart';
import 'package:mobigic_task/grid_dimensions.dart';
import 'widgets/custom_widget.dart';

class GridScreen extends StatefulWidget {
  final int rowC;
  final int colC;
  final String characters;

  const GridScreen({
    Key? key,
    required this.rowC,
    required this.colC,
    required this.characters,
  }) : super(key: key);

  @override
  _GridScreenState createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController searchText = TextEditingController();
  final _form = GlobalKey<FormState>();

  List<int>? alphabetPositions;

  void matchText() {
    List<int> charactersNum = [];
    String? searchKey = searchText.text.toLowerCase();

    for (var i = 0; i < searchKey.length; i++) {
      if (widget.characters.contains(searchKey[i])) {
        charactersNum.add(widget.characters.indexOf(searchKey[i]) + 1);
      }
    }

    var reversedNumList = charactersNum;

    if (charactersNum[charactersNum.length - 1] > charactersNum[0]) {
      reversedNumList = charactersNum.reversed.toList();
    }

    List<int> diff = [];

    for (var i = 0; i < reversedNumList.length; i++) {
      if (i != reversedNumList.length - 1) {
        diff.add(reversedNumList[i] - reversedNumList[i + 1]);
      }
    }

    int countLR = 0;
    int countTB = 0;
    int countD = 0;
    int countDR = 0; // Diagonal Right
    int countDL = 0; // Diagonal Left

    for (var i = 0; i < diff.length; i++) {
      if (diff[i] == 1) countLR++;
      if (diff[i] == widget.colC) countTB++;
      if (diff[i] == widget.colC - 1) countD++;
      if (diff[i] == widget.colC + 1) countDR++;
      if (diff[i] == widget.colC - 1) countDL++;
    }

    if (countLR == searchKey.length - 1 ||
        countTB == searchKey.length - 1 ||
        countD == searchKey.length - 1 ||
        countDR == searchKey.length - 1 ||
        countDL == searchKey.length - 1) {
      setState(() {
        alphabetPositions = charactersNum;
      });
    } else {
      setState(() {
        alphabetPositions = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.greenAccent,
      iconTheme: const IconThemeData(color: Colors.white),
      centerTitle: true,
      title: const Text(
        'G R I D',
        style:
            TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const GridDimensions()),
            );
          },
          child: const Text(
            "Reset",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.35,
                child: GridView.builder(
                  itemCount: widget.characters.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.colC,
                    childAspectRatio: widget.colC * widget.rowC / widget.rowC,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: alphabetPositions != null &&
                              alphabetPositions!.contains(index + 1)
                          ? Colors.orange
                          : Colors.greenAccent.withOpacity(.5),
                    ),
                    child: Center(
                      child: Text(
                        widget.characters[index].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _form,
                child: TextFormField(
                  decoration: const InputDecoration(labelText: 'Search Word'),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  controller: searchText,
                  maxLength: widget.rowC * widget.colC,
                  validator: (searchText) {
                    if (searchText!.isEmpty) {
                      return 'Please provide search alphabets.';
                    }

                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  final isValid = _form.currentState!.validate();

                  if (!isValid) {
                    return;
                  }
                  matchText();
                },
                child: customButton('Search'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

