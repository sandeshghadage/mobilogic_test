import 'package:flutter/material.dart';
import 'package:searchfield/searchfield.dart';
import '../models/alphabet_model.dart';
import '../models/grid_model.dart';

class GridScreen extends StatefulWidget {
  final GridModel gridModel;

  const GridScreen({Key? key, required this.gridModel}) : super(key: key);

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<AlphabetModel> _alphabets = [];
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    for (String element in (widget.gridModel.alphabets?.split("") ?? [])) {
      _alphabets.add(AlphabetModel(char: element, isSelected: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: GridView.count(
                    crossAxisCount: widget.gridModel.columns ?? 0,
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: _alphabets.map(_validator).toList(),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Enter Characters',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                        SearchField(
                          suggestions: const [],
                          controller: _searchController,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      String text1 = _searchController.toString();
                      var searched = _alphabets.map((e) {
                        if (text1.contains(e.char)) {
                          e.isSelected = true;
                          selected.add(e.char);
                        } else {
                          e.isSelected = false;
                          selected.remove(e.char);
                        }
                        return e;
                      });
                      setState(() => _alphabets = searched.toList());
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.teal[500],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: const Center(
                      child: Text('Search Text'),
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

  Widget _validator(AlphabetModel alphabetModel) {
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
