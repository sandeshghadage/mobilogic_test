import 'package:flutter/material.dart';
import '../models/grid_model.dart';
import 'grid_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _rowsController = TextEditingController();
  final TextEditingController _columnController = TextEditingController();
  final TextEditingController _alphaController = TextEditingController();
  final GridModel _gridModel = GridModel();
  bool _isEnable = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Rows',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        TextField(
                          onChanged: (value) => _validator(),
                          controller: _rowsController,
                          //scrollPadding: EdgeInsets.only(bottom:100.0),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Columns',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        TextField(
                          onChanged: (value) => _validator(),
                          controller: _columnController,
                          //scrollPadding: EdgeInsets.only(bottom:100.0),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                          ),
                          cursorColor: Colors.white,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Enter Alphabets',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                          TextField(
                            onChanged: (value) => _validator(),
                            controller: _alphaController,
                            //scrollPadding: EdgeInsets.only(bottom:100.0),
                            decoration: const InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                            ),
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: _isEnable
                          ? MaterialStateProperty.all(Colors.teal)
                          : MaterialStateProperty.all(Colors.teal[100]),
                    ),
                    onPressed: () {
                      if (_isEnable) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GridScreen(
                              gridModel: _gridModel,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Create Grid',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validator() {
    if (_rowsController.text.isEmpty ||
        _columnController.text.isEmpty ||
        _alphaController.text.isEmpty) {
      setState(() => _isEnable = false);
      return;
    }

    int row = int.tryParse(_rowsController.text) ?? 0;
    int column = int.tryParse(_columnController.text) ?? 0;

    if (_alphaController.text.length != (row * column)) {
      setState(() => _isEnable = false);
      return;
    }

    if (_alphaController.text.contains(" ")) {
      _alphaController.text = _alphaController.text.replaceAll(" ", "");
      _alphaController.selection = TextSelection.fromPosition(
          TextPosition(offset: _alphaController.text.length));
    }

    setState(() => _isEnable = true);
    _gridModel.rows = row;
    _gridModel.columns = column;
    _gridModel.alphabets = _alphaController.text;
  }
}
