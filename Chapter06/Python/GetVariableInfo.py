
# Retrieve a variable information based on the 
# parameters provided. The data is returned as
# a list of tuples
v15 = censusdata.search(
    'acs5',2015,'concept', 
    'PLACE OF BIRTH BY AGE IN THE UNITED STATES')

# Converts the list of tuples to a data frame
df_V15 = pd.DataFrame(
    v15, columns = ['Name', 'Concept', 'Label']) 

# Saves the data frame as a csv file
df_V15.to_csv("Test.csv")