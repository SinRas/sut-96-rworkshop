# Required Libraries
library(readxl)

# Read the Data
survey = read_excel('data/Takaneh/Takaneh-Survey.xlsx')
length(unique(survey$Lecturer))
length(unique(survey$Course))

# Fake Names
fake_names = read.csv('data/Takaneh/fake_names.csv')[,1]
fake_courses = read.csv('data/Takaneh/fake_courses.csv')

# Replace Names
N_names = length( unique(survey$Lecturer) )
look_names = fake_names[1:N_names]
names(look_names) = unique(survey$Lecturer)
look_names[29] = NA
new = survey
new$Lecturer = look_names[ new$Lecturer ]

# Replace Courses
N_courses = length( unique(survey$Course) )
look_courses = fake_courses[1:N_courses,1]
names(look_courses) = unique(survey$Course)
look_courses[37] = NA
new$Course = look_courses[ new$Course ]

# Write
write.csv(x = new, file = 'data/Takaneh/faked.csv')