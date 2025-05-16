#!/bin/bash

# Function to validate if input is an integer
is_integer() {
  [[ "$1" =~ ^-?[0-9]+$ ]]
}

# Function to display the multiplication table using list-form loop
generate_table_list_form() {
  echo ""
  echo "Multiplication Table for $number (List-form loop)"
  if [ "$order" == "desc" ]; then
    for i in 10 9 8 7 6 5 4 3 2 1; do
      echo "$number x $i = $((number * i))"
    done
  else
    for i in 1 2 3 4 5 6 7 8 9 10; do
      echo "$number x $i = $((number * i))"
    done
  fi
}

# Function to display the multiplication table using C-style loop
generate_table_c_style() {
  echo ""
  echo "Multiplication Table for $number (C-style loop)"
  if [ "$order" == "desc" ]; then
    for (( i=10; i>=1; i-- )); do
      echo "$number x $i = $((number * i))"
    done
  else
    for (( i=1; i<=10; i++ )); do
      echo "$number x $i = $((number * i))"
    done
  fi
}

# Function for partial table
generate_partial_table() {
  echo ""
  echo "Partial Multiplication Table from $start to $end"
  if [ "$order" == "desc" ]; then
    for (( i=$end; i>=$start; i-- )); do
      echo "$number x $i = $((number * i))"
    done
  else
    for (( i=$start; i<=$end; i++ )); do
      echo "$number x $i = $((number * i))"
    done
  fi
}

while true; do
  # Ask user for number
  read -p "Enter a number for the multiplication table: " number

  if ! is_integer "$number"; then
    echo "Invalid input. Please enter a valid number."
    continue
  fi

  # Ask for full or partial table
  read -p "Do you want a full table (1 to 10) or partial table? Enter 'full' or 'partial': " choice

  # Ask for ascending or descending order
  read -p "Do you want the table in ascending or descending order? (asc/desc): " order
  if [[ "$order" != "asc" && "$order" != "desc" ]]; then
    echo "Invalid order. Defaulting to ascending."
    order="asc"
  fi

  if [[ "$choice" == "partial" ]]; then
    read -p "Enter the start of the range: " start
    read -p "Enter the end of the range: " end

    if ! is_integer "$start" || ! is_integer "$end" || [ "$start" -gt "$end" ]; then
      echo "Invalid range. Defaulting to full table."
      generate_table_list_form
      generate_table_c_style
    else
      generate_partial_table
    fi

  elif [[ "$choice" == "full" ]]; then
    generate_table_list_form
    generate_table_c_style
  else
    echo "Invalid choice. Defaulting to full table."
    generate_table_list_form
    generate_table_c_style
  fi

  # Ask if user wants to run again
  read -p "Do you want to generate another table? (yes/no): " repeat
  if [[ "$repeat" != "yes" ]]; then
    echo "Goodbye!"
    break
  fi

done

