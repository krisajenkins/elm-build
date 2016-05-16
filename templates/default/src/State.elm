module State exposing (..)

import Types exposing (..)


initialModel : Model
initialModel =
  { counter = 0 }


initialCmd : Cmd Action
initialCmd =
  Cmd.none


update : Action -> Model -> ( Model, Cmd Action )
update action model =
  case action of
    Increment ->
      ( { model | counter = model.counter + 1 }
      , Cmd.none
      )
