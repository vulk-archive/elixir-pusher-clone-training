# elixir-pusher-clone-training
------------------------
Useful comparisons
------------------------
https://hexdocs.pm/phoenix/channels.html
https://github.com/dsander/phoenix-connection-benchmark
https://pusher.com/pricing
https://www.digitalocean.com/pricing/

------------------------
Prerequisites 
------------------------
See https://gist.github.com/wavell/0411d52a69f03546f712b47596dd5ca4

------------------------
Lesson 1, Setup Overview
-------------------------

git clone git@github.com:vulk/elixir-pusher-clone-training.git

-- check node 
```
nvm list
nvm use v6.0.0
```

-- check ruby
```
rvm list
```

-- switch version of ruby
```
rvm use 2.2.3
```

-- check rails -- use rails 4.2.5
```
rails -v ```

-- check erlang
```
kerl list builds
```

-- switch version erlang
```
kerl install 18.0
. <yourworkingdirectory>/activate
```

check elixir
```
kiex list
```

-- switch version of elixir
```
kiex use 1.4.5
```

test:
```
iex
```
--------------- 
Lesson 2 -- Create a legacy rails app
---------------

```
rails new pusher_lite_demo
cd pusher_lite_demo
# add enviroment, background job, styling, javascript helpers, production web server
copy gemfile

```
### For issues with gemfile see
https://github.com/rails/sprockets-rails/issues/291

```
bundle update

###### 1. plain old ruby object for message management
copy app/models/pusher_event.rb model
###### 2. landing page
rails g controller home
copy app/controllers/home_controller.rb controller
rails g controller events
copy app/controllers/events_controller.rb controller contents
###### 3. wrapper for all html
copy views/layouts/application.html.erb template
###### 4. form for posting
copy app/views/home/index.html.erb template
###### 5. sets focus
copy app/views/events/create.js.erb template
###### 6. styling
delete app/assets/stylesheets/application.css  
delete app/assets/stylesheets/events.scss  
delete app/assets/stylesheets/home.css  
copy app/assets/stylesheets/purecss.scss styles 
copy app/assets/stylesheets/application.scss styles 
###### 7. secrets for use later on
copy .env.example into .env 
###### 8. dont save the secrets in git
copy .gitignore
###### 9. precompile
copy pusher_lite_demo/config/initializers/assets.rb
###### 10. secret helper
copy pusher_lite_demo/config/initializers/pusher_lite.rb
###### 11. router to landing page
copy pusher_lite_demo/config/routes.rb
delete app/assets/javascripts/events.coffee
delete app/assets/javascripts/home.coffee

. .env; rails s -p $PORT -b 0.0.0.0 
```
Test: go to url:port and enter a message, check rails log

----------
Lesson 3 Create Elixir Application and call it from Rails
----------

cd into your main training directory

### elixir
Go to main directory (up one from your rails project)
```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new ex_pusher_lite --no-brunch --no-ecto
cd ex_pusher_lite
# exclude erlang, dependencies, and secrets from git
copy .gitignore
# upgrade phoenix, include some dependencies
copy mix.exs
# get dependencies
mix do deps.get, compile
# accept a port number from the command line
copy dev.exs 

```
-- List of mix tasks

https://hexdocs.pm/phoenix/mix_tasks.html

```
# create an endpoint that accepts messages 
mix phoenix.gen.json Events events --no-context --no-model --no-schema
copy web/controller/events_controller.ex controller
# add end point to the router
copy web/router.ex router  
# create a web socket to relay messages
mix phoenix.gen.channel Room 
copy web/channels/user_socket.ex socket
# setup our channel with a public topic
copy web/channels/room_channel.ex socket
mix compile
```

### rails

```
cd <into your rails directory>
# update rails secrets to look for our env variable
edit /config/secrets.yml
# call the elixir messaging endpoint
edit app/models/pusher_event.rb model (add net http call)
# create a background job for sending our messages, to prevent blocking
rails g job send_events 
copy app/jobs/send_events_job.rb job
# call our background job
edit web/controller/events_controller.ex controller

cd <your elixir directory>
. .env; PORT=4503 iex -S mix phoenix.server 
# in new session ..
cd <your rails directory>
. .env; rails s -p $PORT -b 0.0.0.0
```
Test: go to url:port and enter a message, check rails *and* elixir log

------------
Lesson 4 Enable web sockets
-----------
### rails

http://nandovieira.com/using-es2015-with-asset-pipeline-on-ruby-on-rails

https://github.com/rails/sprockets/issues/156
```
# Set up the asset pipeline to transpile es6 into es5
copy app/assets/config/manifest.js
edit app/assets/javascripts/application.js << redundant, but need this 
# Include the phoenix javascript
copy app/assets/javascripts/phoenix.es6
copy app/assets/javascripts/application/boot.es6
# Enable the websocket without authentication and start listening for messages
copy app/assets/javascripts/application/pages/home/index.es6 
# Configure babel for the transpile of es6 to es5
copy config/initializers/babel.rb
# Enable new sprockets for es6 transpile
edit Gemfile <include new sprocket code> 
bundle update
```
Test: go to url:port and enter a message, should receive message on the same screen with anyone connected to your url

--------
Lesson 5, JWT Authorization
---------
### rails
```
# Create a jwt token utility
rails g helper guardian
copy app/helpers/guardian_helper.rb helper
# Call elixir with a jwt token
edit app/models/pusher_event.rb model
# Make front end pass jwt token when establishing web socket
edit app/assets/javascripts/application/pages/home/index.es6 <uncomment guardian code>
```
### elixir
```
# Include guardian in elixir
edit mix.exs
# configure guardian
edit config.exs
# create a jwt secret
copy dev.secret.exs 
# import our secret
edit dev.exs << add import config

mix do deps.get, compile

# Force message post to require a jwt token
edit router.ex router
# Enable guardian
edit events_controller.ex controller
# Enable guardian
edit user_socket.ex socket
# Use guardian to inspect claims for topics
edit room_channel.ex channel 
# Configure guardian (requirement but unused)
copy ex_pusher_lite/lib/ex_pusher_lite/guardian_serializer.ex
# restart phoenix and rails
```
test: go to url:port and enter a message, open console, should see authentication error.
```
# add guardian tags, provided in guardian helper 
edit (rails) app/views/layouts/application.html.erb template -- add guardian line
```
test: go to url:port and enter a message, should receive message.



### Special thanks to Fabio Akita at http://www.akitaonrails.com/ for the blog post on the pusher clone
