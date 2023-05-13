# Five Letters API

The project is an API that has been developed for the mobile game "5 Letters," which allows users to guess a 5-letter word once a day within 6 attempts in the language of their choice.

Upon starting a new game, the API provides the user with a random 5-letter word in the selected language. The user can then make up to 6 guesses for the word. After each guess, the API responds with a feedback that includes the letters that are present in the word, whether they are in their correct positions, and which letters are not present in the word.

If the user successfully guesses the word within 6 attempts, the API returns a success message. If the user fails to guess the word within 6 attempts, the API returns a failure message. If the user does not complete the game within the 24-hour time limit, the game is automatically lost, and the API returns a failure message.

The first time a user registers, they can start playing the game immediately. After the first game, the user can start playing again 24 hours after the start of their previous game.

The API is designed to be easily integrated with mobile applications and can be used by developers to create mobile games that incorporate the "5 Letters" game.

## Stack of technologies

 - Ruby on Rails
 - dry-rb
 - PostgreSQL
 - sidekiq
 - rspec

## Links
 - [Base Api Url](https://fl-ruby.iakshankin.site/)
 - [Swagger](https://fl-ruby.iakshankin.site/swagger)
