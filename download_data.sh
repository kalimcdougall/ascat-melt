#! /bin/bash

# specify product type and years for script
base="https://ftp.scp.byu.edu/data/ascat/"
sensor="msfa"
region="Ant"
start_year=2020
stop_year=2020
day_increment=0 # use 0 for daily, 1 for two-day, 4 for four-day images

echo "Downloading $sensor for years $start_year to $stop_year"

# Create directories for each year
for year in $(seq $start_year 1 $stop_year); do
    echo "Processing year $year"
    mkdir -p "$year"
done

# begin main script
for year in $(seq $start_year 1 $stop_year); do 
    echo "Processing year $year"

    # create two-digit year string
    YR=${year:2:4}

    start_day=1
    stop_day=366

    for day in $(seq $start_day 1 $stop_day); do 
        # create three-digit day strings
        DY1="${day}"
        if [ ${day} -lt 100 ]; then
            if [ ${day} -lt 10 ]; then
                DY1="00$day"
            else
                DY1="0$day"
            fi
        fi

        # create three-digit day strings
        let day2=${day}+${day_increment}
        DY2=${day2}
        if [ ${day2} -lt 100 ]; then
            if [ ${day2} -lt 10 ]; then
                DY2="00$day2"
            else
                DY2="0$day2"
            fi
        fi

        fname="$sensor-a-$region$YR-$DY1-$DY2.sir.gz"
        full_path="$base$year/sir/$sensor/$region/$DY1/a/$fname"
        echo "wget -q $full_path"
        wget -q -c "$full_path"

        # Move downloaded files to respective year directory
        mv "$fname" "$year/"
    done
done