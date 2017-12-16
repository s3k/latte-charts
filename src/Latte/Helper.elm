{-
   Helper module with common used functions
-}


module Latte.Helper exposing (..)

import Latte.Model exposing (Model, UserData)


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


tooltipName : Model -> String
tooltipName model =
    model.userData.datasets
        |> List.map (\n -> n.title)
        |> List.head
        |> justString
        |> (\title -> String.join " " [ title, model.state.tooltip.value ])


justNumber item =
    case item of
        Just x ->
            x

        Nothing ->
            0


justString item =
    case item of
        Just x ->
            x

        Nothing ->
            ""



-- Style Helpers


commonSvgFont : List ( String, String )
commonSvgFont =
    ([ ( "text-rendering", "optimizeLegibility" )
     , ( "color", "rgb(108, 118, 128)" )
     , ( "display", "inline" )
     , ( "fill", "rgb(85, 91, 81)" )
     , ( "font-size", "11px" )
     , ( "font-weight", "300" )
     ]
        ++ commonFont
    )


commonFont : List ( String, String )
commonFont =
    [ ( "font-family", "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif" )
    ]
