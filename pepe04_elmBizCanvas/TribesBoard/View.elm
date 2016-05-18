module TribesBoard.View where

import Html exposing (..)
import Html.Attributes exposing (..) -- id, rows, style', class, etc.
import Html.Events exposing (..)
import Signal exposing (Signal, Address)
import Effects exposing (Effects, Never)


-- MODELS
type alias ModelErrors=
  { projectName : String
  , projectDescription  : String
  }
type alias Model = 
  { projectName : String
  , projectDescription  : String
  , errors : ModelErrors
  }


-- INIT

---- init models
initialErrors : ModelErrors
initialErrors = 
  { projectName = ""
  , projectDescription = ""
  }

initialModel : Model
initialModel = 
  { projectName = ""
  , projectDescription = ""
  , errors = initialErrors
  }

---- init effects
initialEffect : Effects Action
initialEffect = Effects.none

----- init main
init : (Model, Effects Action)
init = (initialModel, initialEffect)


-- UPDATE
type Action = NoOp
  | UpdateTitle String
  | UpdateDescription String
  | Add
  | Delete
  | Update
  | Cancel
  | Hide
  | Show
  

-- model validations
getErrors model =
  { projectName =
      if model.projectName == "" then
          "Please enter a project name!"
      else
          ""
  
  , projectDescription =
      if model.projectDescription == "" then
          "Please enter a description!"
      else
          ""
  }

update : Action -> Model -> (Model, Effects Action)
update action model = 
  case action of
    NoOp  -> (model, Effects.none)
    Cancel -> (model, Effects.none)
    Add   -> ({model | projectName = model.projectName, errors = getErrors model}, Effects.none)
    UpdateTitle str ->
      ({ model | projectName = str }, Effects.none)
    UpdateDescription str ->
      ({ model | projectDescription = str }, Effects.none)
    _ ->
      Debug.crash "TODO"


-- VIEW
view : Address Action -> Model -> Html
view address model = 
  let
    projectTitle = input
      [ type' "text"
      , name "projectName"
      , placeholder "Enter project name"
      , value model.projectName
      , on "input" targetValue (Signal.message address << UpdateTitle )
      ]
      []
    projectTitleError = div 
      [ class "validation-error" ] 
      [ text model.errors.projectName ]
    projectDescription = textarea
      [ name "projectDescription"
      , placeholder "Enter project description"
      , style [("height", "auto")]
      , rows 10
      , value model.projectDescription
      , on "input" targetValue (Signal.message address << UpdateDescription )
      ]
      []
    projectDescriptionError = div 
      [ class "validation-error" ] 
      [ text model.errors.projectDescription ]
    cancelButton = button [onClick address Cancel] [text "Cancel"]
    saveButton = button [onClick address Add] [text "Save"]
    
  in
    div [ id "project-form"]
      [ projectTitle
      , projectTitleError
      , projectDescription
      , projectDescriptionError
      , cancelButton
      , saveButton]
