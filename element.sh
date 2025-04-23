SYMBOL=$1
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $SYMBOL ]]
then
  echo "Please provide an element as an argument."
else
  if [[ ! $SYMBOL =~ ^[0-9]+$ ]]
  then
    LENGTH=$(echo -n "$SYMBOL" | wc -m)
    if [[ $LENGTH -gt 2 ]]
    then
      # get data by full name
      DATA=$($PSQL "SELECT * FROM elements join properties on elements.atomic_number = properties.atomic_number join types on types.type_id = properties.type_id WHERE elements.name='$SYMBOL'")
      if [[ -z $DATA ]]
      then
        echo "I could not find that element in the database."
      else
        echo $DATA | while read BAR BAR SYMBOL BAR NAME BAR NUMBER BAR WEIGHT BAR MELTING BAR BOILING BAR BAR BAR TYPE BAR BAR
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    else
      # get data by symbol
      DATA=$($PSQL "SELECT * FROM elements join properties on elements.atomic_number = properties.atomic_number join types on types.type_id = properties.type_id WHERE elements.symbol='$SYMBOL'")
      if [[ -z $DATA ]]
      then
        echo "I could not find that element in the database."
      else
        echo $DATA | while read BAR BAR SYMBOL BAR NAME BAR NUMBER BAR WEIGHT BAR MELTING BAR BOILING BAR BAR BAR TYPE BAR BAR
        do
          echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
        done
      fi
    fi
  else
    # get data by atomic_number
    DATA=$($PSQL "SELECT * FROM elements join properties on elements.atomic_number = properties.atomic_number join types on types.type_id = properties.type_id WHERE elements.atomic_number=$SYMBOL")
    if [[ -z $DATA ]]
    then
      echo "I could not find that element in the database."
    else
      echo $DATA | while read BAR BAR SYMBOL BAR NAME BAR NUMBER BAR WEIGHT BAR MELTING BAR BOILING BAR BAR BAR TYPE BAR BAR
      do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
fi
