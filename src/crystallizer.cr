require "../db/repos/*"
require "../db/models/*"
require "./crystallizer/*"
require "kemal"
require "kemal-session"
require "db"
require "pg"
require "crecto"

# TODO:
# 1) Add support for voting system & karma.
# 2) Add comment support.
# 3) Add single display Flash support
# 4) Form elements need `name` attribute specified
# 5) Don't store passwords as plain text

module Crystallizer
  # TODO Put your code here
end

# TODO: make this better
Kemal::Session.config do |config|
	config.secret = "mysecret"
	config.cookie_name = "crystallizer_session"
	config.gc_interval = 2.minutes
	config.timeout = Time::Span.new(7,0,0,0) # Session expires after 1 week
end

before_all "/**" do |env|
	env.session.string("test", "this is test")
	env.session.string("user", "jseeley")
	#pp env.request.cookies["crystallizer_session"]
	#pp env
	#unless env.request.cookies["crystallizer_session"].has_key?("user")
	#unless env.request.cookies.has_key?("user")
		#env.response.cookies << HTTP::Cookie.new("user", "jseeley")
	#end

	#puts "test before_all"
end

get "/" do |env|
	#env.session.string("user")
  env.redirect "/latest"
end

get "/latest" do |env|
  render "src/views/posts.ecr", "src/views/layouts/layout.ecr"
end

#get "/:name" do |env|
  #name = env.params.url["name"]
  #render "src/views/hello.ecr", "src/views/layouts/layout.ecr"
#end

get "/register" do |env|
  render "src/views/register.ecr", "src/views/layouts/register.ecr"
end

post "/register" do |env|
  #pp env.params.body["inputSubscribed"]

  begin
    user = User.new
    user.login = env.params.body["inputLogin"]
    user.email = env.params.body["inputEmail"]
    user.password = env.params.body["inputPassword"]
    user.subscribed = env.params.body["inputSubscribed"] ? true : false

    changeset = Repo.insert(user)
  rescue ex
    if /.+email_key.+/ =~ ex.message
      puts "WE ARE HERE"
      # TODO: Add support for recovering forgotten passwords
      env.session.string("flash", "That email address is already in use.")
      env.redirect "/register"
    else
      puts "WTF?!"
      pp ex.message
    end
  end

end

get "/login" do |env|
  begin
    # TODO: This is only a test

    user = User.new
    user.email = "testuser@crystallizer.com"
    user.password = "password"

    changeset =  Repo.insert(user)
    puts changeset.errors
    #puts changeset.valid?

    #end 

    render "src/views/login.ecr", "src/views/layouts/register.ecr"
  rescue ex
    if /duplicate\skey\svalue\sviolates\sunique\sconstraint.+$/ =~ ex.message
    else
      puts "Oh shit; this is unexpected..."
      puts ex.message
    end
  end
end

post "/login" do |env|

end

get "/submission" do |env|
  render "src/views/submission.ecr", "src/views/layouts/register.ecr"
end

post "/submission" do |env|
end

post "/submitpage" do |env|
  #pp env
  #i = 1
  env.params.body["firstname"]
end
Kemal.run
