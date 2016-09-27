module StateTest exposing (tests)

import Expect exposing (..)
import Fuzz exposing (..)
import State exposing (..)
import Test exposing (..)
import Types exposing (..)


tests : Test
tests =
    describe "State"
        [ updateTests
        ]


updateTests : Test
updateTests =
    describe "update"
        [ test ""
            <| always
            <| (equal { counter = 5 }
                    (fst (update Increment { counter = 4 }))
               )
        , fuzz int
            "Increment adds one."
            (\n ->
                equal { counter = n + 1 }
                    (fst (update Increment { counter = n }))
            )
        ]
