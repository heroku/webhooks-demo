# README

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/webhooks-consumer-demo)

After deploying, create a webhook:

```
heroku plugins:install heroku-webhooks
heroku sudo labs:enable webhooks-beta-user -u $your_email
heroku create wh-trigger-app
export HEROKU_APP=wh-demo-consumer
heroku webhooks:add --include api:release --url https://$HEROKU_APP.herokuapp.com/webhooks -s $(h config:get WEBHOOK_SECRET) -l sync -a wh-trigger-app
```

Open the app

```
h open
```

Trigger an event

```
heroku config:set FOO=1 -a wh-trigger-app
```
