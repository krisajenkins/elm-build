module State (..) where

import Types exposing (..)
import Effects exposing (..)
import Types exposing (..)


initialModel : Model
initialModel =
  { counter = 0 }


initialEffects : Effects Action
initialEffects =
  none


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    Increment ->
      ( { model | counter = model.counter + 1 }
      , none
      )
