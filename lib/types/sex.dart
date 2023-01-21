enum Sex { male, female }

String sexToString(Sex value) {
  switch (value) {
    case Sex.male:
      return "Male";
    case Sex.female:
      return "Female";
  }
}

Sex sexToEnum(String value) {
  switch (value) {
    case "Male":
      return Sex.male;
    case "Female":
      return Sex.female;
    default:
      throw Exception(
          "Unexpected string value. Accepted input is either 'Male' or 'Female'");
  }
}
