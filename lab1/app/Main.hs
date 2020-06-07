module Main where

import           Control.Exception
import           Database.HDBC
import           Database.HDBC.PostgreSQL (connectPostgreSQL)

import           AppSuite
import           Student
import           Teacher

main = do
  c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
  putStrLn " -- TEACHERS -- \n"
  --
  putStrLn " - All Teachers - \n"
  allTeachers <- readAllTeachers c
  print allTeachers
  putStrLn "\n - New Teacher - \n"
  newTeacherId <- createTeacher "New Brendan" "New Stark" c
  print newTeacherId
  newTeacher <- readTeacher c newTeacherId
  print newTeacher
  putStrLn "\n - Edited New Teacher - \n"
  updateTeacher newTeacherId "CRT Brendano" "CRT Starkovsky" c
  updatedTeacher <- readTeacher c newTeacherId
  print updatedTeacher
  putStrLn "\n - Deleted New Teacher - \n"
  successfullyDeletedTeacher <- deleteTeacher newTeacherId c
  print successfullyDeletedTeacher
  emptyTeacher <- readTeacher c newTeacherId
  print emptyTeacher
  -- create teacher
  newTeacherId <- createTeacher "New Brendan" " New Stark" c
  putStrLn ""
  ---
  putStrLn " -- Application Suites -- \n"
  ---
  putStrLn " - All Application Suites - \n"
  allAppSuites <- readAllAppSuites c
  print allAppSuites
  putStrLn "\n - New Application Suite - \n"
  newAppSuiteId <- createAppSuite "New AppSuite" newTeacherId c
  print newAppSuiteId
  newAppSuite <- readAppSuite c newAppSuiteId
  print newAppSuite
  putStrLn "\n - Edited New Application Suite - \n"
  updateAppSuite newAppSuiteId "AppSuite" newTeacherId c
  updatedAppSuite <- readAppSuite c newAppSuiteId
  print updatedAppSuite
  putStrLn "\n - Deleted New Application Suite - \n"
  successfullyDeletedAppSuite <- deleteAppSuite newAppSuiteId c
  print successfullyDeletedAppSuite
  emptyAppSuite <- readAppSuite c newAppSuiteId
  print emptyAppSuite
  -- create app suite
  newAppSuiteId <- createAppSuite "AppSuite" newTeacherId c
  putStrLn ""
  --
  putStrLn " -- STUDENTS -- "
  --
  putStrLn " - All Students - \n"
  allStudents <- readAllStudents c
  print allStudents
  putStrLn "\n - New Student - \n"
  newStudentId <- createStudent "Yehudah" "Park" newAppSuiteId c
  print newStudentId
  newStudent <- readStudent c newStudentId
  print newStudent
  putStrLn "\n - Edited New Student - \n"
  updateStudent newStudentId "Jessie" "Abel" newAppSuiteId c
  updatedStudent <- readStudent c newStudentId
  print updatedStudent
  putStrLn "\n - Deleted New Student - \n"
  successfullyDeletedStudent <- deleteStudent newStudentId c
  print successfullyDeletedStudent
  emptyStudent <- readStudent c newStudentId
  print emptyStudent