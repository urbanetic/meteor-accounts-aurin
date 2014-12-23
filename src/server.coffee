env = process.env
AURIN_APP_NAME = env.AURIN_APP_NAME
AURIN_SERVER_URL = env.AURIN_SERVER_URL

console.log('AURIN Auth:')
console.log('  AURIN_APP_NAME: ' + AURIN_APP_NAME)
console.log('  AURIN_SERVER_URL: ' + AURIN_SERVER_URL)

loginHandler = (request) ->
  return undefined unless request.isAurin
  username = request.username
  password = request.password
  
  result = HTTP.get(AURIN_SERVER_URL + '/getUser', {
    headers:
      'X-AURIN-USER-ID': 'aurin'
      user: username
      password: password
      Accept: 'application/json'
      'Content-Type': 'application/json'
  })
  data = result.data

  # Access denied gives empty content.
  if result.content.trim() == ''
    throw new Meteor.Error('Access denied')

  # Ensure the user has access to the current app.
  hasAppAccess = _.some data.userApplications, (appArgs) ->
    appArgs.appname == AURIN_APP_NAME

  unless hasAppAccess
    throw new Meteor.Error('Access denied for app: ' + AURIN_APP_NAME + '. Please contact us for ' +
      'assistance.')

  # Create the user or add new details.
  name = (data.firstname + ' ' + data.lastname).trim()
  selector = {username: username}
  Meteor.users.upsert(selector, {$set: {
    username: username
    'profile.name': name
    'services.aurin': data
  }})
  user = Meteor.users.findOne(selector)

  {userId: user._id}

# We use a Meteor method instead so we don't have our request from the client pass through every
# handler, since it will fail on some and never reach the one above.
# Accounts.registerLoginHandler('aurin', loginHandler)

Meteor.methods

  'aurinLogin': (options) ->
    # Calls 'aurin' type login method handler defined above, passing the options from the client.
    Accounts._loginMethod @, 'aurinLogin', arguments, 'aurin', -> loginHandler(options)

