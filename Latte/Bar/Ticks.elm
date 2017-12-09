module Latte.Bar.Ticks exposing (view)

import Svg exposing (Svg, svg, rect, g, text_, text, animate)
import Svg.Attributes exposing (..)
import Latte.Model exposing (..)


view : Model -> State -> Svg msg
view model state =
    case (List.head model.datasets) of
        Just ds ->
            g [ class "ticks" ] (toBarTicks state ds.values)

        Nothing ->
            g [ class "ticks" ] []



-- Bar ticks


toBarTicks : State -> List Float -> List (Svg msg)
toBarTicks state ds =
    List.map2 (\i val -> { i = (i * 50 + (leftAlign state)), val = val }) (List.range 0 (List.length ds)) ds
        |> List.map (\n -> barTick (toFloat n.i) (calcHeight state n.val))


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


barTick : Float -> Float -> Svg msg
barTick right height =
    g [ transform ("translate(" ++ toString right ++ ", 0)") ]
        [ rect barTickAttr
            [ barTickAnimate height
            ]
        ]


barTickAttr =
    [ style "fill: #f6a192"
    , width "30"
    ]


barTickAnimate : Float -> Svg msg
barTickAnimate height =
    animate
        [ attributeName "height"
        , from "0"
        , to (toString (Debug.log "h" height))
        , dur "0.4s"
        , fill "freeze"
        ]
        []
