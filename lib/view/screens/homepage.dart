import 'package:advance_final_exam/model/helper/database_helper.dart';
import 'package:advance_final_exam/model/recipes_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> dataformkey = GlobalKey();
  final TextEditingController idcontroller = TextEditingController();
  final TextEditingController quantitycontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController typecontroller = TextEditingController();
  String? name;
  String? type;
  int? id;
  int? quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Recipes"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("DELETE"),
                            content: Text(
                                "Are you sure want to delete this recipes"),
                            actions: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          DbHelper.dbHelper.deleteAllDb();
                                        });
                                      },
                                      child: Text("Delete"))
                                ],
                              )
                            ],
                          );
                        });
                  },
                  icon: Icon(Icons.delete)),
            )
          ],
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AlertBox();
          },
          child: Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      FutureBuilder<List<RecipesModel>>(
                          future: DbHelper.dbHelper.fetchallDb(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("${snapshot.error}"),
                              );
                            } else if (snapshot.hasData) {
                              List<RecipesModel>? recipesdata = snapshot.data;
                              return (recipesdata == null ||
                                      recipesdata.isEmpty)
                                  ? const Center(
                                      child: Text("No data found"),
                                    )
                                  : ListView.builder(
                                      itemCount: recipesdata.length,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: CircleAvatar(
                                            radius: 30,
                                            child: Text(
                                                "${recipesdata[index].id}"),
                                          ),
                                          title: Text(
                                              "${recipesdata[index].name}"),
                                          trailing: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  RecipesModel recipesmodel =
                                                      RecipesModel(
                                                          id: id!,
                                                          quantity: quantity!,
                                                          name: name!,
                                                          type: type!);
                                                  DbHelper.dbHelper
                                                      .updateDb(recipesmodel);
                                                  setState(() {});
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  DbHelper.dbHelper
                                                      .deleteDb(id!);

                                                  setState(() {});
                                                  DbHelper.dbHelper
                                                      .fetchallDb();
                                                },
                                                icon: Icon(Icons.delete),
                                              )
                                            ],
                                          ),
                                        );
                                      });
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void AlertBox() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add the details of the Recipes"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Form(
                  key: dataformkey,
                  child: Card(
                    child: Container(
                      height: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: idcontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter first id";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                id = int.parse(val!);
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter the id",
                                  label: Text("Id"),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        idcontroller.clear();
                                      },
                                      icon: Icon(Icons.close)),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: quantitycontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter first quantity";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                quantity = int.parse(val!);
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter the quantity",
                                  label: Text("quantity"),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        quantitycontroller.clear();
                                      },
                                      icon: Icon(Icons.close)),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: namecontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter first name";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                name = val;
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter the name",
                                  label: Text("Name"),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        namecontroller.clear();
                                      },
                                      icon: Icon(Icons.close)),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: typecontroller,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter first type";
                                }
                                return null;
                              },
                              onSaved: (val) {
                                type = val;
                              },
                              decoration: InputDecoration(
                                  hintText: "Enter the type",
                                  label: Text("Type"),
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        typecontroller.clear();
                                      },
                                      icon: Icon(Icons.close)),
                                  border: OutlineInputBorder()),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            OutlinedButton.icon(
                              onPressed: () {
                                if (dataformkey.currentState!.validate()) {
                                  dataformkey.currentState!.save();
                                  RecipesModel recipesmodel = RecipesModel(
                                      id: id!,
                                      quantity: quantity!,
                                      name: name!,
                                      type: type!);
                                  DbHelper.dbHelper.insertDb(recipesmodel);
                                  print("========");
                                  print(recipesmodel);
                                  print("========");
                                }
                                idcontroller.clear();
                                quantitycontroller.clear();
                                namecontroller.clear();
                                typecontroller.clear();
                              },
                              label: Text("Add Recipes"),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
