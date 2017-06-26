# Webhooks Viewer Demo

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/webhooks-consumer-demo)

## Online Guide

### Deploy and launch the application

Deploy this button and then click on the `View` link and follow the OAuth Configuration Instructions to log in.

![View](public/manage.png)

### Follow setup instructions to create webhooks

![Setup](public/setup.png)

## Offline Guide

First, deploy this button and replace `$VIEWER_APP` in the directions with the app that was created.

### Create an OAuth client

```
$ heroku clients:create $VIEWER_APP https://$VIEWER_APP.herokuapp.com/auth/heroku/callback
Creating $VIEWER_APP... done
HEROKU_OAUTH_ID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
HEROKU_OAUTH_SECRET=YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY
```

### Add OAuth Client to viewer app

```
$ heroku config:set HEROKU_OAUTH_ID=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX HEROKU_OAUTH_SECRET=YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY -a $VIEWER_APP
Setting HEROKU_OAUTH_ID, HEROKU_OAUTH_SECRET and restarting ⬢ $VIEWER_APP... done, v3
 ▸    Warning: The "HEROKU_" namespace is protected and shouldn't be used.
HEROKU_OAUTH_ID:     XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
HEROKU_OAUTH_SECRET: YYYYYYYY-YYYY-YYYY-YYYY-YYYYYYYYYYYY
```

### Install the webhooks CLI plugin

```
$ heroku plugins:install heroku-webhooks
Installing plugin heroku-webhooks... done
```

### Create an app $TRIGGER_APP that we will be triggering events on.

```
$ heroku create -n
Creating app... done, ⬢ $TRIGGER_APP
https://$TRIGGER_APP.herokuapp.com/ | https://git.heroku.com/$TRIGGER_APP.git
```

### Create a release webhook

```
$ heroku webhooks:add --include api:release -l sync --url https://$VIEWER_APP.herokuapp.com/webhooks -s "$(heroku config:get WEBHOOK_SECRET -a $VIEWER_APP)" -a $TRIGGER_APP
Adding webhook to ⬢ $TRIGGER_APP... done
```

### Trigger a release by setting a config var

```
$ heroku config:set FOO=bar -a $TRIGGER_APP
Setting FOO and restarting ⬢ $TRIGGER_APP... done, v3
FOO: bar
```

### Open the webhooks viewer app and log in

```
$ heroku open -a $VIEWER_APP
```

At this point you should see the release in the webhook event listing.
