import 'package:flutter_app/generated/json/base/json_convert_content.dart';
import 'package:flutter_app/generated/json/base/json_filed.dart';

class ConfigEntity with JsonConvert<ConfigEntity> {
	String env;
	String oauthHost;
	String versionHost;
	@JSONField(name: "JPushAppKey")
	String jPushAppKey;
	ConfigFlurry flurry;
	ConfigLogin login;
}

class ConfigFlurry with JsonConvert<ConfigFlurry> {
	String iosKey;
	String androidKey;
}

class ConfigLogin with JsonConvert<ConfigLogin> {
	String redirectUri;
	String clientId;
	String clientSecret;
}
