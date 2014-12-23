Meteor.loginWithAurin = (username, password, callback) ->
  afterLogin = AccountsAurin._config.afterLogin
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: (err, result) ->
      afterLogin() unless err
      callback.apply(null, arguments)

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
    if user
      router.next()
    else
      router.render(config.loginTemplate)

  goToLogin: -> Router(@_config.loginRoute)
