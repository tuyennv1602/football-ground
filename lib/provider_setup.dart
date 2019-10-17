import 'package:footballground/models/ground.dart';
import 'package:footballground/services/api.dart';
import 'package:footballground/services/auth_services.dart';
import 'package:footballground/services/ground_services.dart';
import 'package:footballground/services/share_preferences.dart';
import 'package:footballground/services/sqlite_service.dart';
import 'package:provider/provider.dart';

import 'models/user.dart';

// Define all provider in app
List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders
];

// These are classes/objects that do not depend on any other services to execute their logic
List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: Api()),
  Provider.value(value: SharePreferences()),
  Provider.value(value: SQLiteServices())
];

// These are classes/object that depend on previously registered services
List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider2<Api, SharePreferences, AuthServices>(
      builder: (context, api, sharePref, authenticationService) =>
          AuthServices(api: api, sharePreferences: sharePref)),
  ProxyProvider<Api, GroundServices>(
      builder: (context, api, groundServices) => GroundServices(api: api))
];

// These are values that you want to consume directly in the UI
// You can add values here if you would have to introduce a property on most,
// if not all your models just to get the data out. In our case the user information.
// If we don't provide it here then all the models will have a user property on it.
// You could also just add it to the BaseModel
List<SingleChildCloneableWidget> uiConsumableProviders = [
  StreamProvider<User>(
    builder: (context) =>
        Provider.of<AuthServices>(context, listen: false).user,
  ),
  StreamProvider<Ground>(
    builder: (context) =>
        Provider.of<GroundServices>(context, listen: false).ground,
  ),
];
