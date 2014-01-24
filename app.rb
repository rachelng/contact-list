require "sinatra"
require "sinatra/activerecord"
require_relative 'database'
require_relative 'contact'
require_relative 'application'

set :database, "sqlite3:///db.sqlite"

get "/" do
  @contacts = Contact.order("importance ASC")
  erb :"contacts/index"
end

get "/contacts/new" do
  @title = "New Contact"
  @contacts = Contact.new
  erb :"contacts/new"
end

post "/contacts" do
  @contacts = Contact.new(params[:contact])
  if @contacts.save
    redirect "contacts/#{@contacts.id}"
  else
    erb :"contacts/new"
  end
end

get "/contacts/:id" do
  @contacts = Contact.find(params[:id])
  @first_name = @contacts.first_name
  erb :"contacts/show"
end

get "/contacts/:id/edit" do
  @contacts = Contact.find(params[:id])
  erb :"contacts/edit"
end

put "/contacts/:id" do
  @contacts = Contact.find(params[:id])
  if @contacts.update_attributes(params[:contact])
    redirect "/contacts/#{@contacts.id}"
  else
    erb :"contacts/edit"
  end
end

delete "/contacts/:id" do
  @contacts = Contact.find(params[:id]).destroy
  redirect "/"
end




helpers do
  def contact_show_page?
    request.path_info =~ /\/contacts\/\d+$/
  end

  def delete_button(contact_id)
    erb :_delete_button, locals: { contact_id: contact_id}
  end

end 
