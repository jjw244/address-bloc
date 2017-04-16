# #8  tell Ruby to load the library named entry.rb relative to  address_book.rb's file path using require_relative.
require_relative 'entry'
require "csv"

class AddressBook
  attr_reader :entries

  def initialize
      @entries = []
  end

  def add_entry(name, phone_number, email)
    # #9  create a variable to store the insertion index
    index = 0
    entries.each do |entry|

    # #10  compare name with the name of the current entry.
    # If name lexicographically proceeds entry.name, we've found the index to insert at.
    # Otherwise we increment index and continue comparing with the other entries
      if name < entry.name
        break
      end
      index+= 1
    end
  # #11  insert a new entry into entries using the calculated `index
    entries.insert(index, Entry.new(name, phone_number, email))
  end

  # #7  reads File, use CSV class to parse -> results in an object of type CSV::Table
  def import_from_csv(file_name)
    # Implementation goes here
    csv_text = File.read(file_name)
    csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
    # #8  iterate over the CSV::Table object's rows, create a hash for each row,
      #convert row_has to and Entry using add_entry method (also adds the Entry to the AddressBook's entryies)
    csv.each do |row|
      row_hash = row.to_hash
      add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
    end
  end
end
