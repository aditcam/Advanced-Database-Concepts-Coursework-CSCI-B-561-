#-- Python data for schemas and instances for assignment 1


# Student(sid: integer, sname: text, homeCity: text)

Student = [
 {'sid' : 1001, 'sname' : 'Jean', 'homeCity' : 'Cupertino'},
 {'sid' : 1002, 'sname' : 'Vidya', 'homeCity' : 'Cupertino'},
 {'sid' : 1003, 'sname' : 'Anna', 'homeCity' : 'Seattle'},
 {'sid' : 1004, 'sname' : 'Qin', 'homeCity' : 'Seattle'},
 {'sid' : 1005, 'sname' : 'Megan', 'homeCity' : 'MountainView'},
 {'sid' : 1006, 'sname' : 'Ryan', 'homeCity' : 'Chicago'},
 {'sid' : 1007, 'sname' : 'Danielle', 'homeCity' : 'LosGatos'},
 {'sid' : 1008, 'sname' : 'Emma', 'homeCity' : 'Bloomington'},
 {'sid' : 1009, 'sname' : 'Hasan', 'homeCity' : 'Bloomington'},
 {'sid' : 1010, 'sname' : 'Linda', 'homeCity' : 'Chicago'},
 {'sid' : 1011, 'sname' : 'Nick', 'homeCity' : 'MountainView'},
 {'sid' : 1012, 'sname' : 'Eric', 'homeCity' : 'Cupertino'},
 {'sid' : 1013, 'sname' : 'Lisa', 'homeCity' : 'Indianapolis'},
 {'sid' : 1014, 'sname' : 'Deepa', 'homeCity' : 'Bloomington'},
 {'sid' : 1015, 'sname' : 'Chris', 'homeCity' : 'Denver'},
 {'sid' : 1016, 'sname' : 'YinYue', 'homeCity' : 'Chicago'},
 {'sid' : 1017, 'sname' : 'Latha', 'homeCity' : 'LosGatos'},
 {'sid' : 1018, 'sname' : 'Arif', 'homeCity' : 'Bloomington'},
 {'sid' : 1019, 'sname' : 'John', 'homeCity' : 'NewYork'}]


# Department(deptName: text, mainOffice: text)

Department = [
 {'deptName' : 'CS', 'mainOffice' : 'LuddyHall'},
 {'deptName' : 'DataScience', 'mainOffice' : 'LuddyHall'},
 {'deptName' : 'Mathematics', 'mainOffice' : 'RawlesHall'},
 {'deptName' : 'Physics', 'mainOffice' : 'SwainHall'},
 {'deptName' : 'Biology', 'mainOffice' : 'JordanHall'},
 {'deptName' : 'Chemistry', 'mainOffice' : 'ChemistryBuilding'},
 {'deptName' : 'Astronomy', 'mainOffice' : 'SwainHall'}]



# Major(major: text)

Major = [
 {'major' : 'CS'},
 {'major' : 'DataScience'},
 {'major' : 'Physics'},
 {'major' : 'Chemistry'},
 {'major' : 'Biology'}
]    


# aa(sid: integer,deptName:text,salary:integer)

employedBy = [ {'sid' : 1001, 'deptName' : 'CS', 'salary' : 65000},
 {'sid' : 1002, 'deptName' : 'CS', 'salary' : 45000},
 {'sid' : 1003, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1004, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1005, 'deptName' : 'Mathematics', 'salary' : 60000},
 {'sid' : 1006, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1007, 'deptName' : 'Physics', 'salary' : 50000},
 {'sid' : 1008, 'deptName' : 'DataScience', 'salary' : 50000},
 {'sid' : 1009, 'deptName' : 'CS', 'salary' : 60000},
 {'sid' : 1010, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1011, 'deptName' : 'Mathematics', 'salary' : 70000},
 {'sid' : 1012, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1013, 'deptName' : 'Physics', 'salary' : 55000},
 {'sid' : 1014, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1015, 'deptName' : 'DataScience', 'salary' : 60000},
 {'sid' : 1016, 'deptName' : 'DataScience', 'salary' : 55000},
 {'sid' : 1017, 'deptName' : 'Physics', 'salary' : 60000},
 {'sid' : 1018, 'deptName' : 'CS', 'salary' : 50000},
 {'sid' : 1019, 'deptName' : 'Biology', 'salary' : 50000}
]

# departmentLocation(deptName:text, building:text)

departmentLocation = [
 {'deptName' : 'CS', 'building' : 'LindleyHall'},
 {'deptName' : 'DataScience', 'building' : 'LuddyHall'},
 {'deptName' : 'DataScience', 'building' : 'Kinsey'},
 {'deptName' : 'DataScience', 'building' : 'WellsLibrary'},
 {'deptName' : 'Mathematics', 'building' : 'RawlesHall'},
 {'deptName' : 'Physics', 'building' : 'SwainHall'},
 {'deptName' : 'Physics', 'building' : 'ChemistryBuilding'},
 {'deptName' : 'Biology', 'building' : 'JordanHall'},
 {'deptName' : 'CS', 'building' : 'LuddyHall'},
 {'deptName' : 'Mathematics', 'building' : 'SwainHall'},
 {'deptName' : 'Physics', 'building' : 'RawlesHall'},
 {'deptName' : 'Biology', 'building' : 'MultiDisciplinaryBuilding'},
 {'deptName' : 'Chemistry', 'building' : 'ChemistryBuilding'}]



# studentMajor(sid:integer, major:text)

studentMajor = [
 {'sid' : 1001, 'major' : 'CS'},
 {'sid' : 1001, 'major' : 'DataScience'},
 {'sid' : 1002, 'major' : 'CS'},
 {'sid' : 1002, 'major' : 'DataScience'},
 {'sid' : 1004, 'major' : 'DataScience'},
 {'sid' : 1004, 'major' : 'CS'},
 {'sid' : 1005, 'major' : 'DataScience'},
 {'sid' : 1005, 'major' : 'CS'},
 {'sid' : 1005, 'major' : 'Physics'},
 {'sid' : 1006, 'major' : 'CS'},
 {'sid' : 1006, 'major' : 'Chemistry'},
 {'sid' : 1007, 'major' : 'Chemistry'},
 {'sid' : 1007, 'major' : 'CS'},
 {'sid' : 1009, 'major' : 'Chemistry'},
 {'sid' : 1009, 'major' : 'Physics'},
 {'sid' : 1010, 'major' : 'Physics'},
 {'sid' : 1011, 'major' : 'Physics'},
 {'sid' : 1011, 'major' : 'Chemistry'},
 {'sid' : 1011, 'major' : 'DataScience'},
 {'sid' : 1011, 'major' : 'CS'},
 {'sid' : 1012, 'major' : 'DataScience'},
 {'sid' : 1012, 'major' : 'Chemistry'},
 {'sid' : 1012, 'major' : 'CS'},
 {'sid' : 1013, 'major' : 'CS'},
 {'sid' : 1013, 'major' : 'DataScience'},
 {'sid' : 1013, 'major' : 'Chemistry'},
 {'sid' : 1013, 'major' : 'Physics'},
 {'sid' : 1014, 'major' : 'Chemistry'},
 {'sid' : 1014, 'major' : 'DataScience'},
 {'sid' : 1014, 'major' : 'Physics'},
 {'sid' : 1015, 'major' : 'CS'},
 {'sid' : 1015, 'major' : 'DataScience'},
 {'sid' : 1016, 'major' : 'Chemistry'},
 {'sid' : 1016, 'major' : 'DataScience'},
 {'sid' : 1017, 'major' : 'Physics'},
 {'sid' : 1017, 'major' : 'CS'},
 {'sid' : 1018, 'major' : 'DataScience'},
 {'sid' : 1019, 'major' : 'Physics'}
]


# hasFriend(sid1:integer, sid2:integer)

hasFriend = [
 {'sid1' : 1001, 'sid2' : 1008},
 {'sid1' : 1001, 'sid2' : 1012},
 {'sid1' : 1001, 'sid2' : 1014},
 {'sid1' : 1001, 'sid2' : 1019},
 {'sid1' : 1002, 'sid2' : 1001},
 {'sid1' : 1002, 'sid2' : 1002},
 {'sid1' : 1002, 'sid2' : 1011},
 {'sid1' : 1002, 'sid2' : 1014},
 {'sid1' : 1002, 'sid2' : 1015},
 {'sid1' : 1003, 'sid2' : 1004},
 {'sid1' : 1004, 'sid2' : 1002},
 {'sid1' : 1004, 'sid2' : 1003},
 {'sid1' : 1004, 'sid2' : 1012},
 {'sid1' : 1004, 'sid2' : 1013},
 {'sid1' : 1004, 'sid2' : 1014},
 {'sid1' : 1004, 'sid2' : 1019},
 {'sid1' : 1005, 'sid2' : 1015},
 {'sid1' : 1006, 'sid2' : 1003},
 {'sid1' : 1006, 'sid2' : 1004},
 {'sid1' : 1006, 'sid2' : 1006},
 {'sid1' : 1007, 'sid2' : 1008},
 {'sid1' : 1007, 'sid2' : 1013},
 {'sid1' : 1007, 'sid2' : 1016},
 {'sid1' : 1007, 'sid2' : 1017},
 {'sid1' : 1008, 'sid2' : 1001},
 {'sid1' : 1008, 'sid2' : 1007},
 {'sid1' : 1008, 'sid2' : 1015},
 {'sid1' : 1008, 'sid2' : 1019},
 {'sid1' : 1009, 'sid2' : 1001},
 {'sid1' : 1009, 'sid2' : 1005},
 {'sid1' : 1009, 'sid2' : 1013},
 {'sid1' : 1010, 'sid2' : 1008},
 {'sid1' : 1010, 'sid2' : 1013},
 {'sid1' : 1010, 'sid2' : 1014},
 {'sid1' : 1011, 'sid2' : 1005},
 {'sid1' : 1011, 'sid2' : 1009},
 {'sid1' : 1011, 'sid2' : 1010},
 {'sid1' : 1011, 'sid2' : 1011},
 {'sid1' : 1012, 'sid2' : 1011},
 {'sid1' : 1013, 'sid2' : 1002},
 {'sid1' : 1013, 'sid2' : 1007},
 {'sid1' : 1013, 'sid2' : 1018},
 {'sid1' : 1014, 'sid2' : 1005},
 {'sid1' : 1014, 'sid2' : 1006},
 {'sid1' : 1014, 'sid2' : 1012},
 {'sid1' : 1014, 'sid2' : 1017},
 {'sid1' : 1015, 'sid2' : 1002},
 {'sid1' : 1015, 'sid2' : 1003},
 {'sid1' : 1015, 'sid2' : 1005},
 {'sid1' : 1015, 'sid2' : 1011},
 {'sid1' : 1015, 'sid2' : 1015},
 {'sid1' : 1015, 'sid2' : 1018},
 {'sid1' : 1016, 'sid2' : 1004},
 {'sid1' : 1016, 'sid2' : 1006},
 {'sid1' : 1016, 'sid2' : 1015},
 {'sid1' : 1017, 'sid2' : 1013},
 {'sid1' : 1017, 'sid2' : 1014},
 {'sid1' : 1017, 'sid2' : 1019},
 {'sid1' : 1018, 'sid2' : 1004},
 {'sid1' : 1018, 'sid2' : 1007},
 {'sid1' : 1018, 'sid2' : 1009},
 {'sid1' : 1018, 'sid2' : 1010},
 {'sid1' : 1018, 'sid2' : 1013},
 {'sid1' : 1019, 'sid2' : 1001},
 {'sid1' : 1019, 'sid2' : 1006},
 {'sid1' : 1019, 'sid2' : 1008},
 {'sid1' : 1019, 'sid2' : 1013}
]

# You can use the following Python functions

def print_Answer(L):  print("\n".join((str(x) for x in L)))  ## function to print elements of list one line at a time

def exists(L): return L != []

def ifThen(P,Q): return not P or Q

def student(sid, sname, homeCity): return {'sid':sid, 'sname': sname, 'homeCity': homeCity} in Student

def department(deptName, mainOffice): return {'deptName':deptName, 'mainOffice': mainOffice} in Department

def major(major): return {'major':major} in Major

def employedby(sid, deptName, salary): return {'sid':sid, 'deptName': deptName, 'salary': salary} in employedBy

def departmentlocation(deptName, building): return {'deptName':deptName, 'building': building} in departmentLocation

def studentmajor(sid,major): return {'sid':sid,'major':major} in studentMajor

def hasfriend(sid1,sid2): return {'sid1':sid1,'sid2':sid2} in hasFriend


# Problem 2
# Find each pair (d, m) where d is the name of a department and m is a
# major of a student who is employed by that department and who earns a
# salary of at least 20000.

print('')
temp=[{'deptname':eb['deptName'],'major':sm['major']} for sm in studentMajor for eb in employedBy if (eb['sid']==sm['sid'] and eb['salary']>=20000)]

ans=[]
for i in temp:
    if i not in ans:
        ans.append(i)

for a in ans:
    print(a)

# 'Problem 3'
# Find each pair (s1,s2) of sids of different students who have the same
# (set of) friends who work for the CS department.

# Defining helper functions for problem 3
def hasfriend_q3(sid1): return [x['sid2'] for x in hasFriend if x['sid1']==sid1 and 'CS' in [y['deptName'] for y in employedBy if y['sid']==x['sid2']]]

a3 = [
        {'sid1':s1['sid'],'sid2':s2['sid']}
        for s1 in Student for s2 in Student
        if s1['sid'] != s2['sid'] and not (set(hasfriend_q3(s1['sid']))-set(hasfriend_q3(s2['sid']))) and not (set(hasfriend_q3(s2['sid']))-set(hasfriend_q3(s1['sid'])))   
]
print('')
print_Answer(a3)

# 'Problem 4'
# Find each major for which there exists a student with that major and
# who does not only have friends who also have that major.

# Defining helper functions for problem 4
def studentfriend_major_q4(sid):
    return [x['major'] for x in studentMajor for y in hasFriend if y['sid1'] == sid and y['sid2'] == x['sid']]

def studentfriend_major_not_exists_q4(sid,student_major):
    return [x['major'] for x in studentMajor for y in hasFriend if y['sid1'] == sid and y['sid2'] == x['sid'] and student_major != x['major']]

def studentmajor_q4(student_major):
    return [x['sid'] for x in studentMajor if x['major']==student_major and student_major in set(studentfriend_major_q4(x['sid'])) and (studentfriend_major_not_exists_q4(x['sid'],student_major))]

a4 = [
    m for m in Major if (studentmajor_q4(m['major']))
]
print('')
print_Answer(a4)


# 'Problem 13'

# Part 1
q13_1 = [
    {'sid':s1['sid'],'sname':s1['sname']}
    for s1 in Student\
    if any(
         d['deptName'] == w['deptName'] and s1['sid'] == w['sid'] and d['mainOffice'] == 'LuddyHall' and any(
            s1['sid'] == hf['sid1'] and s2['sid'] == hf['sid2'] for hf in hasFriend for s2 in Student if s2['homeCity']!='Bloomington'
         )
         for d in Department for w in employedBy 
    )
]
print('')
print_Answer(q13_1)

# Part 2
q13_2 = [
    {'sid':s1['sid'],'sname':s1['sname']}
    for s1 in Student\
    if exists([1 for d in Department for w in employedBy if d['deptName'] == w['deptName'] and s1['sid'] == w['sid'] and d['mainOffice'] == 'LuddyHall' and any(s1['sid'] == hf['sid1'] and s2['sid'] == hf['sid2'] for hf in hasFriend for s2 in Student if['homeCity']!='Bloomington')
])
]

print('')
print_Answer(q13_2)

# Part 3
q13_3 = [
    {'sid':s1['sid'],'sname':s1['sname']}
    for s1 in Student\
    if True in (
         d['deptName'] == w['deptName'] and s1['sid'] == w['sid'] and d['mainOffice'] == 'LuddyHall' and any(
            s1['sid'] == hf['sid1'] and s2['sid'] == hf['sid2'] for hf in hasFriend for s2 in Student if s2['homeCity']!='Bloomington'
         )
         for d in Department for w in employedBy 
    )
]
print('')
print_Answer(q13_3)

# 'Problem 14'

# Part 1
q14_1 = []

for s1 in Student:
    temp = []
    for s2 in Student:
        for hf in hasFriend:
            if hf['sid1'] == s1['sid'] and hf['sid2'] == s2['sid']:
                temp.append(any([sm1['sid'] == s1['sid'] and sm2['sid'] == s2['sid'] and sm1['major'] == sm2['major'] and sm1['sid'] != sm2['sid'] for sm1 in studentMajor for sm2 in studentMajor ]))
    if all(temp):
        q14_1.append({'sid':s1['sid']})
print('')
print_Answer(q14_1)

# Part 2
q14_1 = []

for s1 in Student:
    temp = []
    for s2 in Student:
        for hf in hasFriend:
            if hf['sid1'] == s1['sid'] and hf['sid2'] == s2['sid']:
                temp.append(any([sm1['sid'] == s1['sid'] and sm2['sid'] == s2['sid'] and sm1['major'] == sm2['major'] and sm1['sid'] != sm2['sid'] for sm1 in studentMajor for sm2 in studentMajor ]))
    if all(temp):
        q14_1.append({'sid':s1['sid']})
print('')
print_Answer(q14_1)

# Part 3

q14_1 = []

for s1 in Student:
    temp = []
    for s2 in Student:
        for hf in hasFriend:
            if hf['sid1'] == s1['sid'] and hf['sid2'] == s2['sid']:
                temp.append(any([sm1['sid'] == s1['sid'] and sm2['sid'] == s2['sid'] and sm1['major'] == sm2['major'] and sm1['sid'] != sm2['sid'] for sm1 in studentMajor for sm2 in studentMajor ]))
    if all(temp):
        q14_1.append({'sid':s1['sid']})
print('')
print_Answer(q14_1)           

# 'Problem 15'

# Part 1
q15_1 = [{'sid1': s1['sid'], 'sid2': s2['sid']}
 for s1 in Student for s2 in Student 
 if all([any([f2['sid1'] == s2['sid'] 
            for f2 in hasFriend 
            if f1['sid2'] == f2['sid2']]) 
         for f1 in hasFriend 
         if s1['sid'] == f1['sid1']]) and s1['sid'] != s2['sid']]

print('')
print_Answer(q15_1)

# Part 2
q15_2 = [{'sid1': s1['sid'], 'sid2': s2['sid']}
 for s1 in Student for s2 in Student 
 if all([any([f2['sid1'] == s2['sid'] 
            for f2 in hasFriend 
            if f1['sid2'] == f2['sid2'] or s1['sid'] != f1['sid1']]) 
         for f1 in hasFriend 
         ]) and s1['sid'] != s2['sid']]

print('')
print_Answer(q15_2)

# Part 3

q15_3 = [{'sid1': s1['sid'], 'sid2': s2['sid']}
 for s1 in Student for s2 in Student 
 if not any([all([f2['sid1'] != s2['sid'] or f1['sid2'] != f2['sid2']
            for f2 in hasFriend 
            ]) 
         for f1 in hasFriend 
         if s1['sid'] == f1['sid1']]) and s1['sid'] != s2['sid']]

print('')
print_Answer(q15_3)


# 'Problem 22.c'
# Some major has fewer than 2 students with that major.
print('')
print(any(sm1['major'] == sm2['major'] and sm1['major'] == m['major'] and sm1['sid'] != sm2['sid'] for m in Major for sm1 in studentMajor for sm2 in studentMajor))


# 'Problem 23.b'
# Each student who works for a department has a friend who also works
# for that department and who earns the same salary

# for eb1 in employedBy for eb2 in Employedby True == any( hf['sid1'] == eb1['sid'] and hf['sid2'] == eb2['sid'] for hf in hasFriend) and eb1['salary'] == eb2['salary']
print('')                
flg = False
for eb1 in employedBy:
    for eb2 in employedBy:
        for hf in hasFriend:
            if eb1['salary']== eb2['salary'] and eb1['deptName']==eb2['deptName'] and (hf['sid1'] == eb1['sid'] and hf['sid2'] == eb2['sid']):
                flg = True
            else:
                flg = False
print(flg)


# 'Problem 24.b'
# All students working in a same department share a major and earn the
# same salary.

# print('')
# lst = []
# for eb1 in employedBy:
#     lst.append(all(sm1['major']==sm2['major'] and eb1['salary'] == eb2['salary'] and eb1['sid'] ==sm1['sid'] and eb2['sid'] == sm2['sid'] and sm1['sid']!=sm2['sid'] and eb1['sid']!=eb2['sid'] and eb1['deptName']==eb2['deptName'] for sm1 in studentMajor for sm2 in studentMajor for eb2 in employedBy))
# if any(lst):
#     print('True')
# else:
#     print('False')

print('')

print(any([(all(eb1['sid']!=eb2['sid'] and eb1['deptName']==eb2['deptName'] and eb1['salary'] == eb2['salary']  and eb1['sid'] ==sm1['sid'] and eb2['sid'] == sm2['sid'] and sm1['major']==sm2['major']  and sm1['sid']!=sm2['sid'] for eb1 in employedBy for eb2 in employedBy for sm1 in studentMajor for sm2 in studentMajor))]))




