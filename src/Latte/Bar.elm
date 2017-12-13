module Latte.Bar exposing (view)

import Html exposing (Attribute, div, text)
import Html.Attributes exposing (style)
import Svg exposing (Svg, svg, g)
import Svg.Attributes exposing (width, height, viewBox, transform)
import Latte.Model exposing (..)
import Latte.Bar.Area exposing (view)


-- import Latte.Bar.Ticks


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
                [ (area model)
                ]
            ]
        ]



-- Helpers


area : Model -> Svg msg
area model =
    Latte.Bar.Area.view model



-- Styles


viewportStyle : Model -> List (Attribute msg)
viewportStyle model =
    [ transform ("scale(1,-1) translate(0,-" ++ (toS model.state.height) ++ ")") ]


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


toPx : a -> String
toPx val =
    toS val ++ "px"


toS : a -> String
toS val =
    toString val
