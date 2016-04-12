module State (..) where

import Types exposing (..)
import Effects exposing (..)
import Types exposing (..)
import Dict


initialModel : Model
initialModel =
  {}


initialEffects : Effects Action
initialEffects =
  none


update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, none )
