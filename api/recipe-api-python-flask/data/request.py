from sqlalchemy import create_engine, text

class Results:
	def __init__(self, results):
		self.results = results

def exec(proc_name, proc_args):
	# Declare results list
	results = [];
	
	# Create an engine
	engine = create_engine("mysql+pymysql://root:abc123@localhost:3306/recipe")

	# Build the query
	query = f'CALL {proc_name}'

	if len(proc_args) > 0:
		query = f'{query}('

		for arg in proc_args:
			query = f'{query}{arg['arg_value']}, '

		query = f'{query[:-2]})'

	# Connect to the database
	with engine.connect() as connection:

		# Call the stored procedure
		result = connection.execute(text(query))

		# While loop to iterate result sets
		while True:
			result_set = []

			# Iterate rows in result set
			for row in result:
				result_set.append(dict(row._mapping))

			# Append result set to results list
			results.append(result_set)

			# Advance to the next set
			result.nextset()

			if result.cursor.count() == 0:
				break
