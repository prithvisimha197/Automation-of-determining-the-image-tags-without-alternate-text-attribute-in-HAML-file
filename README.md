# About:
I was going through a directory which contains multiple HAML files and I observed that some of the image tags contained alt attribute and some of the image tags did not contain alt attributes. So I thought of automating the process and alleviate the programmer by designing a ruby script that would display the list of image tag which does not contain the alt attribute, image tag which contains alt attribute or both image tag with and without alt attributes according to the user's choice and display such image tags along with the directory path.

# Prerequisites:
- Ruby version 2.6.4
- rspec
- bundler

# Instruction to Run:
- Clone the Git Repository into the local machine
- Install bundle using $bundle install
- Run the Ruby Program using $ruby automation_script.rb
- Enter the directory path which contains the HAML files
- The console will display the appropriate message as an output
