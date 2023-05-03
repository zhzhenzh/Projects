#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE games, teams")

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  # INSERT INTO teams
  if [[ $WINNER != 'winner' ]]
  then
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    if [[ -z $TEAM_ID ]]
    then
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo insert $WINNER
      fi
    
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi
    if [[ $TEAM_ID == $($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'") ]]
    then
      WINNER_ID=$TEAM_ID
      echo $WINNER_ID
    fi
    if [[ $OPPONENT != 'opponent' ]]
    then
      TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

      if [[ -z $TEAM_ID ]]
      then
        INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
        if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
        then
          echo insert $OPPONENT
        fi
       
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
      fi
      if [[ $TEAM_ID == $($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'") ]]
      then
        OPPONENT_ID=$TEAM_ID
        echo $OPPONENT_ID
      fi
      # INSERT INTO games
      if [[ ($YEAR != 'year') && ($ROUND != 'round') && ($WINNER_GOALS != 'winner_goals') && ($OPPONENT_GOALS != 'opponent_goals') ]]
      then
        INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID)")
        if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
        then
          echo insert data
        fi
      fi
    fi
  fi
done
