module View (root) where

import Signal exposing (..)
import Html exposing (..)
import Html.Events exposing (..)
import Types exposing (..)


root : Address Action -> Model -> Html
root address model =
  div
    []
    [ text ("Counter: " ++ toString model.counter)
    , button
        [ onClick address Increment ]
        [ text "Increment" ]
    ]
