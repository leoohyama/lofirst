#Testing functions
#script used for testing package functions

#data for testing
df<-datasets::iris

#testing num_to_cat
num_to_cat(data = df, num = "Petal.Length",
           cat_name = "NewCategories",
           cat_no = 4,
           labels = c( "c", "d", "f", "r"))
