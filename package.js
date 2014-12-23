Package.describe({
  name: 'urbanetic:accounts-aurin',
  summary: 'An accounts provider for AURIN workbench applications.',
  version: '0.1.0'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use(['coffeescript', 'underscore', 'http', 'accounts-password', 'accounts-ui',
    'aramk:utility@0.4.2', 'matb33:collection-hooks@0.7.6'], ['client', 'server']);
  api.use(['templating', 'jquery', 'less'], 'client');
  api.use(['iron:router'], 'client', {weak: true});
  api.add_files(['src/common.coffee'], ['client', 'server']);
  api.add_files(['src/server.coffee'], 'server');
  api.add_files([
    'src/client.coffee',
    'src/aurinLoginForm.html',
    'src/aurinLoginForm.less',
    'src/aurinLoginForm.coffee',
    'src/aurinUserNav.html',
    'src/aurinUserNav.less',
    'src/aurinUserNav.coffee'
  ], 'client');
  api.export('AccountsAurin', ['client', 'server']);
});
