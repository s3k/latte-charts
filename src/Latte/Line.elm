module Latte.Line exposing (view)

import Html exposing (Attribute, div, text)
import Html.Attributes exposing (style)
import Latte.Line.Area exposing (view)
import Latte.Line.Ticks exposing (view)
import Latte.Line.Lines exposing (view)
import Latte.Common.Title as Title
import Latte.Common.Tooltip as Tooltip
import Latte.Common.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, g, svg)
import Svg.Attributes exposing (height, transform, viewBox, width)


view : Model -> Svg Msg
view model =
    div [ boxStyle model ]
        [ Title.view model
        , Tooltip.view model
        , svg (chartStyle model)
            [ g (viewportStyle model)
                [ area model
                , lines model
                , ticks model
                ]
            ]
        ]



-- Helpers


area : Model -> Svg Msg
area model =
    Latte.Line.Area.view model


ticks : Model -> Svg Msg
ticks model =
    Latte.Line.Ticks.view model


lines : Model -> Svg Msg
lines model =
    Latte.Line.Lines.view model



-- Styles


boxStyle : Model -> Attribute msg
boxStyle model =
    style
        [ ( "padding", "10px" )
        , ( "margin", "10px" )
        , ( "position", "relative" )
        , ( "border", "1px solid #ccc" )
        , ( "max-width", toPx model.state.width )
        , ( "border-radius", "3px" )
        ]


viewportStyle : Model -> List (Attribute msg)
viewportStyle model =
    [ transform ("scale(1,-1) translate(0,-" ++ toS model.state.height ++ ")") ]


chartStyle : Model -> List (Attribute msg)
chartStyle model =
    [ width (toS model.state.width)
    , height (toS model.state.height)
      -- , viewBox (String.join " " [ "0", "0", toS (model.state.width), toS (model.state.height + 30) ])
    ]
