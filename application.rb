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

      when "delete"
        delete_contact

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
    puts " delete - Delete a contact"
    puts " show   - Display contact details"
    # puts " find   - Find a contact"
    print "> "
  end

  def new_contact
    puts "What is your full name?"
    name = gets.chomp.split(" ")
    puts "What is your email?"
    email = gets.chomp
    puts "Enter the importance of contact (1 - 5)"
    importance = gets.chomp.to_i
    check_email(name, email, importance)
  end

  def check_email(name, email, importance)
    if Contact.find_by email: email
      puts "The email you've entered is already in use"
    else
      add_contact(name, email, importance)
    end
  end

  def add_contact(name, email, importance)
    Contact.create(first_name: name[0], last_name: name[1], email: email, importance: importance)
    puts "Your contact has been added!"
  end

  def list_contact
    puts "Would you like to list by importance?"
    list = gets.chomp
    if list == "yes"
      list_most_importance
    else
      Contact.all.each do |contact|
        puts "id #{contact.id}: #{contact.importance} #{contact.first_name} #{contact.last_name[0]} #{contact.email}"
      end
    end
  end

  def list_most_importance
      Contact.order("importance ASC").each do |contact|
      puts "id #{contact.id}: #{contact.importance} #{contact.first_name} #{contact.last_name[0]} #{contact.email}"
    end
  end

  def show_contact
    puts "Enter the ID number you are looking for"
    id = gets.chomp.to_i
    if contact = Contact.find_by(id:id)
        puts "importance: #{contact.importance}"
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
    puts "Edit name, email or importance?"
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

      when "importance"
        edit_importance(id)
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

  def edit_importance(id)
    puts "Enter the new importance (1 - 5)"
    new_importance = gets.chomp.to_i
    if new_importance == "back"
      #command to quit
    else
      contact = Contact.find(id)
      contact.importance = new_importance
      contact.save
      puts "Your importance level has been updated"
    end    
  end

  def delete_contact
    puts "Enter the ID number of the contact you'd like to delete"
    id = gets.chomp.to_i
    contact = Contact.find_by(id:id)
    contact.destroy
    puts "Your contact has been deleted"
  end
 
end