Package.describe({
  name: 'urbanetic:accounts-aurin',
  summary: 'An accounts provider for AURIN workbench applications.',
  git: 'https://github.com/urbanetic/meteor-accounts-aurin.git',
  version: '0.2.3'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use([
    'coffeescript',
    'underscore',
    'http',
    'accounts-password',
    'accounts-ui',
    'urbanetic:accounts-ui@0.2.1',
    'aramk:utility@0.8.2',
    'matb33:collection-hooks@0.7.6'
  ], ['client', 'server']);
  api.use(['templating', 'jquery', 'less'], 'client');
  api.use(['iron:router@1.0.3'], 'client', {weak: true});
  api.addFiles(['src/common.coffee'], ['client', 'server']);
  api.addFiles(['src/server.coffee'], 'server');
  api.addFiles([
    'src/client.coffee',
    'src/aurinLoginForm.html',
    'src/aurinLoginForm.less',
    'src/aurinLoginForm.coffee',
    'src/resources/aurin.jpg'
  ], 'client');
  api.imply('urbanetic:accounts-ui');
  api.export('AccountsAurin', ['client', 'server']);
});
