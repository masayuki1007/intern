# -*- coding: utf-8 -*-                                                         
 
require 'open-uri'
require 'json'
 
html = open('http://api.moemoe.tokyo/anime/v1/master/2015/1').read
json = JSON.parser.new(html)
puts json.class
 
#parse()メソッドでハッシュ生成                                                  
hash =  json.parse()
 
str = ""
 
hash.each do |anime|
	str = str + "WHEN tweet_text like '\%" + anime['title']
	str = str + "\%' OR tweet_text like '\%" + anime['twitter_account'] 
	str = str + "\%' OR tweet_text like '\%" + anime['twitter_hash_tag'] +"\%'\n"
	str = str + "THEN '" + anime['title'] + "'\n"
end
 
file_name = "sql_output.txt"
File.open(file_name, 'w') {|file|
 file.write str
}