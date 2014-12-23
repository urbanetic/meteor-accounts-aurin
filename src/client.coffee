Meteor.loginWithAurin = (username, password, callback) ->
  loginRequest = {username: username, password: password, isAurin: true}
  Accounts.callLoginMethod
    methodName: 'aurinLogin'
    methodArguments: [loginRequest]
    userCallback: callback

AccountsAurin =

  _config: null

  config: (config) ->
    config = @_config = _.extend({
      loginRoute: 'login'
      loginTemplate: 'aurinLoginForm'
    }, config)
    afterLogin = config.afterLogin
    if afterLogin
      Tracker.autorun ->
        user = Meteor.user()
        afterLogin() if user
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
