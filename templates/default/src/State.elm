module State exposing (..)

import Types exposing (..)


initialState : ( Model, Cmd Msg )
initialState =
    ( { counter = 0 }
    , Cmd.none
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increment ->
            ( { model | counter = model.counter + 1 }
            , Cmd.none
            )
