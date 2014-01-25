require "sinatra"
require "sinatra/activerecord"
require "sinatra/contrib"
require_relative 'contact'

set :database, "sqlite3:///db.sqlite"

get "/auth" do
  erb :"auth"
end

put "/auth" do
  response.set_cookie(:owner_session, {:value => params[:owner_email], :path => '/'})
  redirect "/"
end

# get "/" do
#   @contacts = Contact.order("importance ASC")
#   erb :"contacts/index"
# end

# This is used to get the emails that match the owner email
get "/" do 
  @contacts = Contact.where(owner_email: cookies[:owner_session]).order("importance ASC")
  # .where(:email == request.cookies[:owner_session]).order("importance ASC")
  erb :"contacts/index"
end

get "/contacts/new" do
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
  @contacts = Contact.find(params[:id]) #use where
  @first_name = @contacts.first_name
  erb :"contacts/show"
end

post "/contacts/:id/edit" do
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

  def edit_button(contact_id)
    erb :_edit_button, locals: { contact_id: contact_id}
  end

  def delete_button(contact_id)
    erb :_delete_button, locals: { contact_id: contact_id}
  end

end 
