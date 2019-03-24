#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

configure do
  @db = SQLite3::Database.new 'barbershop.db'
  @db.execute 'CREATE TABLE IF NOT EXISTS 
    "Users" 
      (
          "id" INTEGER PRIMARY KEY AUTOINCREMENT,
          "username" TEXT,
          "phone" TEXT, 
          "datestamp" TEXT, 
          "barber" TEXT, 
          "color"  TEXT
      )'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/abaut' do
  @error = "Ошибка"
  erb :abaut
end

get '/visit' do
  erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/visit' do

  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  @barber = params[:barber]
  @color = params[:color]

  # Создаем хэш

  hh = {:username => "Введите имя", 
        :phone => "Введите телефон",
        :datetime => "Введите дату и время"}
  # Для каждой пары проверку перебераем хэш ключ - значение

         hh.each do |key, value|
            # Если параметр пуст
            if params[key] == ""
              # Переменной @eror 
               @error = hh[key] 

               return erb :visit

            end
  end



  data = File.open './public/users.txt','a'
  data.write "Имя клиента: #{@username}, телефон: #{@phone}, дата и время: #{@datetime}, парикмахер: #{@barber}, цвет волос #{@color}\n"
  data.close
  erb "<h1>Отлично! Мы Вас ждем #{@username}!</h1>"
end

post '/contacts' do
  @email = params[:email]
  

  contact = File.open './public/contacts.txt','a'
  contact.write "Email #{@email}\n"
  contact.close

end




