# Code Exercise

  Write a Ruby program to first assemble a single set of records by parsing data from 3 different file formats and then display these records sorted in 3 different ways.

## Details

### The Data

A record consists of the following 5 fields: last name, first name, gender, date of birth and favorite color. You will be given 3 files, each containing records stored in a different format.

The pipe-delimited file lists each record as follows: 
    LastName | FirstName | MiddleInitial | Gender | FavoriteColor | DateOfBirth

The comma-delimited file looks like this: 
    LastName, FirstName, Gender, FavoriteColor, DateOfBirth

And lastly, the space-delimited file: 
    LastName FirstName MiddleInitial Gender DateOfBirth FavoriteColor

You may assume that the delimiters (commas, pipes and spaces) do not appear anywhere in the data values themselves. Write a Ruby program to read in records from these files and combine them into a single set of records.

## Display Requirements

* Create and display 3 different views of the recordset (see a sample here):
  * Output 1 – sorted by gender (females before males) then by last name ascending.
  * Output 2 – sorted by birth date, ascending.
  * Output 3 – sorted by last name, descending.
* Ensure that fields are displayed in the following order: last name, first name, gender, date of birth, favorite color.
* Display dates in the format MM/DD/YYYY.

## Packaging Requirements

* Please package the code in a zip or tar archive when you send it to us.
* Tell us which script or rake task to run in order to produce the desired output from your program.
* Specify what version of Ruby you’re using. You may use any official release of the CRuby interpreter.
* You may use the core and the standard library, but no gems, except Rake. If you do use Rake, specify the version.
