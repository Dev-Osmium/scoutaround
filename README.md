![Travis CI](https://travis-ci.com/goscoutaround/scoutaround.svg?branch=master)

# Overview

Scoutaround is built to help youth organizations (scouts, etc) manage their units.

# Getting Started

## Set up PostgreSQL

Install [PostgreSQL](https://www.postgresql.org/) locally and ensure you have a "dev" user with a blank password (or, alternately, change your database.yml file). Then:

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

## Running the app locally

This presumes you have Ruby 2.4.2, Rails 5.1.6 or higher, and PostgreSQL installed. [RVM](http://rvm.io) is a good way to deal with Ruby versioning.

Once done:

```
bundle install
foreman s
```

Then visit [http://localhost:5000](http://localhost:5000)

# Running tests

```
rspec
```

# Deploying to Production

The app forces SSL in production. You can get free (!) certificates from [Let's Encrypt](https://letsencrypt.org). Many hosts (Heroku, Digital Ocean) can automate the fetching of certs for you. Having a cert implies, of course, that you have a domain.

## Proprietary Services

The commercial deployment of this app relies on third-party paid services (namely, [Cloud Typography](https://www.typography.com/cloud/welcome/) from Hoefler & Co., and [FontAwesome Pro](https://fontawesome.com/pro)). These services' scripts are stored in the HTTP_HEAD_INJECT environment variable. If you do nothing, the app works fine. If you want to use these services (or any others, for that matter), set the envvar thusly:

```
stylesheet_link_tag('https://cloud.typography.com/<stuff goes here>/css/fonts.css', media: 'all'); javascript_include_tag('https://pro.fontawesome.com/releases/v5.0.13/js/all.js', defer: 'defer', integrity: '<stuff goes here>', crossorigin: 'anonymous')
```
