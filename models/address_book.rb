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

  # Search AddressBook for a specific entry by name
  def binary_search(name)
    # #1  save the index of the leftmost item in the array in a variable named lower, and the index of rightmost item in the array in upper
    lower = 0
    upper = entries.length - 1

    # #2  loop while our lower index is less than or equal to our upper index.
    while lower <= upper
      # #3  find the middle index by taking the sum of lower and upper and dividing it by two
      mid = (lower + upper) / 2
      mid_name = entries[mid].name

      # #4  compare the name that we are searching for, name, to the name of the middle index, mid_name
      if name == mid_name
        return entries[mid]
      elsif name < mid_name
        upper = mid - 1
      elsif name > mid_name
        lower = mid + 1
      end
    end

    # #5  if we divide and conquer to the point where no match is found, we return nil
    return nil
  end

  # Search AddressBook for a specific entry by name using an iterative search method
  def iterative_search(name)
    entries.each do |entry|
      if entry.name == name
        return entry
      end
    end

    return nil
  end
end
