class Application
 
  def initialize
    # Start with an empty array of contacts.
    # TODO: Perhaps stub (seed) some contacts so we don't have to create some every time we restart the app
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

      when "quit"
        puts "Goodbye!"
        break
      end
    end
  end
  
  # Prints the main menu only
  def show_main_menu
    puts "What would you like do next?"
    puts " new    - Create a new contact"
    puts " list   - List all contacts"
    puts " show   - Display contact details"
    # puts " find   - Find a contact"
    print "> "
  end

  def new_contact
    puts "What is your full name?"
    name = gets.chomp.split(" ")
    puts "What is your email?"
    email = gets.chomp
    check_email(name, email)
  end

  def check_email(name, email)
    if Contact.find_by email: email
      puts "The email you've entered is already in use"
    else
      add_contact(name, email)
    end
  end

  def add_contact(name, email)
    Contact.create(first_name: name[0], last_name: name[1], email: email)
    puts "Your contact has been added!"
  end

  def list_contact
    Contact.all.each do |contact|
      puts "#{contact.id}: #{contact.first_name} #{contact.last_name[0]} #{contact.email}"
    end
  end

  def show_contact
    puts "Enter the ID number you are looking for"
    id = gets.chomp.to_i
    if Contact.find_by id: id
      contact = Contact.take!
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
    input = gets.chomp
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
    new_first_name = gets.chomp
    if new_first_name == "back"
      #command to quit
    else
      contact = Contact.find(id)
      contact.first_name = new_first_name
      contact.save
      puts "Your first name has been updated"
    end
  end

  def edit_last_name(id)
    puts "Enter the new last name"
    new_last_name = gets.chomp
    if new_last_name == "back"
      #command to quit
    else
      contact = Contact.find(id)
      contact.last_name = new_last_name
      contact.save
      puts "Your last name has been updated"
    end
  end

  def edit_email(id)
    puts "Enter the new email"
    new_email = gets.chomp.downcase
    if new_email == "back"
      #command to quit
    else
      contact = Contact.find(id)
      contact.email = new_email
      contact.save
      puts "Your email has been updated"
    end
  end
 
end