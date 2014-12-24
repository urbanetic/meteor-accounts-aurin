TemplateClass = Template.aurinLoginForm

TemplateClass.rendered = ->
  getUsernameInput(@).focus()

TemplateClass.events

  'submit form': (e, template) ->
    e.preventDefault()
    clearMessages()
    $username = getUsernameInput(template)
    $password = template.$('[name="password"]')
    username = $username.val().trim()
    password = $password.val().trim()
    if username == '' || password == ''
      err = 'Must provide both username and password'
      console.error(err)
      addMessage(createErrorMessage(err))
      return
    console.debug('Logging in with username:', username)
    # Attempt to log in the user using the built-in accounts-password package.
    Meteor.loginWithPassword username, password, (err) ->
      unless err
        AccountsAurin.onAfterLogin()
        return
      # If the login failed, try with AURIN.
      Meteor.loginWithAurin username, password, (err, result) ->
        if err
          console.error('Error when logging in', err)
          addMessage(createErrorMessage(err.error), template)
        else
          console.debug('Successfully logged in', result)


getFormDom = (template) -> getTemplate(template).$('form')

clearMessages = (template) ->
  getFormDom(template).removeClass('error')
  getMessagesDom(template).empty()

addMessage = ($message, template) ->
  getMessagesDom(template).prepend($message)
  if $message.hasClass('error')
    getFormDom(template).addClass('error')

getMessagesDom = (template) -> getTemplate(template).$('.messages')

getUsernameInput = (template) -> getTemplate(template).$('[name="username"]')

getTemplate = (template) -> template ? Template.instance()

createErrorMessage = (err) -> $('<div class="ui error message">' + err.toString() + '</div>')
