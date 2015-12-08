require 'slack-ruby-bot'
Dotenv.load
Wolfram.appid= ENV["WOLFRAM_APPID"]
require 'uri'

module RubyBot
  class App < SlackRubyBot::App
  end

  class Hiiii < SlackRubyBot::Commands::Base
    command 'hi' do |client, data, _match|
      client.message text: 'hiiiiiiiiiiii', channel: data.channel
    end
  end


  class WolframSearch < SlackRubyBot::Commands::Base


    command 'wolf' do |client, data, _match|

      q = _match[:expression]
      result = Wolfram::Query.new(q).fetch
      hash = Wolfram::HashPresenter.new(result).to_hash

      result = ""

      hash.fetch(:pods, {}).each do |key, values|
        next if values.join("") == ""
        result << "\n" + key + "\n"
        result << values.join("\n")
      end

      if result != ""
        client.message text: result, channel: data.channel
      else
        client.message text: "
          No results found for #{q}. \n
          Try https://duckduckgo.com/?q=#{URI.escape(q)}+!google",
          channel: data.channel
      end

    end
  end
end

RubyBot::App.instance.run
