TemplateClass = Template.aurinUserNav

TemplateClass.events
  
  'click .logout.button': (e, template) -> Meteor.logout()
  
  'click .login.button': (e, template) -> AccountsAurin.goToLogin()
