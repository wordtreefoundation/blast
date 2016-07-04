require 'kj'

bible = Kj::Bible.new

first_verse = verse = bible.book(:genesis).chapter(1).verse(1)

def bookname(name)
	name.upcase.gsub(/[ ]+/, "-")
end

loop do
	parts = verse.text.split(/[\.;]/).map{ |part| part.upcase.gsub(/[^A-Z ]/, "") }
	parts.each_with_index do |part, i|
		letter = ('A'.ord + i).chr
		puts ">#{bookname(verse.chapter.book.name)}-#{verse.chapter.number}-#{verse.number}-#{letter}"
		puts part.strip
	end
	verse = verse.next
	break if verse.chapter.book.name == "Genesis" && verse.chapter.number == 1 && verse.number == 1
end