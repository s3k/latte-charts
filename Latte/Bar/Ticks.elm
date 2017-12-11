module Latte.Bar.Ticks exposing (view)

import Svg exposing (Svg, svg, rect, g, text_, text, animate)
import Svg.Attributes exposing (..)
import Svg.Events exposing (onClick)
import Latte.Model exposing (..)


view : Model -> State -> Svg Msg
view model state =
    case (List.head model.datasets) of
        Just ds ->
            g [ class "ticks" ] (toBarTicks state ds model.labels)

        Nothing ->
            g [ class "ticks" ] []



-- Bar ticks


toBarTicks : State -> Dataset -> List String -> List (Svg Msg)
toBarTicks state ds labels =
    List.map3 (\i val label -> { i = (i * 50 + (leftAlign state)), val = val, label = label }) (List.range 0 (List.length ds.values)) ds.values labels
        |> List.map (\n -> barTick (toFloat n.i) (calcHeight state n.val) n.label)


leftAlign : State -> Int
leftAlign state =
    round ((state.width - (toFloat state.elemCount) * 50) / 2)


calcHeight : State -> Float -> Float
calcHeight state val =
    let
        mbl =
            toFloat state.maxBarLines

        yMaxPx =
            mbl * state.height / (mbl + 1)

        coeff =
            state.maxDsValue / yMaxPx
    in
        val / coeff


barTick : Float -> Float -> String -> Svg Msg
barTick right height label =
    g
        [ transform ("translate(" ++ toString right ++ ", 0)")
        , onClick (Update right)
        ]
        [ rect barTickAttr
            [ barTickAnimate height ]
        , text_ [ x "0", y "15", transform "scale(1,-1)", style textStyle ] [ text label ]
        ]


barTickAttr =
    [ style "fill: #f6a192"
    , width "30"
    ]


barTickAnimate : Float -> Svg Msg
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
        font-weight: 100;
  """
