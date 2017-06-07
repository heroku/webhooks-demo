# README

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/heroku/webhooks-consumer-demo)

After deploying, create a webhook:

```
git clone https://github.com/heroku/heroku-webhooks.git
h plugins:link heroku-webhooks
hs labs:enable webhooks-beta-user -u mhale@heroku.com
export HEROKU_APP=mhale-wh-demo
h webhooks:add --include api:release --url https://$HEROKU_APP.herokuapp.com/webhooks -s $(h config:get WEBHOOK_SECRET) -l sync
```

Open the app

```
h open
```

Trigger an event

```
h config:set FOO=1
```
