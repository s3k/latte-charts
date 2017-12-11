module Latte.Bar.Area exposing (view)

import Svg exposing (Svg, g, line, text_, text)
import Svg.Attributes exposing (..)
import Latte.Model exposing (..)


view : Model -> State -> Svg msg
view model state =
    g [ class "lines" ] (makeLines model state)



-- Logic


makeLines : Model -> State -> List (Svg msg)
makeLines model state =
    let
        yStep =
            state.maxDsValue / toFloat state.maxBarLines
    in
        List.range 0 state.maxBarLines
            |> List.map (\n -> BarArea (toFloat n) (toFloat (round (yStep * toFloat n))))
            |> List.map (\n -> latteBarLine (240 / 6 * n.i) (toString n.label))


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
            , style "stroke: #bbb; stroke-width: 0.7"
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
            , style barTextStyle
            , textAnchor "end"
            ]
    in
        text_ attrs [ text label ]


barTextStyle =
    """
        text-rendering: optimizeLegibility;
        color: rgb(108, 118, 128);
        display: inline;
        fill: rgb(85, 91, 81);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
        font-size: 11px;
        font-weight: 100;
  """
