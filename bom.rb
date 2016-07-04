require 'bomdb'

BomDB::Query.new(
	edition: '1830'
).each do |row|

  book = row[:book_name]
  chapter = row[:verse_chapter]
  verse = row[:verse_number]
  body = row[:content_body]

	parts = body.upcase.gsub(/[^A-Z]+$/, "").split(/[\.;]/).map{ |part| part.strip.gsub(/[^A-Z ]/, "") }
	parts.each_with_index do |part, i|
		letter = ('A'.ord + i).chr
		puts ">#{book.upcase}-#{chapter}-#{verse}-#{letter}"
		puts part.strip
	end

end