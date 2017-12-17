{-
   Render bars
   Refactoring needed
-}


module Latte.Bar.Ticks exposing (view)

import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, line, rect, svg, text, text_)
import Svg.Events exposing (onMouseOver, onMouseOut)
import Html.Attributes exposing (style)
import Svg.Attributes exposing (width, class, transform, x1, x2, y1, y2, x, y, textAnchor, attributeName, from, to, dur, fill)
import Latte.Helper exposing (..)


view : Model -> Svg Msg
view model =
    case List.head model.userData.datasets of
        Just ds ->
            g [ class "ticks" ] (toBarTicks model ds)

        Nothing ->
            g [ class "ticks" ] []



-- Bar ticks


toBarTicks : Model -> Dataset -> List (Svg Msg)
toBarTicks model ds =
    List.map3 (\i val label -> { i = i * 70 + leftAlign model.state, val = val, label = label }) (List.range 0 (List.length ds.values)) ds.values model.userData.labels
        |> List.map (\n -> barTick ds.title n.val (toFloat n.i) (calcHeight model.state n.val) n.label)


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


barTick : String -> Float -> Float -> Float -> String -> Svg Msg
barTick dsTitle val right height label =
    g
        [ transform ("translate(" ++ toString right ++ ", 0)")
        , onMouseOver (ShowTooltip right height val label dsTitle)
        , onMouseOut HideTooltip
        ]
        [ rect barTickAttr
            [ barTickAnimate height ]
        , line
            [ x1 "17.5"
            , x2 "17.5"
            , y1 "-1"
            , y2 "-5"
            , style [ ( "stroke", "#999" ), ( "stroke-width", "0.7" ) ]
            ]
            []
        , text_
            [ x "17.5"
            , y "15"
            , transform "scale(1,-1)"
            , style commonSvgFont
            , textAnchor "middle"
            ]
            [ text label ]
        ]


barTickAttr =
    [ style [ ( "fill", "#C0D6E4" ) ]
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
