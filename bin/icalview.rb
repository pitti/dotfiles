#!/usr/bin/env ruby

require "rubygems" # apt-get install rubygems
require "icalendar" # gem install icalendar
require "date"

class DateTime
  def myformat
    (self.offset == 0 ? (DateTime.parse(self.strftime("%a %b %d %Y, %H:%M ") + self.icalendar_tzid)) : self).
        new_offset(Rational(Time.now.utc_offset - 60*60, 24*60*60)).strftime("%a %b %d %Y, %H:%M")
        # - 60*60 to compensate for icalendar gem/Outlook mismatch
  end

  def good_format
    self.strftime("%a %b %d %Y, %H:%M ")
  end
end

cals = Icalendar.parse($<)
cals.each do |cal|
  cal.events.each do |event|
    puts "Organizer:  #{event.organizer}"
    puts "Event:      #{event.summary}"
    puts "Starts:     #{event.dtstart.good_format} local time"
    puts "Ends:       #{event.dtend.good_format} local time"
    puts "Location:   #{event.location}"
    puts "Contact:    #{event.contacts}"
    puts "Description:\n#{event.description}"
    puts ""
    end
end
