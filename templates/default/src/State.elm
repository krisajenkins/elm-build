module State (..) where

import Types exposing (..)
import Effects exposing (..)
import Types exposing (..)
import Dict


wall : List Position -> List ( Position, Cell )
wall =
  List.map (\coords -> ( coords, Block ))


horizontalWall : Int -> List Int -> List ( Position, Cell )
horizontalWall x ys =
  ys
    |> List.map (\y -> ( x, y ))
    |> wall


verticalWall : List Int -> Int -> List ( Position, Cell )
verticalWall xs y =
  xs
    |> List.map (\x -> ( x, y ))
    |> wall


initialModel : Model
initialModel =
  let
    ( minX, minY ) =
      ( 0, 0 )

    ( maxX, maxY ) =
      ( 15, 7 )

    xRange =
      [minX..maxX]

    yRange =
      [minY..maxY]
  in
    { world =
        Dict.fromList
          (horizontalWall minX yRange
            ++ horizontalWall maxX yRange
            ++ verticalWall xRange minY
            ++ verticalWall xRange maxY
          )
    }


initialEffects : Effects Action
initialEffects =
  none


update : Action -> Model -> ( Model, Effects Action )
update action model =
  ( model, none )
