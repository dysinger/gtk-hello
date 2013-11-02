{-# LANGUAGE TemplateHaskell             #-}
{-# OPTIONS_GHC -fno-warn-unused-do-bind #-}

import Data.FileEmbed
import Graphics.UI.Gtk
import Data.ByteString.UTF8

main :: IO ()
main = do
  initGUI
  builder <- builderNew
--builderAddFromFile builder "gtk-hello.ui" -- use this for designing the UI
  builderAddFromString builder $ toString $(embedFile "gtk-hello.ui") -- use this for deploy
  mainWindow  <- builderGetObject builder castToWindow "window1"
  closeButton <- builderGetObject builder castToButton "button2"
  onClicked closeButton (widgetDestroy mainWindow)
  onDestroy mainWindow mainQuit
  label       <- builderGetObject builder castToLabel "label1"
  entry       <- builderGetObject builder castToEntry "entry1"
  applyButton <- builderGetObject builder castToButton "button1"
  onClicked applyButton $ do
    name <- get entry entryText
    set label [ labelText := "Hello " ++ name ]
  widgetShowAll mainWindow
  mainGUI
