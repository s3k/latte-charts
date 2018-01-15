module Latte.Percentage.Helper exposing (..)

import Latte.Common.Helper exposing (toPr)
import Latte.Model exposing (Model, Dataset)


calcFirstDsPercents1 : Model -> List Float
calcFirstDsPercents1 model =
    let
        dataset =
            model.userData.datasets
                |> List.head
                |> Maybe.withDefault (Dataset "" [])

        dsSum =
            List.sum dataset.values
    in
        dataset.values
            |> List.map (\n -> n * 100 / dsSum)
