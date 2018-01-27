module Latte.Common.Lines exposing (view)

import Html.Attributes exposing (style)
import Latte.Bar.Helper exposing (calcHeight, leftAlign)
import Latte.Common.Style exposing (barWidth)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, path, svg)
import Svg.Attributes
    exposing
        ( attributeName
        , d
        , dur
        , fill
        , from
        , to
        )
import Svg.Events exposing (onMouseOut, onMouseOver)


view : Model -> Svg Msg
view model =
    g [] (drawPathes model)


drawPathes : Model -> List (Svg Msg)
drawPathes model =
    let
        datasets =
            model.userData.datasets
    in
    datasets
        |> List.map2
            (\color dataset ->
                makePath model.state color dataset.values
            )
            model.state.colors


makePath : State -> String -> List Float -> Svg Msg
makePath state color dsValues =
    path
        [ d <| makeCoords state dsValues
        , style
            [ ( "stroke", color )
            , ( "stroke-width", "2" )
            , ( "fill", "none" )
            ]
        ]
        [ animate
            [ attributeName "d"
            , from (makeCoords state (List.map (\n -> 0) dsValues))
            , to (makeCoords state dsValues)
            , dur "0.2s"
            , fill "freeze"
            ]
            []
        ]


makeCoords : State -> List Float -> String
makeCoords state dsValues =
    dsValues
        |> List.indexedMap (,)
        |> List.map (\( i, val ) -> pair state i val)
        |> String.join " "


pair : State -> Int -> Float -> String
pair state i val =
    let
        coordType =
            if i == 0 then
                "M"
            else
                "L"
    in
    (++) coordType <|
        String.join "," <|
            [ toString <| leftAlign state i + barWidth / 2
            , toString <| calcHeight state val + 18
            ]
