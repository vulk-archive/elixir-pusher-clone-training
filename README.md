# elixir-pusher-clone-training
------------------------
Lesson 1, Setup Overview
-------------------------


git clone git@github.com:vulk/elixir-pusher-clone-training.git

-- check node
-- phoenix dependency
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
rails -v
```

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
Lesson 2
---------------

```
rails new pusher_lite_demo
copy gemfile


```
### for issues with gemfile see
https://github.com/rails/sprockets-rails/issues/291

```

bundle update
copy app/models/pusher_event.rb model
rails g controller home
copy app/controllers/home_controller.rb controller
rails g controller events
copy app/controllers/events_controller.rb controller contents
copy views/layouts/application.html.erb template
copy app/views/home/index.html.erb template
copy app/views/events/create.js.erb temmplate
delete app/assets/stylesheets/application.css  
delete app/assets/stylesheets/events.scss  
delete app/assets/stylesheets/home.css  
copy app/assets/stylesheets/purecss.scss styles 
copy app/assets/stylesheets/application.scss styles 
copy .env.example into .env 
setup .env file
copy .gitignore
copy pusher_lite_demo/config/initializers/assets.rb
copy pusher_lite_demo/config/initializers/pusher_lite.rb
copy pusher_lite_demo/config/routes.rb
delete app/assets/javascripts/events.coffee
delete app/assets/javascripts/home.coffee

. .env; rails s -p $PORT -b 0.0.0.0 
```
test: go to url:port and enter a message, check rails log

----------
Lesson 3 
----------

cd into your main training directory

### elixir
```
mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez
mix phoenix.new ex_pusher_lite --no-brunch --no-ecto
cd ex_pusher_lite
copy .gitignore
copy mix.exs
mix do deps.get, compile
copy dev.exs 
```

https://hexdocs.pm/phoenix/mix_tasks.html

```
mix phoenix.gen.json Events events --no-context --no-model --no-schema
copy web/controller/events_controller.ex controller
copy web/router.ex router
mix phoenix.gen.channel Room 
copy web/channels/user_socket.ex socket
mix compile
```

### rails

```
edit /config/secrets.yml
edit app/models/pusher_event.rb model (add net http call)
rails g job send_events 
copy app/jobs/send_events_job.rb job
edit web/controller/events_controller.ex controller

. .env; PORT=4503 iex -S mix phoenix.server 
. .env; rails s -p $PORT -b 0.0.0.0
```
test: go to url:port and enter a message, check rails *and* elixir log

------------
Lesson 4
-----------
### rails

http://nandovieira.com/using-es2015-with-asset-pipeline-on-ruby-on-rails

https://github.com/rails/sprockets/issues/156
```
copy app/assets/config/manifest.js
copy app/assets/javascripts/phoenix.es6
copy app/assets/javascripts/application/boot.es6
copy app/assets/javascripts/application/pages/home/index.es6 
edit app/assets/javascripts/application.js << redundant, but need this 
copy config/initializers/babel.rb
edit Gemfile <include new sprocket code> 
bundle update
```
test: go to url:port and enter a message, should receive message on the same screen with anyone connected to your url

--------
lesson 5, JWT Authorization
---------
### rails
```
rails g helper guardian
copy app/helpers/guardian_helper.rb helper
edit app/models/pusher_event.rb model
edit app/assets/javascripts/application/pages/home/index.es6 <uncomment guardian code>
```
### elixir
```
edit mix.exs
edit config.exs
edit dev.exs << add import config
edit dev.secret.exs << remove repo lines

mix do deps.get, compile

edit router.ex router
edit events_controller.ex controller
edit user_socket.ex socket
edit room_channel.ex channel 
copy ex_pusher_lite/lib/ex_pusher_lite/guardian_serializer.ex
```
test: go to url:port and enter a message, open console, should see authentication error.
```
edit (rails) app/views/layouts/application.html.erb template (take out guard line for lesson 2) -- add guardian line
```
test: go to url:port and enter a message, should receive message.



### Special thanks to Fabio Akita at http://www.akitaonrails.com/ for the blog post on the pusher clone
