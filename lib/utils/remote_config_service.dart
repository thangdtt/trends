 import 'package:firebase_remote_config/firebase_remote_config.dart';

void fetchFptApiKey() async {
    final RemoteConfig remoteConfig = await RemoteConfig.instance;

    await remoteConfig.fetch(expiration: const Duration(hours: 8));
    await remoteConfig.activateFetched();
    print('welcome message: ' + remoteConfig.getString('welcome'));
  }

  class RemoteConfigService{
    final RemoteConfig _remoteConfig;

    final defaults = <String, dynamic>{'fpt_api_key':'yScyV1a1NbXkkIZh2o2kmkWCc45ilfPJ'};

    static RemoteConfigService _instance;

    static Future<RemoteConfigService> getInstance() async{
      if(_instance == null){
        _instance = RemoteConfigService(remoteConfig: await RemoteConfig.instance);
      }

      return _instance;
    }

    RemoteConfigService({RemoteConfig remoteConfig}): _remoteConfig = remoteConfig;

    String get fptApiKey => _remoteConfig.getString('fpt_api_key');

    Future init() async{
      try {
        await _remoteConfig.setDefaults(defaults);
        await _remoteConfig.fetch();
        await _remoteConfig.activateFetched();
      } catch (e) {
        print(e);
      }
    }
  }