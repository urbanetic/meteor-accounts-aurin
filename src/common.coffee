Meteor.startup ->

  defaults =
    login:
      template: 'aurinLoginForm'
    account:
      enabledByDefault: true

  AccountsUi.config = _.wrap AccountsUi.config, (func, args) ->
    if args then Setter.defaults args, defaults
    func.call(AccountsUi, args)
