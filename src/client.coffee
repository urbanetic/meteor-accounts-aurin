Meteor.loginWithAurin = (username, password, callback) ->
  console.log('Meteor.loginWithAurin', arguments)
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: callback
