module Types (..) where

import Dict exposing (..)


type alias Position =
  ( Int, Int )


type alias World a =
  Dict Position a


type Cell
  = Block
  | Path


type Action
  = NoOp


type alias Model =
  { world : World Cell }
