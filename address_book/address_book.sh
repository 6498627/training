#!/bin/bash

red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
yellow='\033[0;33m'
plain='\033[0m'

BOOK="book.txt"

#############################
show_menu() {
    echo "
0. show address book
1. add contact
2. find contact
3. delete contact
4. edit contact
"
    read -p "Please enter your selection [0-4]: " num

    case "${num}" in
    0)
        show_address_book
        ;;
    1)
        #show_menu_add_contact
        add_contact
        ;;
    2)
        find_contact
        ;;
    3)
        del_contact
        ;;
    4)
        edit_contact
        ;;
    *)
        exit 0
        ;;
    esac
}
#############################


#############################
# показать адресуную книгу 
show_address_book() {
    echo " "
    echo " "
    sed 's/;//g' $BOOK
    echo " "

    echo -n "
    1. return to main menu
    2. exit
    "
    echo " "
    read return_exit

    if [ "$return_exit" == "1" ]
    then show_menu
    else exit
    fi
}
#############################

#############################
# добавить контакт
    add_contact() {

        echo "enter first name"
        read first_name
        echo "enter last name"
        read last_name
        echo "enter phone"
        read phone
        printf "\nfirst name: $first_name\nlast name: $last_name\nphone: $phone\n\n"
        echo -n "save contact y/n: "
        read answer
        
        if [ "$answer" == "y" ]
        then echo "$first_name ; $last_name ; $phone" >> $BOOK ; echo "contact save" ; show_menu
        else show_menu
        fi
    }
#############################

find_contact() {

    read -p "enter name or phone number " finder
    echo -e "${green}$finder${plain} found  "
    echo " "
    grep "$finder" $BOOK
    
    echo -n -e "
    1. return to main menu
    2. ${red}exit${plain}
    "
    echo " "
    read return_exit

    if [ "$return_exit" == "1" ]
    then show_menu
    else exit
    fi



}
#############################

#############################
# удалить контакт

del_contact() {

    echo "enter delete contact"
    read del
    echo "enter first name"
    read del2
    echo "enter last name"

    echo -n "delete contact $del $del2 ? "
    read -p "y/n" conf_del
    
    if [ "$conf_del" == "y" ]
    then sed -i /"$del ; $del2"/d $BOOK 
    else show_menu
    fi

    echo "contact "$del" deleted"

     echo -n -e "
    1. return to main menu
    2. ${red}exit${plain}
    "
    echo " "
    read return_exit

    if [ "$return_exit" == "1" ]
    then show_menu
    else exit
    fi

}

edit_contact() {
    echo " "
    nl $BOOK
    echo " "
    echo "enter line"
    read line 
    echo "enter name for edit contact"
    read edit
    echo "enter new name"
    read new_name
    echo "save new name? "
    echo "y/n "
    read change_edit
    if [ "$change_edit" == "y" ]
    then sed -i "${line}s/${edit}/${new_name}/g" "$BOOK"; sync; show_menu
    else show_menu
    fi
}


# начало скрипта
show_menu