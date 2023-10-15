import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//home page
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//home page state
class _HomePageState extends State<HomePage> {
  List waterList = [];
  List<int> glassList = [];
  final numberOfGlass = TextEditingController();
  int totalGlass = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar
      appBar: AppBar(
        title: const Text('Water Reseve'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(5),
          child: Column(
            children: [
              //top heading
              const Text(
                'Total',
                style: TextStyle(fontSize: 40),
              ),

              //total glass
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                    radius: 30,
                    foregroundColor: Colors.white,
                    child: Text(
                      totalGlass.toString(),
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),),
              ),

              // add water reserve list
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // input glass number
                  Expanded(
                    flex: 2,
                    child: TextField(
                      controller: numberOfGlass,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Num. of glass',
                        border: const OutlineInputBorder(),
                        fillColor: Colors.grey[400],
                        filled: true,
                      ),
                    ),
                  ),

                  //add button
                  Flexible(
                    flex: 4,
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          totalGlass = 0;

                          waterList.add('${DateFormat.yMMMd().format(DateTime.now())} - ${DateFormat.jms().format(DateTime.now())}');
                          glassList.add(int.tryParse(numberOfGlass.text) ?? 1);
                          glassList.forEach((element) {
                            totalGlass += element;
                          });
                          numberOfGlass.text = 1.toString();

                          setState(() {});

                          // print(waterList);
                          // print(glassList);
                        },
                        child: const Text('Add'),
                      ),
                    ),
                  ),
                ],
              ),

              //water list
              ListView.builder(
                shrinkWrap: true,
                itemCount: waterList.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      //water listTile
                      Expanded(
                        flex: 4,
                        child: ListTile(
                          leading: Text((index + 1).toString()),
                          title: Text(waterList[index].toString()),
                          trailing: Text(glassList[index].toString()),
                        ),
                      ),

                      //delete list
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          onPressed: () {
                            totalGlass -=
                                int.parse(glassList[index].toString());
                            waterList.removeAt(index);
                            glassList.removeAt(index);

                            setState(() {});

                            // print(waterList);
                            // print(glassList);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('delete'),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
