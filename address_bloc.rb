require_relative 'controllers/menu_controller'

# #4  create new Menu Controller when AddressBloc starts
menu = MenuController.new

# #5  use system "clear" to clear the ocmmand line
system "clear"
puts "Welcome to AddressBloc!"

# #6  call main_menu to display the menu
menu.main_menu
