module Tests exposing (tests)

import Expect
import StateTest
import String
import Test exposing (..)


tests : Test
tests =
    describe "All"
        [ StateTest.tests ]
