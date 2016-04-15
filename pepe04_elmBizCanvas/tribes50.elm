module Tribes where

{-| Based on TodoMVC by 
      Thomas Weiser
         based on work by Evan Czaplicki and the [TodoMVC Project](http://todomvc.com/)
    - [Github Repo](https://github.com/ThomasWeiser/todomvc-elmfire)
    - [Original Elm Implementation by Evan Czaplicki](https://github.com/evancz/elm-todomvc)
    - [ElmFire](https://github.com/ThomasWeiser/elmfire)
    - [Elm Language](http://elm-lang.org/) 
-}

-- IMPORTS
import Html exposing (..)
import Dict exposing (Dict)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.Events.Extra exposing (..)
import String
import StartApp.Simple as StartApp

-- MODEL
-- tribes, squads, chapters and guilds main model 

type alias Tribe =
  { base        : BaseModel
  , squads      : Dict Id Squads
  , canvas      : Dict Id Canvas
  }

type alias Squads =
  { base        : BaseModel
  }

type alias Canvas =
  { base        : BaseModel
  , canvasItems : CanvasItems 
  , channels: List String
  , selectedChannel: Int
  , query: String
  }
  
type alias CanvasItems = Dict Id CanvasItem
type alias CanvasItem =
  { name        : String
  , group       : Int     -- value, segments, partners, cost, etc.
  , position    : Int
  , tags        : String  -- for now
  , comments    : String  -- for now
  }

type alias BaseModel =
  { name        : String
  , description : Content
  , members     : Dict Id Member
  }
  
type alias Member =
  { first       : String
  , last        : String
  , email       : String
  }

type alias Id = String
type alias Content = String

type alias Model =
  { channels: List String
  , tribes  : Dict Id Tribe
  , selectedChannel: Int
  , query: String
  }

initialModel : Model
initialModel =
  { channels = ["Elm", "React.js", "Ember", "Angular 2", "Om", "OffTopic" ]
  , tribes  = Dict.empty
  , selectedChannel = -1
  , query = ""
  }

-- UPDATE
type Action = NoOp | Filter String | Select Int

update action model =
  case action of
    NoOp ->
      model

    Filter query ->
      { model | query = query }

    Select index ->
      { model | selectedChannel = index }


-- VIEW
filterChannels : List String -> String -> List String
filterChannels channels query =
  let
    containsCaseInsensitive str1 str2 =
      String.contains (String.toLower str1) (String.toLower str2)
  in
    List.filter (containsCaseInsensitive query) channels

renderChannel : String -> Html
renderChannel name =
  li [ class "collection-item" ] [ text <| "#" ++ name ]

renderChannels : List String -> Html
renderChannels channels =
  let
    channelItems = List.map renderChannel channels
  in
    ul [ class "collection" ] channelItems

view : Signal.Address Action -> Model -> Html
view address model =
  div [ class "card-panel" ] [
    input [ onInput address Filter ] [],
    renderChannels (filterChannels model.channels model.query)
  ]

main : Signal Html
main =
  StartApp.start
    { model = initialModel
    , update = update
    , view = view
    }