TemplateClass = Template.aurinLoginForm

TemplateClass.events

  'submit form': (e, template) ->
    e.preventDefault()
    clearMessages()
    $username = template.$('[name="username"]')
    $password = template.$('[name="password"]')
    username = $username.val().trim()
    password = $password.val().trim()
    if username == '' || password == ''
      err = 'Must provide both username and password'
      console.error(err)
      addMessage(createErrorMessage(err))
      return
    console.debug('Logging in with username:', username)
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
getTemplate = (template) -> template ? Template.instance()
createErrorMessage = (err) -> $('<div class="ui error message">' + err.toString() + '</div>')
