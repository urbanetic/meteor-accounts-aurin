Meteor.loginWithAurin = (username, password, callback) ->
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: (err, result) ->
      AccountsAurin.onAfterLogin() unless err
      callback?.apply(null, arguments)

origConfigFunc = AccountsAurin.config
AccountsAurin = _.extend AccountsAurin,

  config: (config) ->
    config = _.extend({
      loginTemplate: 'aurinLoginForm'
    }, config)
    origConfigFunc.call(AccountsAurin, config)
