require 'fileutils'
require 'pp'
require 'digest/sha1'


def item_xml(title, subtitle)
  uid = Digest::SHA1.hexdigest "#{title}/#{subtitle}"
  return <<-eof
    <item uid="#{uid}" arg="#{title}" valid="YES" autocomplete="#{subtitle}">
        <title>#{title}</title>
        <subtitle>#{subtitle}</subtitle>
    </item>
  eof
end


emojis = []
f =  File.open('./emoji_db', "r:UTF-8")
f.readlines.each do |line|
  if line =~ /^([^\t]+)\t+(.+)$/
    emojis.push [$1, $2]
  end
end

items = ""
query = ARGV[0]
emojis.each do |keyword, emoji|
  if keyword.index(query) != nil
    items += item_xml(emoji, keyword)
  end
end

xml = '<?xml version="1.0"?><items>' + items + '</items>'
puts xml
