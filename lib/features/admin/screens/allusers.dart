import 'package:flutter/material.dart';
import 'package:smartfit/features/auth/services/auth_service.dart';

class allusers extends StatefulWidget {
  const allusers({super.key});

  @override
  State<allusers> createState() => _allusersState();
}

class _allusersState extends State<allusers> {
  AuthService a = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
        future: a.allusers(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(2, 2),
                            spreadRadius: 2,
                            blurRadius: 2,
                            color: Colors.grey.shade300)
                      ],
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data[index]['email'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        snapshot.data[index]['name'],
                      ),
                      Text(
                        "Status : " + snapshot.data[index]['status'],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () async {
                                if (snapshot.data[index]['status'] == "false") {
                                  await a.changestatus(
                                      context, snapshot.data[index]['_id']);
                                  setState(() {});
                                } else {
                                  await a.delete(
                                      context, snapshot.data[index]['_id']);
                                  setState(() {});
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Center(
                                  child: Text(
                                    snapshot.data[index]['status'] == "false"
                                        ? "approve"
                                        : "Delete",
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Icon(Icons.error);
          } else {
            return const CircularProgressIndicator();
          }
        },
      )),
    );
  }
}
