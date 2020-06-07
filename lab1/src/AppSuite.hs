module AppSuite where

import           Common
import qualified Data.ByteString.Char8    as BS
import           Database.HDBC
import           Database.HDBC.PostgreSQL
import           Prelude                  hiding (read)

type Id = Integer

type Name = String

unpack [SqlInteger uid, SqlByteString name, SqlInteger tid] = (uid, BS.unpack name, tid)
unpack x = error $ "Unexpected result: " ++ show x

createAppSuite :: IConnection a => Name -> Id -> a -> IO Integer
createAppSuite name tid conn = withTransaction conn (create' name tid)

create' name tid conn = do
  changed <- run conn query [SqlString name, SqlInteger tid]
  result <- quickQuery' conn lastId []
  let rows = map Common.convRow result
  return $ last rows
  where
    query = "insert into hs1_app_suite(name, teacherId) values (?, ?)"
    lastId = "select max(id) from hs1_app_suite"

readAppSuite :: IConnection a => a -> Id -> IO (Id, Name, Id)
readAppSuite conn id = do
  result <- quickQuery' conn query [SqlInteger id]
  let rows = map unpack result
  if null rows
    then return (-1, "", -1)
    else return $ last rows
  where
    query = "select * from hs1_app_suite where id = ?"

readAllAppSuites :: IConnection a => a -> IO [(Id, Name, Id)]
readAllAppSuites conn = do
  result <- quickQuery' conn query []
  return $ map unpack result
  where
    query = "select * from hs1_app_suite order by id"

updateAppSuite :: IConnection a => Id -> Name -> Id -> a -> IO (Id, Name, Id)
updateAppSuite uid name tid conn = withTransaction conn (update' uid name tid)

update' uid name tid conn = do
  changed <- run conn query [SqlString name, SqlInteger tid, SqlInteger uid]
  result <- quickQuery' conn newValue [SqlInteger uid]
  let rows = map unpack result
  return $ last rows
  where
    query = "update hs1_app_suite set name = ?, teacherId = ? " ++ " where id = ?"
    newValue = "select id, name, teacherId from hs1_app_suite where id = ?"

deleteAppSuite :: IConnection a => Id -> a -> IO Bool
deleteAppSuite id conn = withTransaction conn (delete' id)

delete' id conn = do
  changed <- run conn query [SqlInteger id]
  return $ changed == 1
  where
    query = "delete from hs1_app_suite where id = ?"

deleteAllAppSuites :: IConnection a => a -> IO Bool
deleteAllAppSuites conn = withTransaction conn deleteAll'

deleteAll' conn = do
  changed <- run conn query []
  return $ changed == 1
  where
    query = "delete from hs1_app_suite"