require "pg"
require "crecto"

module Repo
  extend Crecto::Repo

  ENV["HOST"] ||= "localhost"
  ENV["PORT"] ||= "5432"

  # TODO: Update this to work in different environments
  config do |conf|
    conf.adapter = Crecto::Adapters::Postgres
    conf.database = "crystallizer"
    conf.hostname = ENV["HOST"]
    conf.username = ENV["DBUSER"]
    conf.password = ENV["DBPASS"]
    conf.port = ENV["PORT"].to_i
  end
end
