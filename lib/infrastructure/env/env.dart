enum ENV {
  dev(baseURL: "https://devbe.bahaso.com", authURL: "https://reqres.in"),
  prod(baseURL: "https://devbe.bahaso.com", authURL: "https://reqres.in");

  final String baseURL;
  final String authURL;

  const ENV({required this.baseURL, required this.authURL});

  static ENV current = ENV.dev;

  static void setEnv(ENV env) => current = env;
}
