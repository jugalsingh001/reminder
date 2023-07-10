import 'package:flutter/material.dart';

class UpdateReminderPage extends StatefulWidget {
  const UpdateReminderPage({Key? key}) : super(key: key);

  @override
  State<UpdateReminderPage> createState() => _UpdateReminderPageState();
}

class _UpdateReminderPageState extends State<UpdateReminderPage> {
  TextEditingController time = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  String dateTime = '';
  bool enabled = false;

  void selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2026),
    ).then((value) {
      setState(() {
        dateTime = value!.toString().substring(0, 10);
      });
    });
  }

  void showInSnackBar({required String value, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, color: Colors.white)),
      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.fixed,
      elevation: 5.0,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Reminder'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Title: ',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            textAlign: TextAlign.start,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: TextFormField(
              controller: title,
              maxLines: 1,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Enter the title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          enabled
              ? Column(
                  children: [
                    const Text(
                      'Description: ',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                      ),
                      child: TextFormField(
                        controller: desc,
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          hintText: 'Enter the description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () {
                        selectDate();
                      },
                      height: 40,
                      color: Colors.blueGrey,
                      textColor: Colors.white,
                      child: const Text(
                        'Choose Date',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 165,
                        right: 165,
                      ),
                      child: TextField(
                        controller: time,
                        maxLines: 1,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          labelStyle: TextStyle(
                            color: Colors.blue,
                          ),
                          hintText: 'HH:MM',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : Container(),
          InkWell(
            onTap: () {
              if (enabled) {
                showInSnackBar(
                    value: 'Reminder updated successfully', context: context);
                Navigator.pop(context);
              } else if (title.text.trim().isEmpty) {
                showInSnackBar(
                    value: 'Please enter the title', context: context);
              } else if (title.text.trim().isNotEmpty) {
                setState(() {
                  enabled = true;
                });
              } else if (time.text.trim().isEmpty) {
                showInSnackBar(value: 'Please enter time', context: context);
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              alignment: Alignment.center,
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3547B6), Color(0xFF4567A6)],
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: const Text(
                'Set',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
