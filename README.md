# elixir-pusher-clone-training

Lesson 1, setup overview

node
ruby/rails
erlang
elixir

test: iex

----------
lesson 2
---------------

rails -v
rails 4.2.5
rails new
copy gemfile
bundle
rails g controller home
https://github.com/rails/sprockets-rails/issues/291
copy home.rb controller
rails g controller events
copy events.rb controller contents
copy application.html.erb template
copy index.html.erb template
copy create.js.erb temmplate
copy app/assets/stylesheets/application.scss css 
copy app/assets/stylesheets/purecss.scss css
delete app/assets/stylesheets/application.css  
setup .env file
copy .gitignore
setup initializer
copy pusher_lite_demo/config/initializers/assets.rb
copy pusher_lite_demo/config/initializers/pusher_lite.rb
copy pusher_lite_demo/config/routes.rb
delete .coffeescripts

. .env; ^Cils s -p $PORT -b 0.0.0.0 

----------
lesson 3 
---------

kerl install 18.0
. /home/pair/src/watson/pusher-clone/activate
erl -v <check if version 18.0>
kiex use 1.4.5
iex <checking if elixir works>

-- elixir
mix new ex_pusher_lite
copy .gitignore
cd ex_pusher_lite
copy mix.exs
mix do deps.get, compile
copy config.exs
copy dev.exs
create/copy dev.secret.exs


https://hexdocs.pm/phoenix/mix_tasks.html

mkdir web directory
mdir web/controller directory
copy web/controllerevents_controller.ex controller
copy web/router.ex router
copy web/gettext.ex

mix compile

copy lib/ex_pusher_lite/endpoint.ex socket configuration
copy lib/ex_pusher_lite.ex supervisor

mix compile

-- skipped -- copy app_controller.ex controller
copy room_channel.ex channel 
copy user_socket.ex socket
copy lib/ex_pusher_lite/repo.ex


-- rails

edit /config/secrets.yml
edit pusher_event.rb model (add net http call)
mkdir app/jobs
copy send_events_job.rb job
edit events controller: add job call

. .env; PORT=4503 iex -S mix phoenix.server 
. .env; rails s -p $PORT -b 0.0.0.0

test: go to url:port and enter a message, check rails *and* elixir log


--- lesson 4

-- rails

http://nandovieira.com/using-es2015-with-asset-pipeline-on-ruby-on-rails
https://github.com/rails/sprockets/issues/156

copy app/assets/config/manifest.js
copy app/assets/javascripts/phoenix.es6
copy app/assets/javascripts/application/boot.es6
copy app/assets/javascripts/application/pages/home/index.es6 
edit app/assets/javascripts/application.js
copy config/initializers/babel.rb

test: go to url:port and enter a message, should receive message on the same screen with anyone connected to your url

--------

lesson 5, JWT Authorization

-- rails

copy app/helpers/guardian_helper.rb helper
edit pusher_event.rb model
edit application.html.erb template

-- elixir

edit mix.exs
edit config.exs
edit dev.secret.exs

mix do deps.get, compile

edit router.ex router

mix compile

edit events_controller.ex controller
edit user_socket.ex socket
edit room_channel.ex channel (take out guardian line in for lesson 3)
ex_pusher_lite/lib/ex_pusher_lite/guardian_serializer.ex

test: go to url:port and enter a message, open console, should see authentication error.

edit application.html.erb template (take out guard line for lesson 2) -- add guardian line

test: go to url:port and enter a message, should receive message.
