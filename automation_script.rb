puts "Select language / Choisir la langue\n1. English\n2. French"
lang_choice = gets.to_i
$flag=0
# This Class is used to determine the HAML files in the project which has
# image tags which may or may not conatain at attribute in it. The Script 
# is designed to look for multiple varities of defining an image tags and alt
# attribute in a HAML file. Once the script identifies the image tags it will
# determine if it contains alt attribute or not and would print appropriate
# message in output text file with respect to user's choice.
class ImageTagAutomation
    # Public check_image_attributes: Operates on a HAML file and determines if it contains
    # image tag and if image tag is present it will check if alt attribute is present or not
    #
    # Argument:
    # file_name - path of an haml file
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: -1 For incorrect parameters
    def check_image_attributes(file_name, user_choice_param)
        File.foreach(file_name) { |line_iterator|
            if line_iterator.match(/%img\b/) || line_iterator.match(/(=)(\s*)?img\b/) || line_iterator.match(/[^#."'](\s)?image_tag\b/) #Finding image tags in haml like %img, =img, =image_tag
                if (user_choice_param == 1 || user_choice_param == 3) #condition to match and work according to user's choice
                    if !line_iterator.match(/(:)?(\s*)?alt(\s*)?(=>)?(:)?(\s*)?["'](.*)\b/) #Finding if the image tag that does not contain alt attribute
                        File.open("output_file.txt", "a") { |f| f.write("\nFile Path : #{file_name}\nAt Line #{$.} : does not contain alt : #{line_iterator}") }
                        $flag=1
                    end
                end
                if (user_choice_param == 2 || user_choice_param == 3) #condition to match and work according to user's choice
                    if line_iterator.match(/(:)?(\s*)?alt(\s*)?(=>)?(:)?(\s*)?["'](.*)\b/)
                        File.open("output_file.txt", "a") { |f| f.write("\nFile Path : #{file_name}\nAt Line #{$.} : contain alt : #{line_iterator}") }
                        $flag=1
                    end
                end
                if !(user_choice_param == 2 || user_choice_param == 3 || user_choice_param == 1)
                    return -1
                end
            end
        }
    end

    # Public user_input: Function to get user's input and call the function to display appropriate message
    #
    # Argument:
    # path_name - path of directory/sub-directory which contains HAML files
    # lang_choice - language selected by the user
    #
    # Return: Call process_user_choice function
    def user_input(path_name, lang_choice) 
        if lang_choice==1
            puts "Enter your choice\n1. Display image tag without alt attribute\n2. Display image tag with alt attribute\n3. Display image tag with alt attribute and without alt attribute"
        else
            puts "Entrez votre choix\n1. Afficher image tag sans attribut alt\n2. Afficher image tag avec l'attribut alt\n3. Afficher image tag avec l'attribut alt et sans l'attribut alt"
        end
        user_choice = gets.to_i
        process_user_choice(user_choice,path_name, lang_choice)
    end

    # Public process_user_choice: Calls check_image_attributes funtion with right parameters with respect to user's choice
    #
    # Argument:
    # user_choice - choice provided by user
    # path_name - path of directory/sub-directory which contains HAML files 
    # lang_choice - language selected by the user
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: -1 For incorrect parameters
    def process_user_choice(user_choice, path_name, lang_choice)
        Dir[path_name].each{|file_iterator| #Iterating through each directories and sub-directories and passing the file name as a parameter to the function
        case user_choice
        when 1
            check_image_attributes(file_iterator,1) #Calling the check_image_attributes function by passing parameters i.e. the filename and the user's choic
        when 2
            check_image_attributes(file_iterator,2) #Calling the check_image_attributes function by passing parameters i.e. the filename and the user's choice
        when 3
            check_image_attributes(file_iterator,3) #Calling the check_image_attributes function by passing parameters i.e. the filename and the user's choice
        else
            $flag=2
            if lang_choice==1
                puts "Please provide proper choice"
            else
                puts "Veuillez fournir le bon choix"
            end
            return -1
        end
    }
    end

    # Public haml_existance_check: To check if the directories/subdirectories contains HAML files
    #
    # Argument:
    # path_name - path of directory/sub-directory which contains HAML files 
    # lang_choice - language selected by the user
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: -1 For incorrect parameters
    #                               0 to indicate method has sucessfully completed
    def haml_existance_check(path_name, lang_choice) 
        if Dir[path_name].any? 
            user_input(path_name, lang_choice)
            return 0
        else
            $flag=2
            if lang_choice==1
                puts "No HAML files found in the entered directory."
            else
                puts "Aucun fichier HAML trouvé dans le répertoire entré."
            end
            return -1
        end
    end

    # Public path_existance_check: To check if the entered directory path exists or not
    #
    # Argument:
    # path_name_param - path of directory/sub-directory which contains HAML files which is appended with "/**/*.haml"
    # path_name - path of directory/sub-directory which contains HAML files 
    # lang_choice - language selected by the user
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: -1 For incorrect parameters
    #                               0 to indicate method has sucessfully completed
    def path_existance_check(path_name_param,path_name,lang_choice)
        if Dir.exists?(path_name_param) 
            haml_existance_check(path_name, lang_choice)
            return 0
        else
            $flag=2
            if lang_choice==1
                puts "No such directory found"
            else
                puts "Aucun répertoire de ce type n'a été trouvé"
            end
            return -1
        end
    end

    # Public scenario_check: To check if scenarios exists with respect to user's choice
    #
    # Argument:
    # flag_param - the value of flag
    # lang_choice - language selected by the user
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: 0 to indicate method has sucessfully completed
    def scenario_check(flag_param, lang_choice)
        if flag_param==0
            if lang_choice==1
                puts "No such scenarios found"
            else
                puts "Aucun scénario de ce type n'a été trouvé"
            end
            return 0
        elsif flag_param==1
            if lang_choice==1
                puts "The desired output is saved in output_file.txt"
            else
                puts "La sortie souhaitée est enregistrée dans output_file.txt"
            end
            return 0
        else
            return -1
        end
    end

    # Public get_path: To ask user to input language and directory path
    #
    # Argument:
    # lang_choice - language selected by the user
    #
    # Return: Appropriate flags values if the file has been modified or not
    #         Values and Meanings: -1 to indicate incorrect parameters
    def get_path(lang_choice)
        if lang_choice==1
            puts "Enter the directory's path : "
        elsif lang_choice==2
            puts "Entrez le chemin du répertoire : "
        else
            puts "Please provide correct choice / Veuillez fournir le bon choix"
            $flag=2
            return -1
        end
        original_path_name = gets.chomp
        File.open("output_file.txt", "w") { |f| f.write("Output : \n") }
        #Appending "/**/*.haml" to path name provided by user to match the format required for parsing the directories and to consider haml files only
        path_name = original_path_name + "/**/*.haml"
        path_existance_check(original_path_name, path_name, lang_choice)
    end
end
object = ImageTagAutomation.new
object.get_path(lang_choice)
object.scenario_check($flag,lang_choice)
