Package.describe({
  name: 'urbanetic:accounts-aurin',
  summary: 'An accounts provider for AURIN workbench applications.',
  git: 'https://github.com/urbanetic/meteor-accounts-aurin.git',
  version: '0.2.5'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@1.2.0.1');
  api.use([
    'coffeescript',
    'underscore',
    'http',
    'accounts-password',
    'accounts-ui',
    'urbanetic:accounts-ui@0.2.2',
    'urbanetic:utility@1.2.0',
    'matb33:collection-hooks@0.7.6'
  ], ['client', 'server']);
  api.use(['templating', 'jquery', 'less'], 'client');
  api.use(['iron:router@1.0.13'], 'client', {weak: true});
  api.addFiles(['src/common.coffee'], ['client', 'server']);
  api.addFiles(['src/server.coffee'], 'server');
  api.addFiles([
    'src/client.coffee',
    'src/aurinLoginForm.html',
    'src/aurinLoginForm.less',
    'src/aurinLoginForm.coffee'
  ], 'client');
  api.addAssets([
    'src/resources/aurin.jpg'
  ], 'client');
  api.imply('urbanetic:accounts-ui');
});
