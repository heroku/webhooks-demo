# README

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/webhooks-consumer-demo)

## Guide

First, deploy this button and set its name as an export for later reference:

```
export HEROKU_APP=wh-demo-consumer
```

Create another app that we will be triggering events on:
```
heroku create wh-trigger-app
export TRIGGER_APP=wh-trigger-app
```

You'll need to install the CLI plugin first and opt your user into the webhooks beta:

```
heroku plugins:install heroku-webhooks
heroku sudo labs:enable webhooks-beta-user -u $your_email
```

Then create a webhook:

```
heroku webhooks:add --include api:release --url https://$HEROKU_APP.herokuapp.com/webhooks -s "$(heroku config:get WEBHOOK_SECRET)" -l sync -a $TRIGGER_APP
```

Open the webhooks consumer app:

```
h open
```

Trigger an event:

```
heroku config:set FOO=1 -a $TRIGGER_APP
```
