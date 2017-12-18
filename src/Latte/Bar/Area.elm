module Latte.Bar.Area exposing (view)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Latte.Model exposing (..)
import Latte.Helper exposing (..)
import Svg exposing (Svg, g, line, text, text_)
import Svg.Attributes exposing (class, textAnchor, transform, x, x1, x2, y, y1, y2)


view : Model -> Svg msg
view model =
    g [ class "lines-latte" ] (makeLines model)



-- Logic


makeLines : Model -> List (Svg msg)
makeLines model =
    let
        yStep =
            model.state.maxDsValue / model.state.maxBarLines
    in
        List.range 0 (floor model.state.maxBarLines)
            |> List.map (\n -> BarArea (toFloat n) (toFloat (round (yStep * toFloat n))))
            |> List.map (\n -> latteBarLine (model.state.height / (model.state.maxBarLines + 1) * n.i) (toString n.label) model.state)


latteBarLine : Float -> String -> State -> Svg msg
latteBarLine pos label state =
    g [ transform ("translate(10, " ++ toString (pos + 18) ++ ")") ]
        [ barLine state, barText label ]


paddingLeft =
    55


barLine : State -> Svg msg
barLine state =
    let
        attrs =
            [ x1 (toS paddingLeft)
            , x2 (toS (state.width - paddingLeft * 1.1))
            , y1 "0"
            , y2 "0"
            , style
                [ ( "stroke", "#bbb" )
                , ( "stroke-width", "0.5" )
                , ( "fill", "none" )
                ]
            ]
    in
        line attrs []


barText : String -> Svg msg
barText label =
    let
        attrs =
            [ transform "scale(1,-1)"
            , x "50"
            , y "3"
            , barTextStyle
            , textAnchor "end"
            ]
    in
        text_ attrs [ text label ]


barTextStyle : Attribute msg
barTextStyle =
    style commonSvgFont
