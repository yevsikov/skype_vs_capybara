    #skype_vs_capybara
    #rails generate integration_test getting_to_skype #use to create
    #rake test:integration TEST=test/integration/getting_to_skype_test.rb #use to run
    
    require 'test_helper'
    #require 'capybara/dsl'
    require 'rubygems'
    require 'selenium-webdriver'
    
    
    class GettingToSkypeTest < ActionDispatch::IntegrationTest
    include Capybara::DSL
    
    
      setup do
        Capybara.current_driver = Capybara.javascript_driver
        Capybara.app_host = 'https://login.skype.com/login'
        page.driver.browser.manage.delete_all_cookies
        #page.driver.browser.manage.window.maximize
      end
  
      test 'should_get_to_the_skype' do
      
      array_of_messages = [ 'Good morning', 
      								'good morning!', 
      								'Hello!)',
      								'Good morning (coffee)',
      								'Good morning! =)',
      								'Morning!;)',
      								'Good morning (sun)',
      								'(*) good morning!',
      								'Morning! (wave)',
      								'(y) Good morning']

      login = 'LOGIN'
      pass = 'PASSWORD'
      my_name = 'MY NAME'
      chat_name = 'CHAT NAME'
  
      go_to_skype_link = "Try Skype for Web (Beta)"	
      search_xpath = "//a[@class='searchItem clearfix']/span[@class='text']/span[@class='tileName']/h4[1]"
      send_button_xpath = "//swx-button/button[@class='btn circle send-button large']/span[@class='iconfont send']"
      account_title = "my account"
      signing_title = "signing"
      query_field = "query"
      message_input_field = "messageInput"
      sign_in_button = "signIn"
  
      screen_folder = "test/integration/screens/"
      screen_file = screen_folder + Time.now.strftime("%s")+".png"


      puts "Getting to site"  
      visit '/'
      fill_in('username', :with => login)
      fill_in('password', :with => pass)
      find_button(sign_in_button).click
    
      puts "Waiting..."  
      wait = Selenium::WebDriver::Wait.new(:timeout => 20)
      wait.until { page.driver.title.downcase.start_with? account_title } 
      assert page.has_content? my_name
      
      find_link(go_to_skype_link).click
      wait = Selenium::WebDriver::Wait.new(:timeout => 2)
      wait.until { page.driver.title.downcase.start_with? signing_title }  
    
      sleep(8.seconds)
      assert page.has_content? my_name 
      puts "Searching of conversation"   
      
      fill_in query_field, :with => chat_name   
      sleep(6.seconds) 
      find(:xpath, search_xpath).click
      
      puts "Message writing"    
      fill_in message_input_field, :with => array_of_messages[rand(0...array_of_messages.length)]
      find(:xpath, send_button_xpath).click
      
      #puts "Screenshot saving"
      page.save_screenshot screen_file
      
      end

    end
