## README

This is __Interview Management System__, please follow the instruction below to install system.

### Install

1. clone project

	`git clone git@github.com:orbasteam/ims.git`

2. bundle

	`bundle install`

3. copy config

	`cp /path/to/ims/config/database.sample.yml /path/to/ims/config/database.yml`

	`cp /path/to/ims/config/secrets.sample.yml /path/to/ims/config/secrets.yml`

	`cp /path/to/ims/config/settings/development.sample.yml /path/to/ims/config/development.yml`

4. modify your config

5. db migration

	`rake db:create`

	`rake db:schema:load`

	`rake db:seed`

6. start server

	`rails server`

7. then open browser and go to localhost:3000, enter the email `admin@example.com` and password `admin12345678` that we just added.
