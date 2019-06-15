#!/bin/bash
#The list is used for the language generotor
languages=( "Chinese" "Korean" "Japanese" "English" "Russian" "Franch" "German" "Portuguese" "Spanish" "Swiedish" "Swiss" "Thai" )
# Direct user into the right folder
cd /home/uowstudent/Desktop/251/languageLearning
#getUserInput funtion reads the user input then us a cas function to do the right stuff
getUserInput(){
    echo "Please type in a command!"
    read userInput;
    case $userInput in
        View)
            View
            ;;
        ViewAll)
            ViewAll
            ;;
        Content)
            Content
            ;;
        Go)
            Go
            ;;
        Back)
            Back
            ;;
        Generate)
            Generate
            ;;
		Options)
            Options
            ;;
		Explanation)
            Explanation
            ;;
        Exit)
            echo "Thanks for using this App!"
            exit 1
            ;;
        *)
            echo "Invalid Input!!"
            getUserInput
          ;;
    esac

}
#Options function shows the menu of commands
Options(){
	echo "###########################################"
	echo "#######                             #######"
	echo "#######     DIRATORY EXPLORER       #######"
	echo "#######                             #######"
	echo "###########################################"
	echo "#######                             #######"
	echo "#######            View             #######"
	echo "#######           ViewAll           #######"
	echo "#######           Content           #######"
	echo "#######           Options           #######"
	echo "#######         Explanation         #######"
	echo "#######             Go              #######"
	echo "#######            Back             #######"
	echo "#######          Generate           #######"
	echo "#######            Exit             #######"
	echo "#######                             #######"
	echo "###########################################"
	getUserInput
}
#Explanation function shows the explanation of the commands
Explanation(){
	echo "View          : Find files with a string"
	echo "ViewAll       : Find all files in the current directory"
	echo "Content       : Print out the content of a file"
	echo "Options       : Bring up the menu of commands"
	echo "Explanation   : Explanations of the commands"
	echo "Go            : Go in to a folder in the current directory"
	echo "Back          : Go to the previous directory"
	echo "Generate      : Generate a random language"
	echo "Exit          : Exit the program"
	getUserInput
}
#View function asks for a user input, then find all files or folders which are containing the user input
View(){
    echo "Search files with a string!";
    read viewX;
    if ! ls | grep $viewX; then
        echo "No files contain that string!" >&2;
    fi
	getUserInput
}
#ViewAll function whcih Shows all files and folders in the current directory.
ViewAll(){
	if ! ls; then
        echo "No files existed" >&2;
    fi
	getUserInput

}
#Content function which asks a user input of a filename, then show the content of that file, user will only be asked for the file name without the extension of the file.
Content(){
    echo "Enter the name of a text file: ";
    read contentX;
    contentX="${contentX}.txt"
    if ! cat $contentX 2>/dev/null; then
        echo "No file found!";
    fi
	echo ""
	getUserInput
}
#Go function directs the user to a folder in the current directory.
Go(){
    echo "Which folder are you trying to go?";
    read goX;
    if ! cd $goX 2>/dev/null; then
        echo "Cannot find the folder to go!";
    fi
	echo "You are in the folder of ${PWD##*/}"
	getUserInput

}
#Back function brings the user back to the pervious Directory.
Back(){
	stringPWD=$(pwd)
    if [ "$stringPWD" == "/home/uowstudent/Desktop/251/languageLearning" ]; then
		echo "Sorry, you are already at the root folder!";
    else
		cd ../
		cwd=${PWD##*/}
		if [ "$cwd" == "languageLearning" ]; then
			echo "You are in the root folder"
		else
			echo "You are in the $cwd folder"
		fi
    fi
	getUserInput

}
#Generate function generates a random language for the user to learn.
Generate(){
	# If looped through all languages in the array, return a message.
	if [ "${#languages[@]}" -eq "1" ]; then
		echo "Sorry, we do not have a language that you like!!"
		repeat
	fi
    echo "Generating a language for you......"
    sleep 3s

    rand=${languages[RANDOM % ${#languages[@]}]}

	#Check if it is empty, if it is, loop until it is not empty.
	while test -z "$rand"
	do
    	rand=${languages[RANDOM % ${#languages[@]}]}
	done
    echo $rand
    languages=( "${languages[@]/$rand}" )

	#Apperantly, when remove item, only removes the value not the container, do find if there is no value, remove the container
    for i in "${!languages[@]}"; do 
		[ -n "${languages[$i]}" ] || unset "languages[$i]" 
    done
	getUserInput

}
#Call a menu function and a getUserInput function
Options
getUserInput
