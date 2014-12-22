AURIN_APP_NAME = 'ESP'
AURIN_SERVER_URL = 'http://115.146.86.33:8080/envisionauth'

loginHandler = (request) ->
  console.log('loginHandler', arguments)
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
  console.log('result', result)

  # Access denied gives empty content.
  if result.content.trim() == ''
    throw new Meteor.Error('Access denied')

  # Ensure the user has access to the current app.
  hasAppAccess = _.some data.userApplications, (appArgs) ->
    appArgs.appname == AURIN_APP_NAME

  unless hasAppAccess
    throw new Meteor.Error('Access denied for app: ' + AURIN_APP_NAME + '. Please contact us for ' +
      'assistance')

  # Create the user or add new details.
  selector = {username: username}
  Meteor.users.upsert(selector, {$set: {
    username: username,
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

