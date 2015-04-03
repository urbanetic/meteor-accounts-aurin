TemplateClass = Template.aurinLoginForm
LoginTemplateClass = Template.loginForm

TemplateClass.rendered = LoginTemplateClass.rendered

TemplateClass.events
  'submit form': (e, template) -> TemplateClass.onSubmit(e, template)

# Add template methods.
_.defaults TemplateClass, LoginTemplateClass

TemplateClass.login = (username, password, template) ->
  df = Q.defer()
  # Attempt to log in the user using the built-in accounts-password package.
  Meteor.loginWithPassword username, password, (err) ->
    unless err
      AccountsAurin.onAfterLogin()
      df.resolve()
      return
    # If the login failed, try with AURIN.
    Meteor.loginWithAurin username, password, (err, result) ->
      if err
        Logger.error('Error when logging in', err)
        LoginTemplateClass.addMessage(LoginTemplateClass.createErrorMessage(err.message), template)
        df.reject(err)
      else
        Logger.debug('Successfully logged in', result)
        df.resolve()
  df.promise
