# import pandas as pd

# Load_filepath = "/Users/lokkit/Desktop/CS4400 denormalized data CSV file"

#df_Cruise = pd.read_csv('Data_Files/Cruises Entity.csv')
#df_Locations = pd.read_csv('Data_Files/Locations Entity.csv')
#df_Persons = pd.read_csv('Data_Files/Persons Entity.csv')
#df_Ports = pd.read_csv('Data_Files/Ports Entity.csv')
#df_Routes = pd.read_csv('Data_Files/Routes Entity.csv')
#df_Ships = pd.read_csv('Data_Files/Ships Entity.csv')

#Entity_List = [df_Cruise, df_Locations, df_Persons, df_Ports, df_Routes, df_Ships]

#print(df_Cruise)
#print(df_Locations)
#print(df_Persons)
#print(df_Ports)
#print(df_Routes)
#print(df_Ships)

import os
import pandas as pd

def csv_to_sql_insert(directory, table_name, output_file):
    insert_statements = []

    for filename in os.listdir(directory):
        if filename.endswith(".csv"):
            file_path = os.path.join(directory, filename)
            df = pd.read_csv(file_path)
            
            for _, row in df.iterrows():
                columns = ', '.join(row.index)
                values = ', '.join([f"'{str(value).replace('\'', '\'\'')}'" for value in row.values])
                insert_statement = f"INSERT INTO {table_name} ({columns}) VALUES ({values});"
                insert_statements.append(insert_statement)
    
    with open(output_file, 'w') as file:
        file.write('\n'.join(insert_statements))
    
    print(f"SQL insert statements have been written to {output_file}")

# Example usage
directory = '/Users/lokkit/Desktop/CS4400 denormalized data CSV file/Data_Files'
table_name = 'your_table_name'
output_file = 'output.sql'

csv_to_sql_insert(directory, table_name, output_file)



