#!/usr/bin/env ruby

require_relative 'easygpio.rb'
require 'yaml'

DELAY = ARGV[0].to_f
MORSE = YAML.load(File.open("morse.yaml", "rb").read)

def morse(text, speed, output) 
  m = text.upcase.chars.map { |c| MORSE[c] }.join " "

  puts m

  m.chars.each do |c|
    case c
      when "." then output.call:on; sleep speed; output.call:off; sleep speed
      when "-" then output.call:on; sleep speed * 3; output.call:off; sleep speed
      when " " then sleep speed * 2
    end
  end
end

MENU = ["twitter", "fortune", "speed"]

gpio(
  buzzer:   +12,
  btn_left: -13,
  btn_right: -6
) do 

  #morse("twitter fortune speed", 0.2, method(:buzzer))
  #sleep 10
  
  loop do
    if btn_right?
      morse `fortune`, DELAY, (method :buzzer)
    end
    sleep 0.1
  end

      # ARGF.each_line do |e|
        # # # morse e, 0.2, (method :buzzer)
      # # # end
  # morse("hi chris", 0.2, self)

=begin
  loop do

    buzzer btn_right?

    if btn_left?
      buzzer:on
      sleep DELAY
      if [true, false].sample
        sleep DELAY * 2
      end
      buzzer:off
      sleep DELAY
      if [true, false].sample
        sleep DELAY * 2
      end
    end
  end
=end

end
