{-# LANGUAGE TemplateHaskell #-}

module Main where

import Data.FileEmbed
import Graphics.UI.Gtk
import Data.ByteString.UTF8

main :: IO ()
main = do
  _ <- initGUI
  builder <- builderNew
  -- builderAddFromFile builder "gtk-hello.ui" -- for debugging
  builderAddFromString builder $ toString $(embedFile "gtk-hello.ui")
  mainWindow <- builderGetObject builder castToWindow "window1"
  closeButton <- builderGetObject builder castToButton "button2"
  _ <- onClicked closeButton (widgetDestroy mainWindow)
  _ <- onDestroy mainWindow mainQuit
  label       <- builderGetObject builder castToLabel "label1"
  entry       <- builderGetObject builder castToEntry "entry1"
  applyButton <- builderGetObject builder castToButton "button1"
  _ <- onClicked applyButton $ do
    name <- get entry entryText
    set label [ labelText := "Hello " ++ name ]
  widgetShowAll mainWindow
  mainGUI
