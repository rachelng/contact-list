class Application
 
  def initialize
    # Start with an empty array of contacts.
    # TODO: Perhaps stub (seed) some contacts so we don't have to create some every time we restart the app
    @contacts = []
  end
 
  def run
    while true do
      show_main_menu
      input = gets.chomp.downcase

      case input
      when "new"
        new_contact

      when "list"
        list_contact

      when "show"
        show_contact

      # when "find"
      #   find_contact

      when "quit"
        puts "Goodbye!"
        break
      end
    end
  end
  
  # Prints the main menu only
  def show_main_menu
    puts "What would you like do next?"
    puts " new      - Create a new contact"
    puts " list     - List all contacts"
    puts " show - Display contact details"
    puts " find - Find a contact"
    print "> "
  end

  def new_contact
    puts "What is your full name?"
    name = gets.chomp
    puts "What is your email?"
    email = gets.chomp
    check_email(name, email)
  end

  def check_email(name, email)
    if @contacts.length > 0
      @contacts.each do |contact|
      if email == contact.email
        puts "The email you've entered is already in use"
      else
        add_contact(name, email)
      end
      end
    else
      add_contact(name, email)
    end
  end

  def add_contact(name, email)
    contact = Contact.new(name, email)
    @contacts.push(contact)
    puts "Your contact has been added!"
  end

  def list_contact
    @contacts.each do |contact|
      puts "#{@contacts.index(contact)}: #{contact.first_name} #{contact.last_name[0]} #{contact.email}"
    end
  end

  # def find_contact
  #   puts "Who do you want to find?"
  #   search = gets.chomp
  #   if 
  # end

  def show_contact
    puts "Enter the ID number you are looking for"
    id = gets.chomp.to_i
    if @contacts[id] 
      contact = @contacts[id]
      puts "#{contact.first_name} #{contact.last_name[0]}" 
      puts "#{contact.email}"

      puts "Would you like to edit this contact?"
      input = gets.chomp.downcase
      if input == "yes"
        edit_contact(id)
      else
        #command to quit
      end
    else
      puts "Not found"
    end
  end

  def edit_contact(id)
    puts "Edit name or email?"
    input = gets.chomp.downcase
    if input == "back"
      #figure out what the command is to quit. 'show_main_menu' prints 2 times due to loop.
    else
      case input
      when "name"
        edit_first_name(id)
        edit_last_name(id)

      when "email"
        edit_email(id)
      end
    end
  end

  def edit_first_name(id)
    puts "Enter the new first name"
    new_first_name = gets.chomp.downcase
    if new_first_name == "back"
      #command to quit
    else
      @contacts[id].first_name = new_first_name
      puts "Your first name has been updated"
    end
  end

  def edit_last_name(id)
    puts "Enter the new last name"
    new_last_name = gets.chomp.downcase
    if new_last_name == "back"
      #command to quit
    else
      @contacts[id].last_name = new_last_name
      puts "Your last name has been updated"
    end
  end

  def edit_email(id)
    puts "Enter the new email"
    new_email = gets.chomp.downcase
    if new_email == "back"
      #command to quit
    else
    @contacts[id].email = new_email
    puts "Your email has been updated"
    end
  end
 
end