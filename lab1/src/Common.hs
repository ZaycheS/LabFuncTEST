module Common where

import           Database.HDBC
import           Database.HDBC.PostgreSQL

convRow :: [SqlValue] -> Integer
convRow [sqlId] = intId
  where
    intId = fromSql sqlId :: Integer
convRow x = error $ "Unexpected result: " ++ show x

getTeacherId :: (a, b, c) -> a
getTeacherId (x, _, _) = x

getTeacherName :: (a, b, c) -> b
getTeacherName (_, y, _) = y

getTeacherSurname :: (a, b, c) -> c
getTeacherSurname (_, _, z) = z

getAppSuiteId :: (a, b, c) -> a
getAppSuiteId (x, _, _) = x

getAppSuiteName :: (a, b, c) -> b
getAppSuiteName (_, y, _) = y

getAppSuiteTeacherId :: (a, b, c) -> c
getAppSuiteTeacherId (_, _, z) = z

getStudentId :: (a, b, c, d) -> a
getStudentId (x, _, _, _) = x

getStudentName :: (a, b, c, d) -> b
getStudentName (_, y, _, _) = y

getStudentSurname :: (a, b, c, d) -> c
getStudentSurname (_, _, z, _) = z

getStudentAppSuite :: (a, b, c, d) -> d
getStudentAppSuite (_, _, _, w) = w