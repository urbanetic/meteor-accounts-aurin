Package.describe({
  name: 'urbanetic:accounts-aurin',
  summary: 'An accounts provider for AURIN workbench applications.',
  version: '0.1.0'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use(['coffeescript', 'underscore', 'http', 'accounts-password', 'accounts-ui'],
    ['client', 'server']);
  api.use(['templating', 'jquery', 'less'], 'client');
  api.add_files([
    'src/server.coffee'
  ], 'server');
  api.add_files([
    'src/client.coffee',
    'src/aurinLoginForm.html',
    'src/aurinLoginForm.less',
    'src/aurinLoginForm.coffee'
  ], 'client');
});
