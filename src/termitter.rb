require 'rubygems'
require 'twitter_oauth'

class Termitter
  VERSION = "2010.11.16"
  
  def initialize(consumer_key, consumer_secret)
    @consumer_key = consumer_key
    @consumer_secret = consumer_secret
    @auth_file = File.join(ENV['HOME'], ".termitter.oauth")
  end

  def run
    client = authenticate
    timeline = client.home_timeline.map do |t| 
      "#{t["user"]["screen_name"]}: #{t["text"].gsub("\n", " ")}"
    end

    puts timeline.join("\n")
  rescue SocketError
    $stderr.puts "Could not connect to Twitter"
    exit
  end

  def authenticate
    access_token, access_secret = File.read(@auth_file).split("\n").map{|l| l.strip}
    client = TwitterOAuth::Client.new(
                                      :consumer_key => @consumer_key,
                                      :consumer_secret => @consumer_secret,
                                      :token => access_token,
                                      :secret => access_secret
                                      )
    client
  rescue
    authorize
  end

  def authorize
    client = TwitterOAuth::Client.new(
                                      :consumer_key => @consumer_key,
                                      :consumer_secret => @consumer_secret
                                      )
    request_token = client.request_token()
    puts "Please follow the URL below to authorize the application"
    puts request_token.authorize_url
    puts "Please enter the PIN below and press enter"
    pin = STDIN.readline.chomp
    
    access_token = client.authorize(
                                    request_token.token,
                                    request_token.secret,
                                    {:oauth_verifier => pin}
                                    )
    
    puts "Verification complete!"

    File.open(@auth_file, "w") {|f| f.write("#{access_token.token}\n#{access_token.secret}") }
    
    client
  rescue SocketError
    $stderr.puts "Could not connect to twitter."
    exit
  rescue
    $stderr.puts "Verification failed."
    exit
  end
end
