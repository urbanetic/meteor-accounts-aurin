Package.describe({
  name: 'urbanetic:accounts-aurin',
  summary: 'An accounts provider for AURIN workbench applications.',
  version: '0.1.0'
});

Package.on_use(function(api) {
  api.versionsFrom('METEOR@0.9.0');
  api.use(['coffeescript', 'underscore', 'accounts-password', 'accounts-ui'], ['client', 'server']);
  api.use(['templating', 'jquery'], 'client');
  api.add_files([
    'src/server.coffee'
  ], 'server');
  api.add_files([
    'src/client.coffee'
  ], 'client');
});
