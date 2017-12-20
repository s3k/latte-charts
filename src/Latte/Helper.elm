{-
   Helper module with common used functions
-}


module Latte.Helper exposing (..)

import Latte.Model exposing (Model, UserData)
import Bitwise exposing (..)
import Hex


toPx : a -> String
toPx val =
    toS val ++ "px"


toS : a -> String
toS val =
    toString val



-- Model Helpers


maxBarLines : Float -> Float
maxBarLines height =
    height / 35.0


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
     ]
        ++ commonFont
    )


commonFont : List ( String, String )
commonFont =
    [ ( "font-family", "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen,Ubuntu,Cantarell,Fira Sans,Droid Sans,Helvetica Neue,sans-serif" )
    , ( "font-size", "11px" )
    , ( "font-weight", "300" )
    ]



-- Darken color


darken : String -> String
darken strColor =
    let
        color =
            String.dropLeft 1 strColor
                |> (++) "0x"
    in
        case (String.toInt color) of
            Ok intColor ->
                intColor
                    |> and 0x00FFFFFF
                    |> shiftRightBy 1
                    |> Hex.toString
                    |> (++) "#"

            Err msg ->
                "#333333"



-- Scale Y Axis chart


scaleY : Float -> Float
scaleY n =
    let
        base =
            toFloat (logBase 10 n |> ceiling)

        n_ =
            n / 10 ^ base
    in
        (roundNumberScale n_) * 10 ^ base


roundNumberScale : Float -> Float
roundNumberScale n =
    if n <= 0.1 then
        0.1
    else if n <= 0.2 && n > 0.1 then
        0.2
    else if n <= 0.3 && n > 0.2 then
        0.3
    else if n <= 0.4 && n > 0.3 then
        0.4
    else if n <= 0.5 && n > 0.4 then
        0.5
    else if n <= 0.6 && n > 0.5 then
        0.6
    else if n <= 0.7 && n > 0.6 then
        0.7
    else if n <= 0.8 && n > 0.7 then
        0.8
    else if n <= 0.9 && n > 0.8 then
        0.9
    else
        1.0
