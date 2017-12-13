module Latte.Bar exposing (view)

import Html exposing (Attribute, div, text)
import Html.Attributes exposing (style)
import Latte.Bar.Area exposing (view)
import Latte.Bar.Ticks exposing (view)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Svg exposing (Svg, g, svg)
import Svg.Attributes exposing (height, transform, viewBox, width)


view : Model -> Svg msg
view model =
    div []
        [ div []
            [ text model.userData.title
            ]
        , div [ tooltipStyle model ]
            [ text model.state.tooltip.title
            ]
        , svg (chartStyle model)
            [ g (viewportStyle model)
                [ area model
                , ticks model
                ]
            ]
        ]



-- Helpers


area : Model -> Svg msg
area model =
    Latte.Bar.Area.view model


ticks : Model -> Svg msg
ticks model =
    Latte.Bar.Ticks.view model



-- Styles


viewportStyle : Model -> List (Attribute msg)
viewportStyle model =
    [ transform ("scale(1,-1) translate(0,-" ++ toS model.state.height ++ ")") ]


chartStyle : Model -> List (Attribute msg)
chartStyle model =
    [ width (toS model.state.width)
    , height (toS model.state.height)
    , viewBox (String.join " " [ "0", "0", toS model.state.width, toS (model.state.height + 20) ])
    ]


tooltipStyle : Model -> Attribute msg
tooltipStyle model =
    style
        [ ( "position", "relative" )
        , ( "left", toPx model.state.tooltip.x )
        , ( "top", toPx model.state.tooltip.y )
        ]
