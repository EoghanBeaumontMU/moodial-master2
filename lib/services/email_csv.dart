import 'dart:io';
import 'package:Moodial/services/mood_props.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';

class EmailCSV {
  static Future<String> createCSV(entryList) async {
    //Convert list to csv
    List<int> headers = [];
    List<String> datetimes = [];
    List<String> moods = [];
    List<String> sleeps = [];
    List<String> iritability = [];
    List<String> medicationHeaders = [];
    List<String> medication = [];
    List<String> dietHeaders = [];
    List<String> diet = [];
    List<String> exerciseHeaders = [];
    List<String> exercise = [];
    List<String> notesHeaders = [];
    List<String> notes = [];

    entryList.forEach((entry) {
      headers.add(entry.id);
      datetimes.add(entry.date + ' ' + entry.time);
      moods.add(MoodProps.moodValueToString(entry.mood));
      sleeps.add(entry.sleep.toString() + ' hours sleep');
      iritability.add(entry.iritability.toString() + '/10 iritability');
      medicationHeaders.add('MEDICATION');
      medication.add('Name: ' +
          entry.medication.name +
          ' - Dose: ' +
          entry.medication.dose);
      dietHeaders.add('DIET');
      diet.add('Food: ' + entry.diet.food + ' - Amount: ' + entry.diet.amount);
      exerciseHeaders.add('EXERCISE');
      exercise.add(entry.exercise);
      notesHeaders.add('NOTES');
      notes.add(entry.notes);
    });

    String csv = const ListToCsvConverter().convert([
      headers,
      datetimes,
      moods,
      sleeps,
      iritability,
      medicationHeaders,
      medication,
      dietHeaders,
      diet,
      exercise,
      notesHeaders,
      notes
    ]);

    /// Write to a file
    final directory = await getExternalStorageDirectory();
    final path = directory.path + "/MoodialEntryList.csv";
    File file = await File(path);
    file.writeAsString(csv);

    return path;
  }

  static Future<bool> sendEmail(username, emailAddress, entryList) async {
    String path = await createCSV(entryList);

    final Email email = Email(
      body: 'Hi, \n\n Please see attached CSV containing list of all mood entries from Moodial user, ' +
          username +
          ', that we have stored on our database. \n\n Kind regards, \n Moodial',
      subject: 'Moodial Entry List',
      recipients: [emailAddress],
      attachmentPaths: [path],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);

    return true;
  }
}
