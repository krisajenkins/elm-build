module App exposing (main)

import Html.App
import State
import View


main : Program Never
main =
  Html.App.program
    { init = ( State.initialModel, State.initialCmd )
    , view = View.root
    , update = State.update
    , subscriptions = always Sub.none
    }
