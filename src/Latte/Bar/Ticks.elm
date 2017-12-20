{-
   Render bars
   Refactoring needed
-}


module Latte.Bar.Ticks exposing (view)

import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, line, rect, svg, text, text_)
import Svg.Events exposing (onMouseOver, onMouseOut)
import Html
import Html.Attributes exposing (style)
import Svg.Attributes exposing (width, class, transform, x1, x2, y1, y2, x, y, textAnchor, attributeName, from, to, dur, fill)
import Latte.Helper exposing (..)


view : Model -> Svg Msg
view model =
    case List.head model.userData.datasets of
        Just ds ->
            g [ class "bars-latte" ] (toBarTicks model ds)

        Nothing ->
            g [ class "bars-latte" ] []



-- Bar ticks


toBarTicks : Model -> Dataset -> List (Svg Msg)
toBarTicks model ds =
    List.map3 (\i val label -> { position = leftAlign model.state i, val = val, label = label }) (List.range 0 (List.length ds.values)) ds.values model.userData.labels
        |> List.map (\n -> barTick ds.title n.val n.position (calcHeight model.state n.val) n.label)



-- Common


barWidth : Float
barWidth =
    34


barCenter : Float
barCenter =
    barWidth / 2


leftAlign : State -> Int -> Float
leftAlign state step_ =
    let
        barsCount =
            toFloat state.elemCount

        step =
            toFloat step_

        paddingLeft =
            70

        areaWidth =
            state.width - paddingLeft

        barMarginRight =
            30

        barWidthAndMargin =
            barWidth + barMarginRight

        centerShift =
            areaWidth / 2 - (barsCount * 70 + barWidth) / 2
    in
        paddingLeft + (step * barWidthAndMargin) + centerShift


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
        [ transform ("translate(" ++ toString right ++ ", 18)")
        ]
        [ rect
            [ barTickStyle True
            , width (toS barWidth)
            , onMouseOut HideTooltip
            , onMouseOver (ShowTooltip right height val label dsTitle)
            ]
            [ (barTickAnimate height)
            ]
        , line
            [ x1 (toS barCenter)
            , x2 (toS barCenter)
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


barTickStyle : Bool -> Html.Attribute msg
barTickStyle selected =
    let
        baseColor =
            "#C0D6E4"
    in
        if selected == True then
            style
                [ ( "fill", Debug.log "color" <| darken baseColor )
                ]
        else
            style
                [ ( "fill", baseColor )
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
