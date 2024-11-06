import 'dart:io';

class Logic {
  String promptForValidString(String prompt) {
    String? str;
    while (true) {
      stdout.write(prompt);
      str = stdin.readLineSync();

      if (str != null && RegExp(r'^[a-zA-Z]+$').hasMatch(str)) {
        return str;
      } else {
        print("Invalid input. Please enter alphabetic characters only.");
      }
    }
  }

  String promptForValidNumber(String prompt) {
    String? numberInput;
    while (true) {
      stdout.write(prompt);
      numberInput = stdin.readLineSync();

      if (numberInput != null && int.tryParse(numberInput) != null) {
        return numberInput;
      } else {
        print("Invalid input. Please enter a valid number.");
      }
    }
  }

  String? promptForValidStringList(String prompt) {
    List<String>? inputList;
    String? input;
    bool flag;

    do {
      stdout.write(prompt);
      input = stdin.readLineSync();
      flag = true; // Assume the input is valid initially

      if (input != null && input.isNotEmpty) {
        inputList = input.split(',').map((answer) => answer.trim()).toList();

        for (var item in inputList) {
          if (int.tryParse(item) != null) {
            print(
                "Answers should be in alphabetical format, separated by commas. Please try again.");
            flag = false;
            break;
          }
        }
      } else {
        flag = false;
      }
    } while (!flag);

    return input;
  }

  String? promptForValidNumberList(String prompt) {
    List<String>? inputList;
    String? input;
    bool flag;

    do {
      stdout.write(prompt);
      input = stdin.readLineSync();
      flag = true; // Assume the input is valid initially

      if (input != null && input.isNotEmpty) {
        inputList = input.split(',').map((answer) => answer.trim()).toList();

        for (var item in inputList) {
          if (int.tryParse(item) == null) {
            print(
                "Answers should be in numerically format, separated by commas. Please try again.");
            flag = false; // Mark as invalid input if a number is found
            break;
          }
        }
      } else {
        flag = false; // If input is null or empty, repeat the loop
      }
    } while (!flag); // Continue until valid input is received

    return input;
  }
}
