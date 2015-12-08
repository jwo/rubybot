require 'slack-ruby-bot'

module RubyBot
  class App < SlackRubyBot::App
  end

  class Hiiii < SlackRubyBot::Commands::Base
    command 'hi' do |client, data, _match|
      client.message text: 'hiiiiiiiiiiii', channel: data.channel
    end
  end
end

RubyBot::App.instance.run
