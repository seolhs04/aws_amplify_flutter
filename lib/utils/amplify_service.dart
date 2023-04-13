import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/amplifyconfiguration.dart';
import 'package:aws_amplify_flutter/models/ModelProvider.dart';

class AmplifyService {
  final dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);

  Future<void> config() async {
    try {
      await Amplify.addPlugins([dataStorePlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      safePrint('An error occurred while configuring Amplify: $e');
    }
  }
}
