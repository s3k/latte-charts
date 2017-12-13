module Latte.Bar.Area exposing (view)

import Html exposing (Attribute)
import Html.Attributes exposing (style)
import Latte.Model exposing (..)
import Svg exposing (Svg, g, line, text, text_)
import Svg.Attributes exposing (class, textAnchor, transform, x, x1, x2, y, y1, y2)


view : Model -> Svg msg
view model =
    g [ class "lines" ] (makeLines model)



-- Logic


makeLines : Model -> List (Svg msg)
makeLines model =
    let
        yStep =
            model.state.maxDsValue / model.state.maxBarLines
    in
    List.range 0 (floor model.state.maxBarLines)
        |> List.map (\n -> BarArea (toFloat n) (toFloat (round (yStep * toFloat n))))
        |> List.map (\n -> latteBarLine (model.state.height / (model.state.maxBarLines + 1) * n.i) (toString n.label))


latteBarLine : Float -> String -> Svg msg
latteBarLine pos label =
    g [ transform ("translate(10, " ++ toString pos ++ ")") ]
        [ barLine, barText label ]


barLine =
    let
        attrs =
            [ x1 "15"
            , x2 "600"
            , y1 "0"
            , y2 "0"
            , style
                [ ( "stroke", "#bbb" )
                , ( "stroke-width", "0.5" )
                , ( "shape-rendering", "crispEdges" )
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
            , x "0"
            , y "0"
            , barTextStyle
            , textAnchor "end"
            ]
    in
    text_ attrs [ text label ]


barTextStyle : Attribute msg
barTextStyle =
    style
        [ ( "text-rendering", "optimizeLegibility" )
        , ( "color", "rgb(108, 118, 128)" )
        , ( "display", "inline" )
        , ( "fill", "rgb(85, 91, 81)" )
        , ( "font-family", "-apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Fira Sans', 'Droid Sans', 'Helvetica Neue', sans-serif" )
        , ( "font-size", "11px" )
        , ( "font-weight", "100" )
        ]
