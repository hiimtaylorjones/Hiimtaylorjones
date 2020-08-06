# Hiimtaylorjones Personal Site

## What Is This?

This project contains the content of my personal portfolio site. 

## Are You Still Updating It?

Yep! Recently, I've begun exploring updating the site and implementing 
what I've been learning recently into the project. At the very least, I'll 
be able to look at my old code and cringe a bit.

## Where Can I Actually Take A Look At It?

Its live [here](https://hiimtaylorjones.com).


## FAQ

### I'm having issues installing `therubyracer` locally when setting this up. How do I get around this?

For OSX, you can run the following:

```
brew install v8@3.15
bundle config build.libv8 --with-system-v8
bundle config build.therubyracer --with-v8-dir=$(brew --prefix v8@3.15)
bundle install
```