module Latte.Common.Area exposing (view)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Latte.Common.Helper exposing (..)
import Latte.Common.Style exposing (chartPaddingLeft, svgFontStyle)
import Latte.Model exposing (..)
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

        aspect =
            model.state.height / (model.state.maxBarLines + 1)
    in
    List.range 0 (floor model.state.maxBarLines)
        |> List.map (\n -> BarArea (toFloat n) (toFloat (round (yStep * toFloat n))))
        |> List.indexedMap (,)
        |> List.map (\( i, n ) -> latteBarLine i (aspect * n.i) (toString n.label) model.state)


latteBarLine : Int -> Float -> String -> State -> Svg msg
latteBarLine i pos label state =
    g [ transform ("translate(10, " ++ toString (pos + 18) ++ ")") ]
        [ barLine i state, barText label ]


barLine : Int -> State -> Svg msg
barLine i state =
    let
        strokeColor =
            if i == 0 then
                "#aaa"
            else
                "#dadada"

        attrs =
            [ x1 (toS chartPaddingLeft)
            , x2 (toS (state.width - chartPaddingLeft * 1.1))
            , y1 "0"
            , y2 "0"
            , style
                [ ( "stroke", strokeColor )
                , ( "stroke-width", "1" )
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
    style svgFontStyle
