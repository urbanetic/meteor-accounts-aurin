loginHandler = (request) ->
  console.log('loginHandler', arguments)
  return undefined unless request.isAurin
  
  # TODO(aramk) Replace with actual login logic.
  if request.password != 'admin-password'
    return null

  # Create the user if it's missing.
  userId = null
  user = Meteor.users.findOne(username: request.username)
  if user
    userId = user._id
  else
    userId = Meteor.users.insert(username: request.username)

  {userId: userId}

# We use a Meteor method instead so we don't have our request from the client pass through every
# handler, since it will fail on some and never reach the one above.
# Accounts.registerLoginHandler('aurin', loginHandler)

Meteor.methods

  'aurinLogin': (options) ->
    # Calls 'aurin' type login method handler defined above, passing the options from the client.
    Accounts._loginMethod @, 'aurinLogin', arguments, 'aurin', -> loginHandler(options)

