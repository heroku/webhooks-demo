# README

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/webhooks-consumer-demo)

After deploying, create a webhook:

```
git clone https://github.com/heroku/heroku-webhooks.git
h plugins:link heroku-webhooks
hs labs:enable webhooks-beta-user -u $your_email
h create wh-trigger-app
export HEROKU_APP=wh-demo-consumer
h webhooks:add --include api:release --url https://$HEROKU_APP.herokuapp.com/webhooks -s $(h config:get WEBHOOK_SECRET) -l sync -a wh-trigger-app
```

Open the app

```
h open
```

Trigger an event

```
h config:set FOO=1 -a wh-trigger-app
```
