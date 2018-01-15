module Latte.Line.Ticks exposing (view)

import Html
import Html.Attributes exposing (style)
import Latte.Common.Helper exposing (..)
import Latte.Bar.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, g, line, rect, circle, svg, text, text_)
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
    let
        maxDs =
            maxDsPoints model
    in
        g [ class "bars-latte" ] (toBarTicks model maxDs)


toBarTicks : Model -> List Float -> List (Svg Msg)
toBarTicks model ds =
    List.map3
        (\i val label ->
            { ptr = i
            , position = leftAlign model.state i
            , val = val
            , label = label
            , subTicks = makeSubTicks model i
            }
        )
        (List.range 0 (List.length ds))
        ds
        model.userData.labels
        |> List.map
            (\n ->
                barTick
                    n.ptr
                    n.subTicks
                    "Title"
                    -- ds.title
                    n.val
                    n.position
                    (calcHeight model.state n.val)
                    n.label
                    model.state
            )



-- Common


makeSubTicks : Model -> Int -> List (Svg Msg)
makeSubTicks model ptr =
    model.userData.datasets
        |> List.map (\dataset -> floatByIndex ptr dataset.values)
        |> List.indexedMap (,)
        |> List.map (\( i, val ) -> subTick model.state i val)


subTick : State -> Int -> Float -> Svg Msg
subTick state i val =
    let
        subWidth =
            barWidth / toFloat state.dsCount

        right =
            toFloat i * subWidth
    in
        circle
            [ width (toS subWidth)
            , style [ ( "fill", stringByIndex i state.colors ) ]
            , Svg.Attributes.r "4"
            , Svg.Attributes.cx "17"
            , Svg.Attributes.cy <| toS <| calcHeight state val
            ]
            [ animate
                [ attributeName "cy"
                , from "0"
                , to (toS <| calcHeight state val)
                , dur "0.2s"
                , fill "freeze"
                ]
                []
            ]


barTick : Int -> List (Svg Msg) -> String -> Float -> Float -> Float -> String -> State -> Svg Msg
barTick ptr subTicks dsTitle val right height label state =
    g
        [ transform ("translate(" ++ toString (right / 1.35 + 110) ++ ", 18)")
        ]
        (subTicks
            ++ [ line
                    [ x1 (toS barCenter)
                    , x2 (toS barCenter)
                    , y1 "1"
                    , y2 <| toS state.height
                    , style [ ( "stroke", "#999" ), ( "stroke-width", "0.7" ) ]
                    ]
                    []
               , rect
                    [ barTickStyle state ptr
                    , width (toS barWidth)
                    , onMouseOut HideTooltip
                    , onMouseOver (ShowTooltip ptr right height val label dsTitle)
                    , opacity "0.0"
                    ]
                    [ barTickAnimate height
                    ]
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
