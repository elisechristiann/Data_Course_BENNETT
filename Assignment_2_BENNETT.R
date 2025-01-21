#Write a command that lists all of the .csv files found and name as object "csv_files"

csv_files <- list.files(path="Data", pattern=".csv", all.files = TRUE, full.names = TRUE, 
           recursive=TRUE, ignore.case = TRUE)

#Find how many files match that description using the length() function

length(csv_files)

#Open the wingspan_vs_mass.csv file and store the contents as an R object named "df" using the read.csv() function

bird_wingspan_vs_mass<- list.files(path="Data", pattern="wingspan_vs_mass.csv",recursive=TRUE, full.names = TRUE)
df <- read.csv(bird_wingspan_vs_mass)

#Inspect the first 5 lines of this data set using the head() function

head(x=df,n=5L)

#Find any files (recursively) in the Data/ directory that begin with the letter "b" (lowercase)
b_files <- 
list.files(path="Data", pattern="^b", all.files=TRUE, recursive=TRUE, full.names=TRUE, ignore.case=FALSE )

#Write a command that displays the first line of each of those "b" files (this is tricky... use a for-loop)
for (f_line in b_files) {
  first_line <- readLines(f_line, n = 1)
  cat("first line", f_line, ":", first_line, "\n")
}
#Personal notes: "" is just for text around "\n"

#Do the same thing for all files that end in ".csv"
for (file in csv_files) {
  first_line_csv <- readLines(file,n=1)
  cat("first line",file,":",first_line_csv, "\n")
}
