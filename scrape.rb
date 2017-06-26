## Note: This scrapes the main page source from thebibleproject.org home page as of 4/13/17. It may not always work.
# what I did was view source, and then create a text file with just the stuff from the old testament or the new testament and saved as
# old_testament.html (or whatever). Then it grabs the thumbnails and puts them in the folder (you can comment this out if you've already 
# got the images)
# You still have to manually download the videos. I then convert them to save bandwidth using Handbrake

require "open-uri"
require "json"

name = "new_testament"

x = File.readlines("#{name}.txt")
lines = []
x.each do |line|
  if line.match(/data-videoShare='\[(.*)\]'>/) 
    lines << eval(line.match(/data-videoShare='\[(.*)\]'>/)[1].gsub('\"',''))
  end
end  

file_html = File.new("#{name}.html", "w+")
file_html.puts "<!DOCTYPE html>
<html lang=\"en\">
  <head>
    <meta charset=\"utf-8\">
    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">
    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">
    <meta name=\"description\" content=\"\">
    <meta name=\"author\" content=\"\">
    <link rel=\"icon\" href=\"favicon.ico\">

    <title>the Bible Project</title>
    <link href=\"/css/bootstrap.min.css\" rel=\"stylesheet\">
    <link href=\"/css/jumbotron.css\" rel=\"stylesheet\">
  </head>

  <body>

    <nav class=\"navbar navbar-inverse navbar-fixed-top\">
      <div class=\"container\">
        <div class=\"navbar-header\">
          <button type=\"button\" class=\"navbar-toggle collapsed\" data-toggle=\"collapse\" data-target=\"#navbar\" aria-expanded=\"false\" aria-controls=\"navbar\">
            <span class=\"sr-only\">Toggle navigation</span>
            <span class=\"icon-bar\"></span>
            <span class=\"icon-bar\"></span>
            <span class=\"icon-bar\"></span>
          </button>
          <a class=\"navbar-brand\" href=\"#\">The Bible Project Videos</a>
        </div>
        <div id=\"navbar\" class=\"navbar-collapse collapse\">
          <ul class=\"nav navbar-nav\">
            <li class=\"active\"><a href=\"index.html\">Home</a></li>  
            <li><a href=\"old_testament.html\">Old Testament</a></li>
            <li><a href=\"new_testament.html\">New Testament</a></li>
            <li><a href=\"about.html\">About</a></li>
          </ul>  
        </div><!--/.navbar-collapse -->
      </div>
    </nav>

    <div class=\"jumbotron\" style=\"background-image: url('/img/hero.jpg')\">
      <div class=\"container\">
        <h1>#{name}</h1>
      </div>
    </div>

    <div class=\"container\">"
    
n = 0

  lines.each do |line|
  
    filename = line[:thumbnail].match(/(?:.+\/)(.+)/)[1]
    File.write("img/#{name}/#{filename}", open(line[:thumbnail]).read, {mode: 'wb'}) 
   
    file_html.puts "<div class=\"row\">" unless n % 3 != 0
    file_html.puts "  <div class=\"col-md-4\">"
    file_html.puts "    <img class=\"img-responsive\" src=\"/img/#{name}/#{filename}\"/><br/>"
    file_html.puts "    <h2>#{line[:title]}</h2>"
    file_html.puts "    <p>#{line[:summary]}</p>"
    file_html.puts "    <p><a class=\"btn btn-default\" href=\"#\" role=\"button\">Watch Video &raquo;</a></p>"
    file_html.puts "  </div>"
    file_html.puts "</div>" unless (n+1) % 3 != 0
    n += 1
  
  end

  if (n+1) % 3 != 0
    file_html.puts "</div>"
  end

file_html.puts "      <hr/>"
file_html.puts "      <footer>"
file_html.puts "        <p>&copy; the Bible Project :: www.thebibleproject.com</p>"
file_html.puts "      </footer>"
file_html.puts "    </div> <!-- /container -->"
file_html.puts ""
file_html.puts "    <script src=\"/js/jquery.min.js\"></script>"
file_html.puts "    <script src=\"/js/bootstrap.min.js\"></script>"
file_html.puts "  </body>"
file_html.puts "</html>"
file_html.puts "</body>"
file_html.puts "</html>"
file_html.close() 

# data-videoShare='[{"title":"Genesis 1-11","url":"https:\/\/thebibleproject.com\/product\/genesis-1-11","category":"Read Scripture Old Testament","summary":"Genesis 1-11: God makes a good world, but humanity rebels against God and ruins that world. We trace how that story leads up to God&#039;s plan to rescue and bless the whole world through Abraham.","thumbnail":"https:\/\/s3-us-west-2.amazonaws.com\/tbp-wp\/wp-content\/uploads\/2016\/05\/TBP-Web-RSThumbnail-GEN1-1.jpg","video_link":"https:\/\/thebibleproject.com\/resources\/genesis-1-11-video","youtube_id":"GQI72THyO5I","funded":"true","data_links":{"posters":{"url":"https:\/\/thebibleproject.com\/product\/genesis-poster","tagSlug":"posters","tagName":"Poster"},"study-guides":{"url":"https:\/\/thebibleproject.com\/product\/genesis-1-11-study-notes","tagSlug":"study-guides","tagName":"Study Notes"},"videos":{"url":"https:\/\/thebibleproject.com\/product\/genesis-1-11-video","tagSlug":"videos","tagName":"Videos"}},"category_display_title":"Read Scripture<br\/>Old Testament"}]'>



