# accounts-aurin

An accounts provider for AURIN workbench applications.


## Setup

The following environment variables must be set:

| Variable         | Description | Example |
| ---------------- | ------------- | ----- |
| AURIN_APP_NAME   | The name of the app as specified in the "userApplications.appname" when performing a getUser() request. | "ESP" |
| AURIN_SERVER_URL | The AURIN Auth server URL. | "http://localhost:8080/envisionauth" |

To configure the package, call the following from the client on startup:

```
Meteor.startup(function() {
  AccountsAurin.config({
    // Called after a successful login.
    afterLogin: function() {
      return Router.go('/projects');
    },
    // The route to the login form.
    loginRoute: 'login', // Default
    // The template for the login form.
    loginTemplate: 'aurinLoginForm' // Default
  });
});
```

A login route will be created based on these settings.

## Routing

This package relies on [Iron Router](https://github.com/EventedMind/iron-router) for routing.

To prevent unauthorized access to routes, use `AccountsAurin.signInRequired(router)`. For example:

```
// Globally.
Router.onBeforeAction(function() {
  AccountsAurin.signInRequired(this);
});

// In a controller.
var BaseController = RouteController.extend({
  onBeforeAction: function() {
    if (!this.ready()) {
      return;
    }
    AccountsAurin.signInRequired(this);
  },
  action: function() {
	this.ready() && this.render();
  }
});
```

## Templates

The login form can be rendered with `{{> aurinLoginForm}}`. The default configuration will take care of all the routing and template rendering.

The user navigation can be shown with `{{> aurinUserNav}}`. It will show the current user's name and a sign out button, or a sign in button if no user is found.
