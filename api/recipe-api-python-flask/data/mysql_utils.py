# https://dev.mysql.com/doc/connector-python/en/
import mysql.connector

def call_proc(proc_args, proc_name):
	"""
	Calls a stored procedure using the mysql.connector callproc method
	:param proc_args: a list of name value pair dictionaries containing the proc arguments
	:param proc_name: a string containing the name of the stored procedure
	:return: returns a list of result sets, each set being a list of rows, each row being
		a dictionary with the column name as the key and the value returned from mysql as 
		the value - this can be mapped to the standard json api response format in the 
		calling method (e.g. { data: { // json data here } }) 
	"""

	# Establish a connection to the database
	mysql_connection = mysql.connector.connect(
	  host="localhost",
	  user="root",
	  password="abc123",
	  database="recipe"
	)

	# Create a cursor object
	mysql_cursor = mysql_connection.cursor()

	# Call the stored procedure
	mysql_cursor.callproc(proc_name, [arg.get('arg_value') for arg in proc_args])

	# Build response object - associate column names with returned values - works with 
	# multiple result sets
	response = [];

	# Iterate each result set in response
	for stored_result in mysql_cursor.stored_results():
		result_set = []

		#rows = stored_result.fetchall()
		row_names = stored_result.column_names

		# Iterate each row in the result set
		for row in stored_result.fetchall():
			result_row = {}

			# Iterate each item in the row
			for index, item in enumerate(row):
				result_row[row_names[index]] = item

			result_set.append(result_row)

		response.append(result_set)
		
	# Close the cursor and connection
	mysql_cursor.close()
	mysql_connection.close()

	return response