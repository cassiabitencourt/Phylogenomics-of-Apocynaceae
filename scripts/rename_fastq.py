import os
import pandas as pd

# Paths
folder_path = "/path/Gentianales_allraw_2024"
excel_path = "/path/Gentianales_allraw_2024/Table_Apocynaceae_names.xlsx"

# Read the Excel file
df = pd.read_excel(excel_path)

# Ensure the columns exist
if "old_names" not in df.columns or "new_names" not in df.columns:
    raise ValueError("Excel file must contain 'old_names' and 'new_names' columns.")

# Create a dictionary for renaming files
rename_dict = dict(zip(df['old_names'], df['new_names']))

# Rename files in the specified folder
for old_name, new_name in rename_dict.items():
    old_file_path = os.path.join(folder_path, old_name)
    new_file_path = os.path.join(folder_path, new_name)

    # Check if the old file exists before renaming
    if os.path.exists(old_file_path):
        os.rename(old_file_path, new_file_path)
        print(f"Renamed: {old_name} -> {new_name}")
    else:
        print(f"File not found: {old_name}")
