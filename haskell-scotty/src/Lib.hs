{-# LANGUAGE OverloadedStrings #-}

module Lib
    ( someFunc,
      getUser,
      getUsers,
    ) where

import Control.Monad.IO.Class (liftIO)
import Data.Aeson
import Data.Int
import Database.PostgreSQL.Simple
import Database.PostgreSQL.Simple.FromRow
import Network.HTTP.Types.Status (Status, status200, status400)
import Web.Scotty (ActionM, jsonData, param, status)
import qualified Web.Scotty as S

someFunc :: IO ()
someFunc = putStrLn "someFunci"

data User = User
  { idUser :: Int,
    name :: String,
    email :: String
  }

instance FromRow User where
    fromRow = User <$> field <*> field <*> field

instance ToJSON User where
    toJSON (User idUser name email) =
      object
      [ "id" .= idUser,
        "name" .= name,
        "email" .= email
      ]

instance FromJSON User where
    parseJSON (Object o) =
        User <$> o .:? "id" .!= 0
        <*> o .: "name"
        <*> o .: "email"
    parseJSON _ = fail "Expected an object for User"

getUsers :: Connection -> ActionM ()
getUsers conn = do
    users <- (liftIO $ query_ conn "SELECT * FROM users") :: ActionM [User]
    status status200
    S.json $ object ["users" .= users]

getUser :: Connection -> ActionM ()
getUser conn = do
    _id <- param "id" :: ActionM Int
    let result = query conn "SELECT * FROM users WHERE id = ?" (Only _id)
    user <- liftIO result :: ActionM [User]
    case user of
      [] -> do
        status status400
        S.json $ object ["error" .= ("User not found" :: String)]
      _ -> do
        status status200
        S.json (head user)
