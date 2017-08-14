# elixir-pusher-clone-training
------------------------
Lesson 1, Setup Overview
-------------------------


git clone git@github.com:vulk/elixir-pusher-clone-training.git

-- check node
-- phoenix dependency
```
nvm list
```

-- check ruby
```
rvm list
```

-- switch version of ruby
```
rvm 2.2.3
```

-- check rails
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
--kiex list
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
rails -v
rails 4.2.5
rails new
copy gemfile

### for issues with gemfile see
```
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

----------
Lesson 3 
----------

cd into your main training directory

### elixir
```
*try mix phoenix.new ex_pusher_lite
mix new ex_pusher_lite
cd ex_pusher_lite
copy .gitignore
copy mix.exs
mix do deps.get, compile
copy config.exs
copy dev.exs
create/copy dev.secret.exs <copy just the repo config>
```

https://hexdocs.pm/phoenix/mix_tasks.html

```
mkdir web directory
mkdir web/controller directory
copy web/controller/events_controller.ex controller
copy web/router.ex router
copy web/gettext.ex
copy web/web.ex

mix compile

copy lib/ex_pusher_lite/endpoint.ex socket configuration
copy lib/ex_pusher_lite.ex supervisor

mix compile

copy web/channels/room_channel.ex channel 
copy web/channels/user_socket.ex socket
copy lib/ex_pusher_lite/repo.ex
```

### rails

```
edit /config/secrets.yml
edit app/models/pusher_event.rb model (add net http call)
mkdir app/jobs
copy app/jobs/send_events_job.rb job
edit events controller: add job call

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
edit app/assets/javascripts/application.js
copy config/initializers/babel.rb
edit Gemfile <include new sprocket code> 
```
test: go to url:port and enter a message, should receive message on the same screen with anyone connected to your url

--------
lesson 5, JWT Authorization
---------
### rails
```
copy app/helpers/guardian_helper.rb helper
edit app/models/pusher_event.rb model
edit app/assets/javascripts/application/pages/home/index.es6 <uncomment guardian code>
```
### elixir
```
edit mix.exs
edit config.exs
edit dev.secret.exs

mix do deps.get, compile

edit router.ex router

mix compile

edit events_controller.ex controller
edit user_socket.ex socket
edit room_channel.ex channel (take out guardian line in for lesson 3)
copy ex_pusher_lite/lib/ex_pusher_lite/guardian_serializer.ex
```
test: go to url:port and enter a message, open console, should see authentication error.
```
edit (rails) app/views/layouts/application.html.erb template (take out guard line for lesson 2) -- add guardian line
```
test: go to url:port and enter a message, should receive message.



### Special thanks to Fabio Akita at http://www.akitaonrails.com/ for the blog post on the pusher clone
