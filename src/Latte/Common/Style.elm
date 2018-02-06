module Latte.Common.Style exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Latte.Common.Helper exposing (toPx, toS)
import Latte.Model exposing (..)
import Svg.Attributes exposing (height, transform, width)


-- Style Helpers


svgFontStyle : List ( String, String )
svgFontStyle =
    [ ( "text-rendering", "optimizeLegibility" )
    , ( "color", "rgb(108, 118, 128)" )
    , ( "display", "inline" )
    , ( "fill", "rgb(85, 91, 81)" )
    ]
        ++ fontStyle


fontStyle : List ( String, String )
fontStyle =
    [ ( "font-family", "-apple-system,BlinkMacSystemFont,Segoe UI,Roboto,Oxygen,Ubuntu,Cantarell,Fira Sans,Droid Sans,Helvetica Neue,sans-serif" )
    , ( "font-size", "11px" )
    , ( "font-weight", "300" )
    ]



-- Styles


chartPaddingLeft : Float
chartPaddingLeft =
    55


barWidth : Float
barWidth =
    34


boxStyle : Model -> Attribute msg
boxStyle model =
    style
        [ ( "padding", "10px" )
        , ( "margin", "10px auto" )
        , ( "position", "relative" )
        , ( "border", "1px solid #ccc" )
        , ( "max-width", toPx model.state.width )
        , ( "border-radius", "3px" )
        , ( "overflow", "scroll" )
        ]


viewportStyle : Model -> List (Attribute msg)
viewportStyle model =
    [ transform ("scale(1,-1) translate(0,-" ++ toS model.state.height ++ ")") ]


chartStyle : Model -> List (Attribute msg)
chartStyle model =
    [ width (toS model.state.width)
    , height (toS model.state.height)
    ]


legendStyle : Attribute msg
legendStyle =
    style
        [ ( "margin-top", "20px" )
        , ( "text-align", "center" )
        ]


percentageAreaStyle : Attribute msg
percentageAreaStyle =
    style
        [ ( "height", "20px" )
        , ( "border-radius", "4px" )
        , ( "overflow", "hidden" )
        ]
