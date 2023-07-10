import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewReminderPage extends StatefulWidget {
  const ViewReminderPage({Key? key}) : super(key: key);

  @override
  State<ViewReminderPage> createState() => _ViewReminderPageState();
}

class _ViewReminderPageState extends State<ViewReminderPage> {
  var isChecked;

  int? len = 0;
  late final List<String>? l1;
  late final List<String>? l2;
  late final List<String>? l3;
  late final List<String>? l4;

  void getDetails() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    l1 = prefs.getStringList('items_title');
    l2 = prefs.getStringList('items_desc');
    l3 = prefs.getStringList('items_date');
    l4 = prefs.getStringList('items_time');

    setState(() {
      len = l1?.length;
    });

    isChecked = List.generate(len!, (value) => false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Reminder'),
      ),
      body: Container(
        color: Colors.black12,
        child: ListView.builder(
          itemCount: len,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 13,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/reminder.png',
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        '${l1![index].substring(0, 1).toUpperCase()}${l1![index].substring(1).toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${l2![index].substring(0, 1).toUpperCase()}${l2![index].substring(1).toLowerCase()}',
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      trailing: Checkbox(
                        value: isChecked[index],
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked[index] = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const SizedBox(
                          width: 60,
                        ),
                        Text(
                          'Date: ${l3![index]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                        const SizedBox(
                          width: 110,
                        ),
                        Text(
                          'Time: ${l4![index]}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
