# Elixir Pusher Clone Training
github.com/wavell @elementwatson
------------------------
Useful comparisons
------------------------
1. https://hexdocs.pm/phoenix/channels.html
2. https://github.com/dsander/phoenix-connection-benchmark
3. https://pusher.com/pricing
4. https://www.digitalocean.com/pricing/

------------------------
Prerequisites -- Set up ubuntu
------------------------
See https://gist.github.com/wavell/0411d52a69f03546f712b47596dd5ca4
### Before you start
###### Cd into your training directory
###### Start tmux so we can assist you 
```
tmux
```
###### 
------------------------
Lesson 1, Setup Overview
-------------------------

git clone https://github.com/vulk/elixir-pusher-clone-training.git

###### 1. Check node 
```
nvm list
nvm use v6.0.0
```
If issues ...
```
 export NVM_DIR="$HOME/.nvm"
 [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
 [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```
###### 2. Check ruby
```
rvm list
```
###### 3. Switch version of ruby
```
rvm use 2.2.3
```
###### 4. Check rails -- use rails 4.2.5
```
rails -v 
```
###### 5. Check erlang
```
kerl list builds
```
###### 6. Switch version erlang
```
kerl install 18.0 18.0
. 18.0/activate  
```
###### 7. Check elixir
```
kiex list
```
###### 8. Switch version of elixir
```
kiex use 1.4.5
```
###### 9. Test
```
iex
```
--------------- 
Lesson 2, Create a legacy rails app
---------------


###### 1. Generate the rails application
```
rails new pusher_lite_demo
cd pusher_lite_demo
```
###### 2. Add ruby enviroment, background job, styling, javascript helpers, production web server
copy gemfile

###### For issues with gemfile see
https://github.com/rails/sprockets-rails/issues/291

```
bundle update
rake rails:update:bin #to fix problems with a cloned machine -- overwrite all
```
###### 3. Plain old ruby object for message management
copy app/models/pusher_event.rb model
###### 4. Landing page
```
rails g controller home
```
copy app/controllers/home_controller.rb controller
```
rails g controller events
```
copy app/controllers/events_controller.rb controller contents
###### 5. Wrapper for all html
copy views/layouts/application.html.erb template
###### 6. Form for posting
copy app/views/home/index.html.erb template
###### 7. Sets focus
copy app/views/events/create.js.erb template
###### 8. Styling
delete app/assets/stylesheets/application.css   
delete app/assets/stylesheets/events.scss   
delete app/assets/stylesheets/home.css   
delete app/assets/javascripts/events.coffee  
delete app/assets/javascripts/home.coffee  
copy app/assets/stylesheets/purecss.scss styles   
copy app/assets/stylesheets/application.scss styles  

###### 9. Secrets for use later on
copy .env.example into .env 
###### 10. Dont save the secrets in git
copy .gitignore
###### 11. Precompile
copy pusher_lite_demo/config/initializers/assets.rb
###### 12. Secret helper
copy pusher_lite_demo/config/initializers/pusher_lite.rb
###### 13. Router to landing page
copy pusher_lite_demo/config/routes.rb
```
. .env; rails s -p $PORT -b 0.0.0.0 
```
###### 14. Test: go to url:port and enter a message, check rails log

----------
Lesson 3, Create Elixir Application and call it from Rails
----------

### Elixir
###### 1. Change into your main training directory

###### 2. Generate the phoenix application
```
mix phoenix.new ex_pusher_lite --no-brunch --no-ecto
cd ex_pusher_lite
```
###### 3. Exclude erlang, dependencies, and secrets from git
copy .gitignore
###### 4. Upgrade phoenix, include some dependencies
copy mix.exs
###### 5. Get dependencies
```
mix do deps.get, compile
```
###### 6. Accept a port number from the command line
copy dev.exs 

```
-- List of mix tasks for reference

https://hexdocs.pm/phoenix/mix_tasks.html

```
###### 7. Create an endpoint that accepts messages 
```
mix phoenix.gen.json Events events --no-context --no-model --no-schema
```
copy web/controller/events_controller.ex controller
###### 8. Add end point to the router
copy web/router.ex router  
###### 9. Create a web socket to relay messages
```
mix phoenix.gen.channel Room
```
copy web/channels/user_socket.ex socket
###### 10. Setup our channel with a public topic
copy web/channels/room_channel.ex socket
```
mix compile
```

### Rails


###### 1. Change into your rails directory>
###### 2. Update rails secrets to look for our env variable
edit /config/secrets.yml
###### 3. Call the elixir messaging endpoint
edit app/models/pusher_event.rb model (add net http call)
###### 4. Create a background job for sending our messages, to prevent blocking
```
rails g job send_events 
```
copy app/jobs/send_events_job.rb job
###### 5. Call our background job
edit web/controller/events_controller.ex controller

###### 6. Change into your elixir directory
```
. .env; PORT=<yourport> iex -S mix phoenix.server 
```
###### 7. Start a new session ...
###### 8. Change into your rails directory
```
. .env; rails s -p $PORT -b 0.0.0.0
```
###### 9. Test: go to url:port and enter a message, check rails *and* elixir log

------------
Lesson 4, Enable web sockets
-----------
### Rails

http://nandovieira.com/using-es2015-with-asset-pipeline-on-ruby-on-rails

https://github.com/rails/sprockets/issues/156

###### 1. Set up the asset pipeline to transpile es6 into es5
copy app/assets/config/manifest.js

edit app/assets/javascripts/application.js << redundant, but need this 

###### 2 Include the phoenix javascript
copy app/assets/javascripts/phoenix.es6

copy app/assets/javascripts/application/boot.es6

###### 3. Enable the websocket without authentication and start listening for messages
copy app/assets/javascripts/application/pages/home/index.es6 
###### 4. Configure babel for the transpile of es6 to es5
copy config/initializers/babel.rb
###### 5. Enable new sprockets for es6 transpile
edit Gemfile <include new sprocket code> 
```
bundle update
```
###### 6. Test: go to url:port and enter a message, should receive message on the same screen with anyone connected to your url

--------
Lesson 5, JWT Authorization
---------
### Rails

###### 1. Create a jwt token utility
rails g helper guardian
copy app/helpers/guardian_helper.rb helper
###### 2. Call elixir with a jwt token
edit app/models/pusher_event.rb model
###### 3. Make front end pass jwt token when establishing web socket
edit app/assets/javascripts/application/pages/home/index.es6 <uncomment guardian code>

### Elixir

###### 4. Include guardian in elixir
edit mix.exs
###### 5. Configure guardian
edit config.exs
###### 6. Create a jwt secret
copy dev.secret.exs 
###### 7. Import our secret
edit dev.exs << add import config
```
mix do deps.get, compile
```

###### 8. Force message post to require a jwt token
edit router.ex router
###### 9. Enable guardian
edit events_controller.ex controller
###### 10. Enable guardian
edit user_socket.ex socket
###### 11. Use guardian to inspect claims for topics
edit room_channel.ex channel 
###### 12. Configure guardian (requirement but unused)
copy ex_pusher_lite/lib/ex_pusher_lite/guardian_serializer.ex
###### 13. Restart phoenix and rails

###### 14. Test: go to url:port and enter a message, open console, should see authentication error.

###### 15. Add guardian tags, provided in guardian helper 
edit (rails) app/views/layouts/application.html.erb template -- add guardian line

###### 16. Test: go to url:port and enter a message, should receive message.


[![Rails/Elixir Pusher Clone](https://img.youtube.com/vi/yckhyKSW58U/0.jpg)](https://www.youtube.com/watch?v=yckhyKSW58U)


### Special thanks to Fabio Akita at http://www.akitaonrails.com/ for the blog post on the pusher clone
### Thanks also to: 
Krista https://github.com/Rystakei
Josh https://github.com/nupejosh
Taylor https://github.com/taylor
