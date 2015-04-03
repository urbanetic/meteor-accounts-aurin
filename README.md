# accounts-aurin

An accounts provider for AURIN workbench applications.

## Setup

See [meteor-accounts-ui](https://github.com/urbanetic/meteor-accounts-ui). Use `AccountsAurin`
instead of `AccountsUi` and `aurinLoginForm` instead of `loginForm`.

The following environment variables must be set:

| Variable         | Description | Example |
| ---------------- | ------------- | ----- |
| AURIN_APP_NAME   | The name of the app as specified in the "userApplications.appname" when performing a getUser() request. | "ESP" |
| AURIN_SERVER_URL | The AURIN Auth server URL. | "http://localhost:8080/envisionauth" |
