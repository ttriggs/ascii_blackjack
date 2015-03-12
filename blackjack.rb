#!/usr/bin/env ruby
require_relative 'card'
require_relative 'deck'
require_relative 'game'
require_relative 'hand'
require 'colorize'

splash = <<EOS
 _______  ___      _______  _______  ___   _      ___  _______  _______  ___   _  __
|  _    ||   |    |   _   ||       ||   | | |    |   ||   _   ||       ||   | | ||  |
| |_|   ||   |    |  |_|  ||       ||   |_| |    |   ||  |_|  ||       ||   |_| ||  |
|       ||   |    |       ||       ||      _|    |   ||       ||       ||      _||  |
|  _   | |   |___ |       ||      _||     |_  ___|   ||       ||      _||     |_ |__|
| |_|   ||       ||   _   ||     |_ |    _  ||       ||   _   ||     |_ |    _  | __
|_______||_______||__| |__||_______||___| |_||_______||__| |__||_______||___| |_||__|
EOS
puts
puts
puts "It's time for sooooommmmme"
puts "#{splash}".green

# run the game!
game = Game.new
game.play
