import os
import pandas as pd

def search_columns_from_csv(directory, input_columns):
    results = []

    for filename in os.listdir(directory):
        if filename.endswith(".csv"):
            file_path = os.path.join(directory, filename)
            df = pd.read_csv(file_path)

            # Check if the input columns are in the dataframe
            if all(column in df.columns for column in input_columns):
                result = df[input_columns]
                results.append(result)

    if results:
        final_result = pd.concat(results, ignore_index=True)
        return final_result
    else:
        return pd.DataFrame(columns=input_columns)

# Example usage
directory = '/Users/lokkit/Desktop/CS4400 denormalized data CSV file/Data_Files'
input_columns = ['routeID']  # Replace with your input columns

result_df = search_columns_from_csv(directory, input_columns)
print(result_df)
