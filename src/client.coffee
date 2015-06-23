Meteor.loginWithAurin = (username, password, callback) ->
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: (err, result) ->
      callback?.apply(null, arguments)
