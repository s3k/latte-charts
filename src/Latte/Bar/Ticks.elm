{-
   Render bars
   Refactoring needed
-}


module Latte.Bar.Ticks exposing (view)

import Html
import Html.Attributes exposing (style)
import Latte.Helper exposing (..)
import Latte.Bar.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, line, rect, svg, text, text_)
import Svg.Events exposing (onMouseOut, onMouseOver)
import Svg.Attributes
    exposing
        ( attributeName
        , class
        , dur
        , fill
        , from
        , textAnchor
        , to
        , transform
        , width
        , x
        , x1
        , x2
        , y
        , y1
        , y2
        , opacity
        )


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
    List.map3 (\i val label -> { ptr = i, position = leftAlign model.state i, val = val, label = label, subTicks = makeSubTicks model i }) (List.range 0 (List.length ds.values)) ds.values model.userData.labels
        |> List.map (\n -> barTick n.ptr n.subTicks ds.title n.val n.position (calcHeight model.state n.val) n.label model.state)



-- Common


makeSubTicks : Model -> Int -> List (Svg Msg)
makeSubTicks model ptr =
    model.userData.datasets
        |> List.map (\dataset -> listItemByIndex ptr dataset.values)
        |> List.indexedMap (,)
        |> List.map (\( i, val ) -> subTick model.state i val)


subTick : State -> Int -> Float -> Svg Msg
subTick state i val =
    let
        subWidth =
            5.0

        right =
            toFloat i * subWidth * 1.1
    in
        rect
            [ width (toS subWidth)
            , style [ ( "fill", "#555" ) ]
            , transform ("translate(" ++ toS right ++ ", 0)")
            ]
            [ barTickAnimate <| calcHeight state val ]


barTick : Int -> List (Svg Msg) -> String -> Float -> Float -> Float -> String -> State -> Svg Msg
barTick ptr subTicks dsTitle val right height label state =
    g
        [ transform ("translate(" ++ toString right ++ ", 18)")
        ]
        (subTicks
            ++ [ rect
                    [ barTickStyle state ptr
                    , width (toS barWidth)
                    , onMouseOut HideTooltip
                    , opacity "0.5"
                    , onMouseOver (ShowTooltip ptr right height val label dsTitle)
                    ]
                    [ barTickAnimate height
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
        )


barTickStyle : State -> Int -> Html.Attribute msg
barTickStyle state ptr =
    let
        baseColor =
            "#C0D6E4"
    in
        if state.barChart.selected == ptr then
            style
                [ ( "fill", darken baseColor )
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
