# darkmode

A new Flutter application.

## Getting Started

This project is a basic mechanism on how to handle theme with system & user preference. By default it takes system preference and if user changes the theme then the user setting gets the first preference.

We have just used 2 plugins to achieve this.

1. shared_preferences - to save the theme toggled by user
2. provider - to provide the changes to theme in realtime

To get your theme setup you can use the below link

https://rxlabz.github.io/panache_web/#/

Note :- If you are using the above link for theme generation make sure to change primarySwatch to a material color and add a theme for floatingactionbutton with a foreground color property. you can refer example in the config file. 
