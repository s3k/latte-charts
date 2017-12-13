{-
   Helper module with common used functions
-}


module Latte.Helper exposing (..)

import Latte.Model exposing (UserData)


toPx : a -> String
toPx val =
    toS val ++ "px"


toS : a -> String
toS val =
    toString val



-- Model Helpers


maxBarLines : Float -> Float
maxBarLines height =
    height / 40.0


maxDsValue : UserData -> Float
maxDsValue model =
    model.datasets
        |> List.map (\n -> n.values)
        |> List.concat
        |> List.maximum
        |> justNumber


justNumber item =
    case item of
        Just x ->
            x

        Nothing ->
            0
