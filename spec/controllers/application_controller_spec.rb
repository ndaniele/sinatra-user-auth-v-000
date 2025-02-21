require 'spec_helper'

describe "ApplicationController" do
  describe "home page: GET /" do
    
    before(:each) do 
      get '/'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the home page view, 'home.erb'" do
      expect(last_response.body).to include("Welcome to Hogwarts")
    end
  end

  describe "sign up page: GET /registrations/signup" do
    
    before(:each) do
      get '/registrations/signup'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the signup template" do
      expect(last_response.body).to include("Sign Up")
    end
  end

  describe "log-in page: GET /sessions/login" do
    
    before(:each) do
      get '/sessions/login'
    end

    it "responds with a 200 status code" do
      expect(last_response).to be_ok
    end

    it "renders the signup template" do
      expect(last_response.body).to include("Log In")
    end
  end

  describe "user's home page: GET /users/home" do
    
    it "responds with a 200 status code" do
      @user = User.create(:name => "Bitsy Flipsy", :email => "bitsy@hogwarts.edu", :password => "luminosity")
      visit 'sessions/login'
      # save_and_open_page
      fill_in(:email, :with => "bitsy@hogwarts.edu")
      fill_in(:password, :with => "luminosity")
      click_button "Log In"
      visit '/users/home'
      expect(page.status_code).to eq(200)
    end

    it "welcomes the user" do
      @user = User.create(:name => "Bitsy Flipsy", :email => "bitsy@hogwarts.edu", :password => "luminosity")
      visit 'sessions/login'
      fill_in(:email, :with => "bitsy@hogwarts.edu")
      fill_in(:password, :with => "luminosity")
      click_button "Log In"
      visit '/users/home'
      expect(page.body).to include("Welcome, #{@user.name}")
    end
  end

end
