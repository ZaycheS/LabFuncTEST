import           Common
import           AppSuite
import           Student
import           Teacher

import           Test.Tasty               (defaultMain, testGroup)
import           Test.Tasty.HUnit         (assertEqual, assertFailure, testCase)

import           Database.HDBC
import           Database.HDBC.PostgreSQL (connectPostgreSQL)

main = defaultMain allTests

allTests = testGroup "All tests" [teacherTests, appSuiteTests, studentTests]

teacherTests = testGroup "Teacher tests" [createTeacherTest, updateTeacherTest]

appSuiteTests = testGroup "AppSuite tests" [createAppSuiteTest, updateAppSuiteTest]

studentTests = testGroup "Student tests" [createStudentTest, updateStudentTest]

createTeacherTest =
  testCase "Create teacher" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    teacher <- readTeacher c newTeacherId
    assertEqual "Teacher ID equal" newTeacherId (Common.getTeacherId teacher)
    assertEqual "Teacher Name equal" "New" (Common.getTeacherName teacher)
    assertEqual "Teacher Surname equal" "Teacher" (Common.getTeacherSurname teacher)
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed

updateTeacherTest =
  testCase "Update teacher" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    teacher <- readTeacher c newTeacherId
    assertEqual "Teacher ID equal" newTeacherId (Common.getTeacherId teacher)
    assertEqual "Teacher Name equal" "New" (Common.getTeacherName teacher)
    assertEqual "Teacher Surname equal" "Teacher" (Common.getTeacherSurname teacher)
    teacher <- updateTeacher newTeacherId "Brendan" "Stark" c
    assertEqual "Teacher ID equal" newTeacherId (Common.getTeacherId teacher)
    assertEqual "Teacher Name equal" "Brendan" (Common.getTeacherName teacher)
    assertEqual "Teacher Surname equal" "Stark" (Common.getTeacherSurname teacher)
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed

createAppSuiteTest =
  testCase "Create AppSuite" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    newAppSuiteId <- createAppSuite "AppSuite_new" newTeacherId c
    appSuite <- readAppSuite c newAppSuiteId
    assertEqual "AppSuite ID equal" newAppSuiteId (Common.getAppSuiteId appSuite)
    assertEqual "AppSuite Name equal" "AppSuite_new" (Common.getAppSuiteName appSuite)
    assertEqual "AppSuite TeacherID equal" newTeacherId (Common.getAppSuiteTeacherId appSuite)
    removed <- deleteAppSuite newAppSuiteId c
    assertEqual "AppSuite removed" True removed
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed

updateAppSuiteTest =
  testCase "Update AppSuite" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    newAppSuiteId <- createAppSuite "AppSuite_new" newTeacherId c
    appSuite <- readAppSuite c newAppSuiteId
    assertEqual "AppSuite ID equal" newAppSuiteId (Common.getAppSuiteId appSuite)
    assertEqual "AppSuite Name equal" "AppSuite_new" (Common.getAppSuiteName appSuite)
    assertEqual "AppSuite TeacherID equal" newTeacherId (Common.getAppSuiteTeacherId appSuite)
    appSuite <- updateAppSuite newAppSuiteId "AppSuites" newTeacherId c
    assertEqual "AppSuite ID equal" newAppSuiteId (Common.getAppSuiteId appSuite)
    assertEqual "AppSuite Name equal" "AppSuites" (Common.getAppSuiteName appSuite)
    assertEqual "AppSuite TeacherID equal" newTeacherId (Common.getAppSuiteTeacherId appSuite)
    removed <- deleteAppSuite newAppSuiteId c
    assertEqual "AppSuite removed" True removed
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed

createStudentTest =
  testCase "Create student" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    newAppSuiteId <- createAppSuite "AppSuite_new" newTeacherId c
    newStudentId <- createStudent "Georgiy" "Chykalo" newAppSuiteId c
    student <- readStudent c newStudentId
    assertEqual "Student ID equal" newStudentId (Common.getStudentId student)
    assertEqual "Student Name equal" "Georgiy" (Common.getStudentName student)
    assertEqual "Student Surname equal" "Chykalo" (Common.getStudentSurname student)
    assertEqual "Student AppSuiteID equal" newAppSuiteId (Common.getStudentAppSuite student)
    removed <- deleteStudent newStudentId c
    assertEqual "Student removed" True removed
    removed <- deleteAppSuite newAppSuiteId c
    assertEqual "AppSuite removed" True removed
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed

updateStudentTest =
  testCase "Update student" $ do
    c <- connectPostgreSQL "host=localhost dbname=hask1 user=postgres password=cisco"
    newTeacherId <- createTeacher "New" "Teacher" c
    newAppSuiteId <- createAppSuite "AppSuite_new" newTeacherId c
    newStudentId <- createStudent "Georgiy" "Chykalo" newAppSuiteId c
    student <- readStudent c newStudentId
    assertEqual "Student ID equal" newStudentId (Common.getStudentId student)
    assertEqual "Student Name equal" "Georgiy" (Common.getStudentName student)
    assertEqual "Student Surname equal" "Chykalo" (Common.getStudentSurname student)
    assertEqual "Student AppSuiteID equal" newAppSuiteId (Common.getStudentAppSuite student)
    student <- updateStudent newStudentId "Grygoriy" "Chykalovsky" newAppSuiteId c
    assertEqual "Student ID equal" newStudentId (Common.getStudentId student)
    assertEqual "Student Name equal" "Grygoriy" (Common.getStudentName student)
    assertEqual "Student Surname equal" "Chykalovsky" (Common.getStudentSurname student)
    assertEqual "Student AppSuiteID equal" newAppSuiteId (Common.getStudentAppSuite student)
    removed <- deleteStudent newStudentId c
    assertEqual "Student removed" True removed
    removed <- deleteAppSuite newAppSuiteId c
    assertEqual "AppSuite removed" True removed
    removed <- deleteTeacher newTeacherId c
    assertEqual "Teacher removed" True removed