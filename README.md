# Automation QA. Skype bot

Every morning in our company we go to skype-conversation and we wish each other a good day. And I
want to wish a good day to our team, but I want to improve my skills in automated testing too! So
i decided to make “morning skype bot”. The main reason of this insanity note is not a “desire to be
late for work”, but a “desire to have fun”.

As I know, the simplest way to make plain auto-tests is “[Ruby](https://www.ruby-lang.org/en/) + [WebDriver](https://www.seleniumhq.org/projects/webdriver/) + [Capybara](https://github.com/teamcapybara/capybara)”, besides
capybaras are so cute! (https://en.wikipedia.org/wiki/Capybara)

![Capybara](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/001.png)

“Windows” refused to install Ruby, from start. So, like a typical Windows user, I installed [Oracle VM](https://www.oracle.com/virtualization/vm-server-for-x86/)
to have fun with Linux. Several minutes passed and I saw [Xubuntu’s](https://xubuntu.org/) logo on my second screen. Is
it mouse? Ok.

![Xubuntu](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/002.png)

I typed a few commands from [manual](http://railsapps.github.io/installrubyonrails-ubuntu.html) in the terminal and saw that fresh version of Ruby and some
libraries (rails, selenium web-driver, capybara, etc.) was successfully installed on my virtual
machine.

![Ruby](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/003.png)

I decided to use [BlueFish](http://bluefish.openoffice.nl/index.html) editor to make some magic. So, I had a whole zoo.

![BlueFish](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/004.png)

I'm looking at a blank document now. Let's start to code! At first I should login to the [web version
of Skype](https://web.skype.com). Microsoft don’t uses captcha, so it is not problem for us (hello, spam-bots!)

```
puts "Getting to site"
visit '/'
fill_in( 'username' , :with => login)
fill_in( 'password' , :with => pass)
find_button(sign_in_button).click
```

I will use [xpath](https://en.wikipedia.org/wiki/XPath) and few crutches to do it. Our code has an array with “morning messages”. And
program should find the test-room and put random message to it.

```
search_xpath = "//a[@class='searchItem clearfix']/span/span/h4[1]"
send_button_xpath = "//swx-button/button[@class='btn circle send-button large']/span"
```

```
fill_in query_field, :with => chat_name
find(:xpath, search_xpath).click
fill_in message_input_field, :with => array_of_messages[rand(0...array_of_messages.length)]
find(:xpath, send_button_xpath).click
page.save_screenshot screen_file
```

You can see full code here: https://github.com/yevsikov/skype_vs_capybara

We have message in test-conversation and screenshot with opened page, not bad.

![Running](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/005.png)

Next step – setting up of schedule. I will use standard utility - [Cron](https://en.wikipedia.org/wiki/Cron) . I want to run my tests only from Monday to Friday. It will be looks like this:
`crontab -e`

put:
```
# m h dom mon dow command
10 10 * * 1-5 xterm -display :0 -hold -e ‘cd /home/vlad/workspace/myapp/ && rake test:integration TEST=test/integration/getting_to_skype_test.rb’
```
and save.

Wow. We have really helpful application. It’s time to use this thing in real life:

![Error](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/006.png)

But, what’s happening? An error?! Skype can’t found real meeting-room.

It appears that Skype has two types of conversations. Old version uses [P2P](https://web.archive.org/web/20160529090021/https://support.skype.com/en/faq/FA10983/what-are-p2p-communications) technologies, and new
conversations uses [clouds](https://web.archive.org/web/20150407053136/https://support.skype.com/en/faq/FA12381/what-is-the-cloud). And web-version can work only with cloud!

The simple way to know type of chat-room – is `/get name` command. You can see one of two answers: `name=#username$***` – it means that this room is p2p chat; or `name=19:***@thread.skype` – cloud based chat. Maybe – chat is so old, maybe administrator used `/createmoderatedchat` command, but I am heartbroken and I understand that nothing will turn. [Noooooo](http://www.nooooooooooooooo.com/)!

![Nooooo](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/007.png)

So, it’s time to went back down to earth: now I have cool skype-bot, but I can’t use it in cases of being late for
work. However the main goal of the experiment been reached – I have had a lot of fun, and next time I want
to automate my daily commuting or cooking of borscht. See you on Skype!

![The End](https://github.com/yevsikov/skype_vs_capybara/blob/master/images/008.png)
