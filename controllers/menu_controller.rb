# #1 includes address book with require relative
require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    # #2  display the main menu options
    puts "Main Menu - #{address_book.entries.count} entries"
    puts "1 - View all entries"
    puts "2 - Create an entry"
    puts "3 - Search for an entry"
    puts "4 - Import entries from a CSV"
    puts "5 - Exit"
    print "Enter your selection: "

    # #3 retrieve user input from the command line using gets
    selection = gets.to_i
    # #7  use case statement operator to determine the proper response to the user's input
    case selection
      when 1
        system "clear"
        view_all_entries
        main_menu
      when 2
        system "clear"
        create_entry
        main_menu
      when 3
        system "clear"
        search_entries
        main_menu
      when 4
        system "clear"
        read_csv
        main_menu
      when 5
        puts "Good-bye!"
       # #8  terminate the program using exit(0) -> 0 signals the program is exiting w/o an error
        exit(0)
      # #9  use an else to catch invalid user input and prompt the user to retry
      else
        system "clear"
        puts "Sorry, that is not a valid input"
        main_menu
    end
  end

  # #10  stub the rest of the methods called in main_menu
  def view_all_entries
    # #14  iterate through all entries in AddressBook using each
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
    # #15  we call entry_submenu to display a submenu for each entry
      entry_submenu(entry)
    end

    system "clear"
    puts "End of entries"
  end

  def create_entry
    # #11  clear the screen for before desplaying the create entry prompts
    system "clear"
    puts "New AddressBloc Entry"
    # #12  use print to prompt the user for each entry attribute
    print "Name: "
    name = gets.chomp
    print "Phone number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    # #13  add a new entry to address_book using add_entry to ensure the new entry is added in the proper order
    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New entry created"
  end

  def search_entries
    # #9  get the name that the user wants to search for and store it in name
    print "Search by name: "
    name = gets.chomp
    # #10  call search on address_book which will either return a match or nil
    match = address_book.binary_search(name)
    system "clear"
    # #  check if search returned a match
    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No match found for #{name}"
    end
  end

  def read_csv
    # #1  prompt the user to enter a name of a CSV file to import
    print "Enter CSV file to import: "
    file_name = gets.chomp

    # #2  check to see if the file name is empty. If it is then we return the user back to the main menu by calling main_menu
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    # #3  import the specified file with import_from_csv on address_book.
      # We then clear the screen and print the number of entries that were read from the file.
      # All of these commands are wrapped in a begin/rescue block.
      # begin will protect the program from crashing if an exception is thrown.
    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end


  def entry_submenu(entry)
    # #16  display submenu options
    puts "n - next entry"
    puts "d - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"

    # #17  chomp removes any trailing whitespace from the string "gets" returns
    selection = gets.chomp

    case selection
    # #18  when the user asks to see the next entry, we can do nothing and control will be returned to view_all_entries
    when "n"
    # #19  we'll handle deleting and editing in another checkpoint, for now the user will be shown the next entry
    when "d"
      # #7  when a user is viewing the submenu and they press d, we call delete_entry
      delete_entry(entry)
    when "e"
      # #8  call edit_entry when a user presses e; then display a sub-menu with  entry_submenu for the entry under edit
      edit_entry(entry)
      entry_submenu(entry)
    # #20  we return the user to the main menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted"
  end

  def edit_entry(entry)
    # #4  perform a series of print statements followed by gets.chomp assignment statements
    print "Updated name: "
    name = gets.chomp
    print "Updated phone number: "
    phone_number = gets.chomp
    print "Updated email: "
    email = gets.chomp
    # #5  use !attribute.empty? to set attributes on entry only if a valid attribute was read from user input
    entry.name = name if !name.empty?
    entry.phone_number = phone_number if !phone_number.empty?
    entry.email = email if !email.empty?
    system "clear"
    # #6  print out entry with the updated attributes
    puts "Updated entry:"
    puts entry
  end

  def search_submenu(entry)
    # #12  print out the submenu for an entry
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    # #13  save the user input to selection
    selection = gets.chomp

    # #14  use a case statement and take a specific action based on user input
    case selection
      when "d"
        system "clear"
        delete_entry(entry)
        main_menu
      when "e"
        edit_entry(entry)
        system "clear"
        main_menu
      when "m"
        system "clear"
        main_menu
      else
        system "clear"
        puts "#{selection} is not a valid input"
        puts entry.to_s
        search_submenu(entry)
    end
  end
end
