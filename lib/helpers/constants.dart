const auth0Domain = String.fromEnvironment('AUTH0_DOMAIN');
const auth0ClientId = String.fromEnvironment('AUTH0_CLIENT_ID');
const apiEndpoint = String.fromEnvironment('API_ENDPOINT');
const auth0Issuer = 'https://$auth0Domain';
const bundleIdentifier = 'com.firstlovecenter.poimen';
const auth0RedirectUri = '$bundleIdentifier://login-callback';
const refreshTokenKey = 'refresh_token';
