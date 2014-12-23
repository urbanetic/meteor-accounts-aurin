Meteor.loginWithAurin = (username, password, callback) ->
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: (err, result) ->
      AccountsAurin.onAfterLogin() unless err
      callback?.apply(null, arguments)

AccountsAurin = _.extend AccountsAurin,

  _config: null

  config: (config) ->
    config = @_config = _.extend({
      loginRoute: 'login'
      loginTemplate: 'aurinLoginForm'
    }, config)
    loginRoute = config.loginRoute
    loginTemplate = config.loginTemplate
    if Router
      Router.route(loginRoute, {path: loginRoute, template: loginTemplate})

  signInRequired: (router) ->
    config = @_config
    user = Meteor.user()
    @goToLogin() unless user
    router.next()

  onAfterLogin: -> @_config.afterLogin?()

  goToLogin: -> Router.go(@_config.loginRoute)
