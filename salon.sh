#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Welcome to Salon~~~~~\n"

echo "Here is our services, choose one:"
MAIN_MENU() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
#services
  SERVICES=$($PSQL "SELECT service_id, name FROM services")
  ID=()
  echo "$SERVICES" | while read SERVICE_ID BAR SERVICE_NAME
    do
      echo "$SERVICE_ID) $SERVICE_NAME"
    done

  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    *)
    if [[  $SERVICES == *"$SERVICE_ID_SELECTED"* ]]
    then 
      PICK_MENU
    else 
      MAIN_MENU "Could you repeat? That service doesn't exist."
    fi
    ;;
  esac
}

PICK_MENU() {
  echo -e "\nGreat! Just a few more questions before to make an appointment. Name your phone number:"
  read CUSTOMER_PHONE

  # chech if we have this customer
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone='$CUSTOMER_PHONE'")

  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
  
    INSERT_CUSTOMER_RESULT=$($PSQL "INSERT INTO customers(name, phone) VALUES('$CUSTOMER_NAME','$CUSTOMER_PHONE')")
  fi

  echo -e "\nWhat time is more suitable for you?"
  read SERVICE_TIME

  # get customer id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone='$CUSTOMER_PHONE'")

  INSERT_APPOINTMENT_RESULT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
  echo -e "\nI have put you down for a $(echo $($PSQL "SELECT name FROM services WHERE service_id=$SERVICE_ID_SELECTED") | sed -E 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME | sed -E 's/^ *| *$//g')."
}

MAIN_MENU