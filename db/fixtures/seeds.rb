`rake db:truncate`
Recruiter.seed(:email) do |r|
  r.email = "you@recruiter.com"
  r.password = "passtoreplace"
  r.password_confirmation = "passtoreplace"
end


candidates = Candidate.seed(:email) do |c|
  c.name = "Anthony Alberto"
  c.email = "alberto.anthony@gmail.com"
  c.phone = "514 621 6684"
  c.current_location = "Montreal"
  c.current_status = "Wants to find an exciting job!"
  c.languages = "French: Mother tongue, English: Fluent"
  c.general_information = "Passionate Ruby/Rails Developer. I love building beautiful, snappy websites and SaaS. I've been working for an e-commerce/print-on-demand startup for 4 years now."
end
candidate = candidates.first

skills = {
  "Advanced" => "Ruby, Rails, MySQL, HTML/CSS/HAML/SASS",
  "Intermediate" => "Javascript, Coffeescript, Linux sysadmin, SEO knowledge, RSpec",
}

skills.each do |k, v|
  candidate.skills.seed do |s|
    s.name = v
    s.level = k
  end
end

candidate.educations.seed do |e|
  e.name = "Computer Science Engineer"
  e.year_from = 2006
  e.year_to = 2009
  e.description = "Got my Computer Sciences Engineer degree in Polytech'Nice Sophia, an engineering school in France, near Nice. Involved a lot of Java programming, and a small course talking about Rails and Ruby. That's when I fell in love with the language! I then found my final internship in Montreal and had the chance to start using Ruby and Rails every day."
end

candidate.educations.seed do |e|
  e.name = "IT technician"
  e.year_from = 2004
  e.year_to = 2006
  e.description = "This was my first degree in IT, in Aix-en-provence. Bottom-up approach: we learned C/C++ for 2 years, and we got a small introduction to Java near the end. We also got extensive courses talking about databases."
end

candidate.experiences.seed do |e|
  e.name = "Lead developer / CTO / Associate at Wordans.com"
  e.description = "Wordans.com is a print on demand startup. The website is fully available in English and French. Shop owners create products, and our clients either buy them or create their own products. I manage a team of 2 developers, sysadmin our Linux servers stack, and of course develop.
                   The system is built on Rails 3.2, MySQL. The server stack includes 6 ubuntu servers. Software used: Nginx, Passenger, Apache, Varnish, HAproxy, NFS, memcached, Sphinx"
  e.key_facts = "* I scaled out our server infrastructure from a one jack-of-all-trades server to 6 specialized servers.  \n* Set-up of a Master-Master passive MySQL replication and a Sphinx instance for full text search.  \n* Implemented different layers of caching using Varnish, Memcached and a CDN.
                   \n* Migrated the whole code base from Ruby 1.8.7/Rails 2.3 to Ruby 1.9.3/Rails 3.2 and enjoyed a 35% decrease in server load.  \n* Optimized code base performance: N+1 queries, abusive eager-loading, Model.all catastrophes etc ...
                   \n* Thanks to all of this, we were able to reach 20K visitors a day with very little load on our web servers.  \n* Revenue from the website doubled each year on average from 2009 to 2012."
  e.year_from = 2009
  e.year_to = 2013
end

candidate.open_source_projects.seed do |o|
  o.name = "jquery_ujs_extended gem"
  o.description = "Extends usage of html5 data attributes. A collection of global attributes listeners that speeds up JS development. Written in Coffeescript/jQuery."
  o.url = "https://github.com/anthonyalberto/jquery-ujs-extended"
end

candidate.open_source_projects.seed do |o|
  o.name = "Contributed to Rails' ActiveModel to_xml method"
  o.description = "This fix will be in Rails 4. It fixes problems when serializing an ActiveRecord object to xml with custom format options and associations at the same time (yeah, it's a very targeted problem!)"
  o.url = "https://github.com/rails/rails/pull/7184"
end

candidate.open_source_projects.seed do |o|
  o.name = "Contributed to Discourse"
  o.description = "Fixed a small glitch with their meta title updates (Coffeescript + Ember.js)"
  o.url = "https://github.com/discourse/discourse/pull/163"
end

candidate.open_source_projects.seed do |o|
  o.name = "Trying to Contribute to Kaminari"
  o.description = "I love this gem, so I tried to fix a glitch that always annoyed me. Made it so page truncation (...) doesn't happen if there's only one page to truncate. Not yet merged ..."
  o.url = "https://github.com/amatsuda/kaminari/pull/354/files"
end

candidate.open_source_projects.seed do |o|
  o.name = "Started to use Code Triage to help some repos"
  o.description = "Code triage helps repositories triage the issues. I subscribed on some repos and was able to help will_paginate, kaminari, and even the codetriage repo itself!"
  o.url = "http://www.codetriage.com/"
end

candidate.open_source_projects.seed do |o|
  o.name = "IRB CV"
  o.description = "Well, you're using it right now! Check out the sources!"
  o.url = "https://github.com/anthonyalberto/cv-rb"
end

candidate.open_source_projects.seed do |o|
  o.name = "Household Finances management Rails app"
  o.description = "Created a small Rails app to manage shared expenses with my girlfriend. But I was sad it had no homepage ... so I created one quickly. It allows me to make my cats talk at miniwu.org (sorry, in french only)."
  o.url = "https://github.com/anthonyalberto/household"
end

profiles = {
  "StackOverflow" => "http://stackoverflow.com/users/875321/anthony-alberto",
  "GitHub" => "https://github.com/anthonyalberto",
  "LinkedIn" => "http://ca.linkedin.com/pub/anthony-alberto/36/2b5/5a/en",
  "Twitter" => "https://twitter.com/anthonyalberto",
  "CoderWall" => "https://coderwall.com/anthonyalberto"
}
profiles.each do |k, v|
  candidate.profile_links.seed do |p|
    p.name = k
    p.url = v
  end
end


cats = candidate.cats.seed do |c|
  c.name = "Oreo (or Miniwu)"
  c.breed = "Fat Cookie"
  c.current_status = "Probably sleeping (or eating)"
end

oreo = cats.first

cats = candidate.cats.seed do |c|
  c.name = "Domino"
  c.breed = "Bengal"
  c.current_status = "Probably Meowing"
end

domino = cats.first

oreo_skills = {
  "Advanced" => "Sleep, Eat, Sleep, Eat, Sleep, Gain Weight",
  "Beginner" => "Sleep on laps, Cuddling"
}

oreo_skills.each do |k, v|
  oreo.skills.seed do |s|
    s.name = v
    s.level = k
  end
end

domino_skills = {
  "Absolute Master" => "Meowing for about anything ... food, water, cuddles ... a real diva",
  "Never learned" => "Being quiet"
}

domino_skills.each do |k, v|
  domino.skills.seed do |s|
    s.name = v
    s.level = k
  end
end

domino.pictures.seed do |p|
  p.picture = File.open(Rails.root.join("db", "fixtures", "images", "domino.jpg"))
end
oreo.pictures.seed do |p|
  p.picture = File.open(Rails.root.join("db", "fixtures", "images", "oreo.jpg"))
end

funny_links = {
  "BatBear" => "http://i.imgur.com/3aNmT6O.png",
  "Doritos Goat Commercial" => "http://www.youtube.com/watch?v=v9lYt6GcAxc",
  "Thanks Grandma" => "http://www.lamebook.com/thanks-grandma/",
  "jQuery Raptorize" => "http://www.zurb.com/playground/jquery-raptorize",
  "PHP, you're drunk" => "http://i.imgur.com/aAY28.png",
  "Ohio University video game marching band" => "http://www.youtube.com/watch?v=sAzzbrFgcUw&feature=youtu.be"
}
funny_links.each do |k, v|
  candidate.funny_links.seed do |f|
    f.name = k
    f.url = v
  end
end

hobbies = [
  "Electric Guitar",
  "Video games",
  "Movies",
  "Rock Music",
  "Travelling",
  "Contributing to Open Source",
  "Tennis, Squash, Badminton (yeah, I like rackets)"
]

hobbies.each do |v|
  candidate.hobbies.seed do |h|
    h.name = v
  end
end

#TODO : import pictures
