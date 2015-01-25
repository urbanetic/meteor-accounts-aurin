TemplateClass = Template.aurinUserNav

TemplateClass.events
  
  'click .logout.button': (e, template) ->
    result = confirm('Are you sure you want to logout?')
    Meteor.logout() if result
  
  'click .login.button': (e, template) -> AccountsAurin.goToLogin()
