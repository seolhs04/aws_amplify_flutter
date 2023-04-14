import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:aws_amplify_flutter/amplifyconfiguration.dart';
import 'package:aws_amplify_flutter/models/ModelProvider.dart';

class AmplifyService {
  static Future<void> config() async {
    final dataStorePlugin =
        AmplifyDataStore(modelProvider: ModelProvider.instance);
    final authPlugin = AmplifyAuthCognito();

    try {
      await Amplify.addPlugins([dataStorePlugin, authPlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      safePrint('An error occurred while configuring Amplify: $e');
    }
  }
}
