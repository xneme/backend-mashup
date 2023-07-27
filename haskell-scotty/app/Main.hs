{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Database.PostgreSQL.Simple
import Lib
import Web.Scotty (get, html, scotty)

localPG :: ConnectInfo
localPG =
  defaultConnectInfo
    { connectHost = "database",
      connectDatabase = "mashup",
      connectUser = "mashup",
      connectPassword = "password"
    }

main :: IO ()
main = do
  conn <- connect localPG
  routes conn

routes :: Connection -> IO ()
routes conn = scotty 3000 $ do
  get "/" $ do
    html "Backend mashup - Haskell/Scotty edition!"

  get "/users" $ getUsers conn

  get "/users/:id" $ getUser conn
