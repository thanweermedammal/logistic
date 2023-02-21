import 'package:shared_value/shared_value.dart';

final SharedValue<int> assigned = SharedValue(
  value: 0, // initial value
  key: "assigned", // disk storage key for shared_preferences
  autosave: true, // autosave to shared prefs when value changes
);
