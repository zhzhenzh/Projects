#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")

if [[ -z $USER_ID ]]
then
  echo "Welcome, $USERNAME! It looks like this is your first time here."
  INSERT_USERNAME=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
else
  GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE user_id=$USER_ID")
  BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE user_id=$USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# guessing game

SECRET_NUMBER=$(( $RANDOM % 1000 + 1 ))
#echo $SECRET_NUMBER


GUESS() {
  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  echo "Guess the secret number between 1 and 1000:"
  read GUESSING_NUMBER

  NUMBER_OF_GUESSES=0
  while true
  do
    if [[ ! $GUESSING_NUMBER =~ ^[0-9]+$ ]]
    then
      echo -e "\nThat is not an integer, guess again:"
      read GUESSING_NUMBER
      echo $GUESSING_NUMBER
    else
      if [[ $GUESSING_NUMBER -gt 1000 || $GUESSING_NUMBER -eq 0 ]]
      then
        echo "I told you that the number should be between 1 and 1000. Restart the game."
        exit
      fi
      if [[ $GUESSING_NUMBER -eq 1000 && $GUESSING_NUMBER -ne $SECRET_NUMBER ]]
      then
        echo -e "\nIt's lower than that, guess again:"
        NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
        echo $NUMBER_OF_GUESSES
        read GUESSING_NUMBER
        echo $GUESSING_NUMBER
        continue
      fi
      if [[ $GUESSING_NUMBER -gt $SECRET_NUMBER ]]
      then
        echo -e "\nIt's lower than that, guess again:"
        NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
        echo $NUMBER_OF_GUESSES
        read GUESSING_NUMBER
        echo $GUESSING_NUMBER
        continue
      fi
      if [[ $GUESSING_NUMBER -lt $SECRET_NUMBER ]]
      then
        echo -e "\nIt's higher than that, guess again:"
        NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
        echo $NUMBER_OF_GUESSES
        read GUESSING_NUMBER
        echo $GUESSING_NUMBER
      fi
      if [ $GUESSING_NUMBER -eq $SECRET_NUMBER ]
      then
        NUMBER_OF_GUESSES=$((NUMBER_OF_GUESSES+1))
        echo $NUMBER_OF_GUESSES
        echo -e "\nYou guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
        break
      fi
    fi
  done

# insert values

GAMES_PLAYED=$($PSQL "SELECT games_played FROM users WHERE username='$USERNAME'")
if [[ -z $GAMES_PLAYED ]]
then
  GAMES_PLAYED=1
else
  GAMES_PLAYED=$((GAMES_PLAYED+1))
fi
UPDATE_GAMES_PLAYED=$($PSQL "UPDATE users SET games_played=$GAMES_PLAYED WHERE username='$USERNAME'")

BEST_GAME=$($PSQL "SELECT best_game FROM users WHERE username='$USERNAME'")
if [[ -z $BEST_GAME ]]
then
  BEST_GAME=$NUMBER_OF_GUESSES
  UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=$BEST_GAME WHERE username='$USERNAME'")
else
  if [[ $BEST_GAME > $NUMBER_OF_GUESSES ]]
  then
    BEST_GAME=$NUMBER_OF_GUESSES
    UPDATE_BEST_GAME=$($PSQL "UPDATE users SET best_game=$BEST_GAME WHERE username='$USERNAME'")
  fi
fi

}

GUESS
