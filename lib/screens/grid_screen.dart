import 'package:flutter/material.dart';
import 'package:mobilogic_test/models/alpha_model.dart';
import 'package:mobilogic_test/models/grid_model.dart';

class GridScreen extends StatefulWidget {
  final GridModel gridModel;
  const GridScreen({Key? key, required this.gridModel}) : super(key: key);

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final TextEditingController _controller = TextEditingController();
  List<AlphaModel> _str = [];

  @override
  void initState() {
    for (String element in (widget.gridModel.alphabets?.split("") ?? [])) {
      _str.add(AlphaModel(char: element, isSelected: false));
    }
    String text1 = '';
    _controller.addListener(
          () {
        text1 = _controller.text;
        var searched = _str.map((e) {
          if (text1.contains(e.char)) {
            e.isSelected = true;
          } else {
            e.isSelected = false;
          }
          return e;
        }).toList();
        setState(() => _str = searched);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: widget.gridModel.columns ?? 0,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: _str.map(_validator).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.teal[500],
                child: TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyle(
                      color: Colors.white30,
                    ),
                  ),
                  controller: _controller,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _validator(AlphaModel alphabetModel) {
    return Container(
      color: alphabetModel.isSelected
          ? Colors.teal
          : Colors.teal.withOpacity(0.15),
      child: Center(
        child: Text(
          alphabetModel.char,
          style: TextStyle(
            color: alphabetModel.isSelected
                ? Colors.black
                : Colors.black.withOpacity(0.3),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

}