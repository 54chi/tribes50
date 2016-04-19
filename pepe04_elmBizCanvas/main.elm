module Tribes where

import StartApp
import TribesBoard.View exposing (init,view,update)
import Task exposing (Task)
import Signal exposing (Signal, Address)
import Effects exposing (Effects, Never)
import Html exposing (Html)

--
-- StartApp boilerplate
--
app = StartApp.start 
  { init = init
  , view = view
  , update = update
  , inputs = [] 
  }

main : Signal Html
main =
  app.html

port tasks : Signal (Task Never ())
port tasks =
  app.tasks