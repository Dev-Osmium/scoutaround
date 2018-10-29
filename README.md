![Travis CI](https://travis-ci.com/goscoutaround/scoutaround.svg?branch=master)

# Overview

Scoutaround is built to help youth organizations (scouts, etc) manage their units.

# Getting Started

## Set up PostgreSQL

Install [PostgreSQL](https://www.postgresql.org/) locally and ensure you have a "postgres" user with a blank password (or, alternately, change your database.yml file to credentials to your liking). Then:

```
rake db:create
rake db:migrate
rake db:seed
```

## Set up environment variables

1. Create or access an AWS account
2. Create a storage bucket, making note of its name and region
3. Create an AWS IAM user, making note of its access key ID and secret access key
4. Create a [.env file](https://github.com/bkeepers/dotenv) in the project root containing S3_BUCKET, S3_REGION, S3_ACCESS_KEY_ID, and S3_SECRET_ACCESS_KEY values from steps 3 and 4

You'll also need to repeat this process for production, using your runtime infrastructure's preferred method for setting environment variables.

## Set up Redis

Certain asynchronous jobs (e.g. sending email) run on background workers via (Sidekiq)[https://github.com/mperham/sidekiq/wiki/Getting-Started] which, in turn, relies on Redis. You'll need Redis in all environments, local and hosted. To install Redis locally:

```
brew install redis
```

## Running the app locally

This presumes you have Ruby 2.4.2, Rails 5.1.6 or higher, and PostgreSQL installed. [RVM](http://rvm.io) is a good way to deal with Ruby versioning.

Alternately, use [ElephantSQL](https://elephantsql.com) for a shared dev database.

Once done:

```
bundle install
yarn install
foreman s
```

Then visit [http://localhost:5000](http://localhost:5000)

### Sending and receiving email locally

The app is configured to use [Mailcatcher](https://mailcatcher.me/) to send and receive on port 1025 on your dev machine. Install Mailcatcher:

```
gem install mailcatcher
```

Run it:

```
mailcatcher
```

Then visit [http://localhost:1080/](http://localhost:1080/)

### Profiling locally
The app is set up to use [Scout Devtrace](https://scoutapp.com/devtrace) locally. To use it:

```
SCOUT_DEV_TRACE=true foreman s
```

You'll see a speed badge in the lower left of the screen. Click it to see performance stats on each page load.

# Running tests

```
rspec
```

The app is configured to also use (Guard)[https://github.com/guard/guard-rspec], which continually runs your specs in real-time as you modify files. It beats the heck out of learning that your specs are broken right before you're trying to push something out the door. A good runtime environment is Foreman running in one Terminal tab, Guard in another, and a third tab for sundry console tasks (rails c, full rspecs, etc.). To run Guard:

```
bundle exec guard
```

# Deploying to Production

The app forces SSL in production. You can get free (!) certificates from [Let's Encrypt](https://letsencrypt.org). Many hosts (Heroku, Digital Ocean) can automate the fetching of certs for you. Having a cert implies, of course, that you have a domain.

## Proprietary Services

The commercial deployment of this app relies on third-party paid services (namely, [Cloud Typography](https://www.typography.com/cloud/welcome/) from Hoefler & Co., and [FontAwesome Pro](https://fontawesome.com/pro)). These services' scripts are stored in the HTTP_HEAD_INJECT environment variable. If you do nothing, the app works fine. If you want to use these services (or any others, for that matter), set the envvar thusly:

```
stylesheet_link_tag('https://cloud.typography.com/<stuff goes here>/css/fonts.css', media: 'all'); javascript_include_tag('https://pro.fontawesome.com/releases/v5.0.13/js/all.js', defer: 'defer', integrity: '<stuff goes here>', crossorigin: 'anonymous')
```

## Active Storage & Amazon S3

The app relies on Active Storage to store attachments; the app is set up for Amazon S3 although you could choose a different provider. Enabling Versioning on your production storage bucket is never a bad idea. You'll need to set the following environment variables in production for this to work:

- S3_BUCKET
- S3_REGION
- S3_ACCESS_KEY_ID
- S3_SECRET_ACCESS_KEY

You'll need to enable CORS on your bucket. Sample CORS policy:

```
<?xml version="1.0" encoding="UTF-8"?>
<CORSConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/">
<CORSRule>
    <AllowedOrigin>https://your.production.domain</AllowedOrigin>
    <AllowedMethod>GET</AllowedMethod>
    <AllowedMethod>POST</AllowedMethod>
    <AllowedMethod>PUT</AllowedMethod>
    <AllowedMethod>DELETE</AllowedMethod>
    <MaxAgeSeconds>3000</MaxAgeSeconds>
    <AllowedHeader>*</AllowedHeader>
</CORSRule>
</CORSConfiguration>
```

If you're deploying to Heroku and wish to leverage Active Storage previews for thumbnails, you'll need to add the appropriate binaries to your Heroku project. From the command line via the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli):

```
heroku buildpacks:add -i 1 https://github.com/heroku/heroku-buildpack-active-storage-preview
```

## Cron Jobs

A number of automated tasks occur in the background. You'll need to set up a cron or scheduler to run these rake tasks (typically daily):

rake scoutaround:magic_links:send_unredeemed_notifications
rake scoutaround:magic_links:purge
rake scoutaround:events:youth_reminders
rake scoutaround:events:guardian_reminders
rake scoutaround:events:adult_reminders
rake scoutaround:advancement:nag_idle_advancers

## Stripe

Scoutaround uses [Stripe](https://stripe.com) to facilitate payments. You'll need to establish a [Stripe Connect](https://stripe.com/docs/connect) account. To test with Stripe, plug your test credentials into your local .env file (see below). Here are some phony but valid credit card numbers to test with:

| Number              | Brand                 |
| ------------------- | --------------------- |
| 4242424242424242    | Visa                  |
| 4000056655665556    | Visa (debit)          |
| 5555555555554444    | Mastercard            |
| 2223003122003222    | Mastercard (2-series) |
| 5200828282828210    | Mastercard (debit)    |
| 5105105105105100    | Mastercard (prepaid)  |
| 378282246310005     | American Express      |
| 371449635398431     | American Express      |
| 6011111111111117    | Discover              |
| 6011000990139424    | Discover              |
| 30569309025904      | Diners Club           |
| 38520000023237      | Diners Club           |
| 3566002020360505    | JCB                   |
| 6200000000000005    | UnionPay              |

## Sendgrid

The app is configured to use (Sendgrid)[https://sendgrid.com] to send email. You'll need your own Sendgrid account and credentials set in environment variables.

## Environment Variables

- MIXPANEL_TOKEN
- S3_BUCKET
- S3_REGION
- S3_ACCESS_KEY_ID
- S3_SECRET_ACCESS_KEY
- SKYLIGHT_TOKEN
- STRIPE_CONNECT_CLIENT_ID
- STRIPE_SECRET_KEY
- STRIPE_PUBLISHABLE_KEY
- SENDGRID_USERNAME
- SENDGRID_PASSWORD
- API_USERNAME
- API_PASSWORD

## Copy production database to staging:

See https://stackoverflow.com/questions/10673630/how-do-i-transfer-production-database-to-staging-on-heroku-using-pgbackups-gett

# turn off the web dynos in staging
heroku maintenance:on -a yourapp-staging

# if you have non-web-dynos, do them too
heroku ps:scale worker=0 -a yourapp-staging

# backup the staging database if you are paranoid like me (optional)
heroku pg:backups capture -a yourapp-staging

# execute the copy
heroku pg:copy your-app::DATABASE_URL DATABASE_URL -a yourapp-staging


