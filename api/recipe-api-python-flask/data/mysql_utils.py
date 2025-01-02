import mysql.connector

dev call_sproc:

# Establish a connection to the database
mydb = mysql.connector.connect(
  host="your_database_host",
  user="your_username",
  password="your_password",
  database="your_database_name"
)

# Create a cursor object
mycursor = mydb.cursor()

# Define the parameters for the stored procedure
procedure_name = "your_stored_procedure_name"
param1 = "value1"
param2 = 123

# Call the stored procedure
mycursor.callproc(procedure_name, (param1, param2))

# Fetch the results (if any)
for result in mycursor.stored_results():
    print(result.fetchall())

# Close the cursor and connection
mycursor.close()
mydb.close()