# CAPSTONE PROJECT 3 : LINUX SHELL SCRIPTING

## The objective of this project is to create a Bash script that generates a multiplication table for a number entered by the user. 
## In this project I practiced using loops (C-style and list loop forms), applied conditional logics and handling user inputs in Bash scripting.

## Project Decsription: My script should prompt a user to enter a number and then ask if they prefer to see a full multiplication table from 1 to 10 or a partial table within a specified range. Based on the user's choice, the script will display the corresponding multiplication table.

### STEP 1: Creating a .sh file

![](./images/creating%20sh%20file.png)

### STEP 2: Prompting a user to enter a number for the multiplication table.

To get an input from a user, the statement below was used
```bash 
read -p "Enter a number for the multiplication table: " num
```
`read` is a built in command in linux that reads a line of input from a user.

`-p` allows to specify a prompt message that will be displayed to the user before their input is read.

`num` is the variable name used to store the users input. 

![](./images/user%20input.png)

To ensure the user inputs a valid positive/negative integer.

![](./images/valid%20integer.png)

### STEP 3: Ask if the user wants a full or a partial multiplication table.
Here you get to give the user an option to choose between a full or partial table. `f` or `p`
```bash 
read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " table
```
`table` is the variable name used to store the users input. 
![](./images/promp%20for%20f%20or%20p.png)

### STEP 4: For a partial multiplication table
If the user chooses `p`, the user wants a partial table which will prompt for a start and end number of the range.

```bash
read -p "Enter the starting number (between 1 and 10): " start
read -p "Enter the ending number (between 1 and 10): " end
```
Validating input range. Ensuring start number is not greater than end.
![](./images/validate%20p%20input.png)

To print partial table within the `start` and `end` numbers range using `C-style for loop`
```bash
echo "The partial multiplication table for $num from $start to $end:"

for ((i = start; i <= end; i++)); 
    do
        # prints multiplication table within range
        echo "$num x $i = $((num * i))"
    done
```
*__Full statement for partial table:__*
![](./images/partial%20table.png)

### STEP 5: For a full multiplication table
If the user chooses `f`, the full multiplication table of the initial value
that was entered for the `num` variable will be displayed.
This will be done using `list form loop`.

```bash
for i in {1..10}; 
do
    echo "$num x $i = $((num * i))"
done
```
*__Full statement for full table:__*

![](./images/print%20f%20table.png)

### STEP 6: HANDLING INVALID ENTRY FOR FULL OR PARTIAL TABLE
If the user inputs a wong input other than `p` or `f` the user will be directed to run the script again.
![](./images/invalid%20f%20or%20p.png)

### STEP 7: ADDED A BONUS TASK TO ASK IF THE USER WANTS TO SEE THE TABLE IN ASCENDING OR DESCENDING ORDER. 
This will be implemented using if else combined with my loop of choice. I added this task for the full multiplication table only.

When the user inputs `f` for full table.
it prompts another question to the user:
```bash
read -p "Do you want the table in ascending or descending order? (Enter 'a' for ascending, 'd' for descending): " order
```
It assigns the value the user inputs here to the variable `order`.
![](./images/ask%20for%20a%20or%20d.png)


If the user chooses `a or d` as the value for `order` variable, the full multiplication table of the initial value `num` will be displayed in either ascending or descending order.
This will be done using both `list form & C-style loop`.

```bash
if [ "$order" = "a" ]; then
        for i in {1..10}; do
            echo "$num x $i = $((num * i))"
        done
else
    for ((i=10; i>=1; i--)); do
        echo "$num x $i = $((num * i))"
    done
fi
```

![](./images/print%20if%20a%20or%20d.png)



# NOW LET'S RUN THE SCRIPTS AND TEST IF IT WORKS

## 1. Running the script to display the outputs
This is done with the following command `./multiple.sh`
![](./images/run%20the%20script.png)

## 2. Displaying user's `num` input.
* __When a user enters a positive/negative integer value for `num` variable.__

E.g: When the user inputed a positive integer `7`. It prompted the message: *"You have entered the number 7"*
![](./images/test%20for%20valid%20num.png)

E.g: When the user inputed a negative integer `-10`. It prompted the message: *"You have entered the number -10"*
![](./images/test%20for%20valid%20-%20num.png)

* __When a user enters an invalid value for `num` variable.__
It prompts the message invalid input when a user inputs a letter instead of a positive/negative integer.
E.g: here the user inputted the letter `t`. It prompted invalid input, Enter a number.
![](./images/test%20for%20invalid%20num.png)


## 3. Displaying for full multiplication table.
This displays the output when the user selects `f` for full multiplication table.

E.g: Here, the user entered number `7` and `-10`, This shows the full multiplication table of the numbers.

It displays the multiplication table of the users input; `num` from ranges `1-10`

E.g;
```bash
Full multiplication table for 7
7 x 1 = 7
7 x 2 = 14
7 x 3 = 21 
7 x 4 = 28
7 x 5 = 35
7 x 6 = 42
7 x 7 = 49
7 x 8 = 56
7 x 9 = 63
7 x 10 =70
```

Full multiplication table for 7
![](./images/testing%20for%20positive%20f%20table.png)

Full multiplication table for -10
![](./images/testing%20for%20negative%20f%20table.png)


## 3. Displaying for partial multiplication table.

This displays the output when the user selects `p` for partial multiplication table.

It prompts the user to enter a `start` number and an `end` number. 
The start number has to be lesser than or equal to the end number. `(start <= end)` Both start and end numbers have to be numbers between the ranges of `1-10`

E.g: The user entered `12` for the multiplication table value. Then inputted `3` as the `start number` and `8` as the `end number`.
E.g;
```bash
Partial multiplication table for 12 from 3-8
12 x 3 = 36
12 x 4 = 48 
12 x 5 = 60
12 x 6 = 72
12 x 7 = 84 
12 x 8 = 96
```

![](./images/test%20for%20valid%20partial%20table.png)

* ### To test for invalid range. i.e the `start > end`
E.g: The user entered `5` for the multiplication table value. Then inputted `6` as the `start number` and `2` as the `end number`.

Since `6 is greater than 2`, 

This will print: *Invalid input. Please enter numbers between 1 and 10, and ensure that the starting number is less than or equal to the ending number.
Showing full table instead.*

It print the full multiplication table of 5.

![](./images/test%20for%20invalid%20partial%20table.png)

* ### To test for invalid range. i.e the `start and end value is not between 1 and 10`
E.g: The user entered `1` for the multiplication table value. Then inputted `-9` as the `start number` and `30` as the `end number`.

Since both `-9 and 30 are not numbers between 1-10`, 

This will print: *Invalid input. Please enter numbers between 1 and 10, and ensure that the starting number is less than or equal to the ending number.
Showing full table instead.*

It print the full multiplication table of 1.

![](./images/test%20for%20invalid%20p%20table%20not%20between%201%20and%2010.png)

## 4. To test when a user enters a void or invalid input for `table` variable
This is to test for when a user inputs a value that is not `p` or `f` when asked: 
```bash
read -p "Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial): " table
```
* E.g: The user entered `50` for the multiplication table value. Then when asked to choose between partial or full table, `p or f` the user enters an invalid input `r`.

It prompts the message: *Invalid input. Please enter 'f' for full or 'p' for partial.*

And ask the user again: *Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial)*

![](./images/test%20for%20invalid%20f%20or%20p.png)

* E.g: The user entered `40` for the multiplication table value. Then when asked to choose between partial or full table, `p or f` the user enters an invalid input `7`.

It prompts the message: *Invalid input. Please enter 'f' for full or 'p' for partial.*

And ask the user again: *Do you want a full table or a partial table? (Enter 'f' for full, 'p' for partial)*
![](./images/test%20for%20invalid%20p%20or%20f.png)

## 5. To test for BONUS: Testing for both ascending or descending order.
E.g: Here, the user entered the numbers `5` and `8`. 
When asked for full or partial multiplication table he chooses `f`.
It proceeds to asking the user to choose between  `a` or `d` for ascending or descending order.

When the user chooses `a` it prints the full multiplication table in ascending order.
```bash
The multiplication table for 8:
8 x 1 = 8
8 x 2 = 16
8 x 3 = 24
8 x 4 = 32
8 x 5 = 40
8 x 6 = 48
8 x 7 = 56
8 x 8 = 64
8 x 9 = 72
8 x 10 = 80
```

When the user chooses `d` it prints the full multiplication table in descending order.
```bash
The multiplication table for 5:
5 x 10 = 50
5 x 9 = 45
5 x 8 = 40
5 x 7 = 35
5 x 6 = 30
5 x 5 = 25
5 x 4 = 20
5 x 3 = 15
5 x 2 = 10
5 x 1 = 5
```
![](./images/test%20for%20bonus.png)

# CONCLUSION
This project helped me understand how to store users inputs properly and use them in calculations. 
Practiced the use of loops.
There is comments in every step to explain what each line of code does.
