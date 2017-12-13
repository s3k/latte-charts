module Latte.Bar.Ticks exposing (view)

import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, line, rect, svg, text, text_)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onMouseOver)


view : Model -> Svg msg
view model =
    case List.head model.userData.datasets of
        Just ds ->
            g [ class "ticks" ] (toBarTicks model ds)

        Nothing ->
            g [ class "ticks" ] []



-- Bar ticks


toBarTicks : Model -> Dataset -> List (Svg msg)
toBarTicks model ds =
    List.map3 (\i val label -> { i = i * 70 + leftAlign model.state, val = val, label = label }) (List.range 0 (List.length ds.values)) ds.values model.userData.labels
        |> List.map (\n -> barTick (toFloat n.i) (calcHeight model.state n.val) n.label)


leftAlign : State -> Int
leftAlign state =
    round ((state.width - toFloat state.elemCount * 50) / 2)


calcHeight : State -> Float -> Float
calcHeight state val =
    let
        mbl =
            state.maxBarLines

        yMaxPx =
            mbl * state.height / (mbl + 1)

        coeff =
            state.maxDsValue / yMaxPx
    in
    val / coeff


barTick : Float -> Float -> String -> Svg msg
barTick right height label =
    g
        [ transform ("translate(" ++ toString right ++ ", 0)")

        -- , onMouseOver (Update right height)
        ]
        [ rect barTickAttr
            [ barTickAnimate height ]
        , line
            [ x1 "17.5"
            , x2 "17.5"
            , y1 "-1"
            , y2 "-5"
            , style "stroke: #999; stroke-width: 0.7"
            ]
            []
        , text_
            [ x "17.5"
            , y "15"
            , transform "scale(1,-1)"
            , style textStyle
            , textAnchor "middle"
            ]
            [ text label ]
        ]


barTickAttr =
    [ style "fill: #C0D6E4"
    , width "35"
    ]


barTickAnimate : Float -> Svg msg
barTickAnimate height =
    animate
        [ attributeName "height"
        , from "0"
        , to (toString height)
        , dur "0.4s"
        , fill "freeze"
        ]
        []



-- Style


textStyle =
    """
        text-rendering: optimizeLegibility;
        color: rgb(108, 118, 128);
        display: inline;
        fill: rgb(85, 91, 81);
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Oxygen, Ubuntu, Cantarell, "Fira Sans", "Droid Sans", "Helvetica Neue", sans-serif;
        font-size: 11px;
        font-weight: 300;
  """
