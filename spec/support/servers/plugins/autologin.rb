require 'sinatra'
require 'sinatra/contrib'

get '/' do
    cookies[:success] ||= false

    if cookies[:success] == 'true'
        <<-HTML
            <a href='/congrats'>Hi there logged-in user!</a>
        HTML
    else
        redirect '/login'
    end
end

get '/redirect/1' do
    redirect '/redirect/2'
end

get '/redirect/2' do
    redirect '/redirect/3'
end

get '/redirect/3' do
    redirect '/'
end

get '/login' do
    cookies[:preserve] = 'this'

    <<-HTML
        <form method='post' name='login_form' action="/login">
            <input name='username' value='' />
            <input name='password' type='password' value='' />
            <input name='token' type='hidden' value='secret!' />
        </form>
    HTML
end

post '/login' do
    if params['username'] == 'john' && params['password'] == 'doe' &&
        params['token'] == 'secret!' && cookies[:preserve] == 'this'
        cookies[:success] = true
        redirect '/redirect/1'
    else
        'Boohoo...'
    end
end

get '/congrats' do
    'Congrats!'
end
