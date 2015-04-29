TemplateClass = Template.aurinLoginForm
LoginTemplateClass = Template.loginForm

TemplateClass.rendered = LoginTemplateClass.rendered

TemplateClass.events
  'submit form': (e, template) -> TemplateClass.onSubmit(e, template)

# Add template methods.
_.defaults TemplateClass, LoginTemplateClass

TemplateClass.login = (username, password, template) ->
  Logger.info('Logging in with username', username)
  df = Q.defer()
  # Attempt to log in the user using the built-in accounts-password package.
  Meteor.loginWithPassword username, password, (err) ->
    unless err
      Logger.info('Successfully logged in', username)
      AccountsAurin.onAfterLogin()
      df.resolve()
      return
    Logger.info('Contacting AURIN Auth')
    # If the login failed, try with AURIN.
    Meteor.loginWithAurin username, password, (err, result) ->
      if err
        Logger.error('Error when logging in with AURIN Auth', err)
        LoginTemplateClass.addMessage(LoginTemplateClass.createErrorMessage(err.message), template)
        df.reject(err)
      else
        Logger.debug('Successfully logged into AURIN Auth', result)
        df.resolve()
  df.promise
