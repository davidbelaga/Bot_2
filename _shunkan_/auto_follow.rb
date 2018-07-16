require 'watir' # Crawler
require 'pry' # Ruby REPL
require 'rb-readline' # Ruby IRB
require 'awesome_print' # Console output
require_relative 'credentials' # Pulls in login credentials from credentials.rb

username = $username
password = $password
follow_counter = 0
unfollow_counter = 0
MAX_UNFOLLOWS = 200
start_time = Time.now

# Open Browser, Navigate to Login page
browser = Watir::Browser.new :chrome, switches: ['--incognito']
browser.goto "instagram.com/accounts/login/"

# Navigate to Username and Password fields, inject info
puts "Logging in..."
browser.text_field(:name => "username").set "#{username}"
browser.text_field(:name => "password").set "#{password}"


# Click Login Button
browser.button(:class => '_5f5mN jIbKX KUBKM yZn4P'.split).click                  
sleep(2)
puts "We're in #hackerman"

# Navigate to #photogarphy
browser.goto "https://www.instagram.com/explore/tags/artphotography/"
puts "Let's check out #mariage tags"

# Click on the first photo of the series
browser.div(:class => 'eLAPa').click
puts "Here's the first photo"
sleep(2)

# If not following then follow, like comment
loop do
  user = browser.a(:class => 'FPmhX notranslate nJAzx'.split).text
  # If I'm not already following...
  if browser.button(:class => '_5f5mN n_COB KUBKM yZn4P'.split).exists? 
  # Follow             
    browser.button(:class => '_5f5mN n_COB KUBKM yZn4P'.split).click
    follow_counter += 1
    puts "Following #{user}"
    sleep(2)
  # Like the photo
    browser.button(:class => 'coreSpriteHeartOpen dCJp8'.split).click
    puts "#{user}'s photo liked"
    sleep(2)
  # Laisser un commentaire
  #  browser.button(:class => 'glyphsSpriteComment__outline__24__grey_9 Szr5J'.split).click
  #  browser.text_field(:class => 'X7cDz').set ":) nice!"
  #  puts "left comment On #{user}'s post"
  #  sleep(2)

  # Go to next photo
    browser.a(:class => 'HBoOv coreSpriteRightPaginationArrow'.split).click
    sleep(2)

# If I am already following...
  elsif browser.button(:class => '_5f5mN qPANj KUBKM yZn4P'.split).exists?
    browser.button(:class => '_5f5mN qPANj KUBKM yZn4P'.split).click
    browser.button(:class => 'aOOlW -Cab_   '.split).click
    unfollow_counter += 1
    puts "Unfollowing #{user}"
    sleep(2)

  # Go to next photo
    browser.a(:class => 'HBoOv coreSpriteRightPaginationArrow'.split).click
  end
    sleep(1.0/2.0) # Sleep half a second to not get tripped up when un/following many users at once
    puts "--------- #{Time.now} ----------"
    break if unfollow_counter >= MAX_UNFOLLOWS
    sleep(3) # Sleep 1 hour (3600 seconds)
end



=begin

# Continuous loop to run until you've unfollowed the max people for the day
loop do
  users.each { |val|
    # Navigate to user's page
    browser.goto "instagram.com/#{val}/"

    # If not following then follow
    if browser.button(:class => '_5f5mN jIbKX _6VtSN yZn4P'.split).exists?                   
      ap "Following #{val}"
      browser.button(:class => '_5f5mN jIbKX _6VtSN yZn4P'.split).click
      follow_counter += 1
    elsif browser.button(:class => '_5f5mN -fzfL _6VtSN yZn4P'.split).exists?                 
      ap "Unfollowing #{val}"
      browser.button(:class => '_5f5mN -fzfL _6VtSN yZn4P'.split).click
      unfollow_counter += 1
    end
    sleep(1.0/2.0) # Sleep half a second to not get tripped up when un/following many users at once
  }
  puts "--------- #{Time.now} ----------"
  break if unfollow_counter >= MAX_UNFOLLOWS
  sleep(3) # Sleep 1 hour (3600 seconds)
end

ap "Followed #{follow_counter} users and unfollowed #{unfollow_counter} in #{((Time.now - start_time)/60).round(2)} minutes"

# Leave this in to use the REPL at end of program
# Otherwise, take it out and program will just end
Pry.start(binding)

=end

# Top 100 users on Instagram
# users = ['instagram', 'selenagomez', 'arianagrande', 'taylorswift', 'beyonce', 'kimkardashian', 'cristiano', 'kyliejenner', 'justinbieber', 'kendalljenner', 'nickiminaj', 'natgeo', 'neymarjr', 'nike', 'leomessi','khloekardashian', 'mileycyrus', 'katyperry', 'jlo', 'ddlovato', 'kourtneykardash', 'victoriasecret', 'badgalriri', 'fcbarcelona', 'realmadrid', 'theellenshow', 'justintimberlake', 'zendaya' 'caradelevingne', '9gag', 'chrisbrownofficial', 'vindiesel', 'champagnepapi', 'davidbeckham', 'shakira', 'gigihadid', 'emmawatson', 'jamesrodiguez10', 'kingjames', 'garethbale11', 'nikefootball', 'adele', 'zacefron', 'vanessahudgens', 'ladygaga', 'maluma', 'nba', 'nasa', 'rondaldinho', 'luissuarez9', 'zayn', 'shawnmendes', 'adidasfootball', 'brumarquezine', 'hm', 'harrystyles','chanelofficial', 'ayutingting92', 'letthelordbewithyou', 'niallhoran', 'anitta', 'hudabeauty', 'camerondallas', 'adidasoriginals', 'marinaruybarbosa', 'lucyhale', 'karimbenzema', 'princessyahrini', 'zara', 'nickyjampr', 'onedirection', 'andresiniesta8', 'raffinagita1717', 'krisjenner', 'manchesterunited', 'natgeotravel', 'marcelottwelve', 'deepikapadukone', 'snoopdogg', 'davidluiz_4', 'kalbiminrozeti', 'priyankachopra', 'ashleybenson', 'shaym', 'lelepons', 'prillylatuconsina96','louisvuitton','britneyspears', 'sr4official', 'jbalvin', 'laudyacynthiabella', 'ciara', 'stephencurry30', 'instagrambrasil']
