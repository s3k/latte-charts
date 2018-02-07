module Latte.Common.Ticks exposing (view)

import Html
import Html.Attributes exposing (style)
import Latte.Bar.Helper exposing (..)
import Latte.Common.Helper exposing (..)
import Latte.Common.Style exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, animate, circle, g, line, rect, svg, text, text_)
import Svg.Attributes
    exposing
        ( attributeName
        , class
        , dur
        , fill
        , from
        , opacity
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
        )
import Svg.Events exposing (onMouseOut, onMouseOver)


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
                    "TITLE"
                    -- ds.title
                    n.val
                    n.position
                    (calcHeight model.state n.val)
                    n.label
                    model
            )



-- Common


barTick : Int -> List (Svg Msg) -> String -> Float -> Float -> Float -> String -> Model -> Svg Msg
barTick ptr subTicks dsTitle val right height label model =
    let
        state =
            model.state

        lineY1 =
            if model.userData.chart == Bar then
                "-1"
            else
                "1"

        lineY2 =
            if model.userData.chart == Bar then
                "-5"
            else
                toS state.height
    in
        g
            [ transform ("translate(" ++ toString right ++ ", 18)")
            ]
            (List.concat
                [ [ lineTickItem lineY1 lineY2
                  , textTickItem label
                  ]
                , subTicks
                , [ rectTickItem model ptr right height val label dsTitle
                  ]
                ]
            )


textTickItem : String -> Svg Msg
textTickItem label =
    text_
        [ x "17.5"
        , y "15"
        , transform "scale(1,-1)"
        , style svgFontStyle
        , textAnchor "middle"
        ]
        [ text label ]


rectTickItem : Model -> Int -> Float -> Float -> Float -> String -> String -> Svg Msg
rectTickItem model ptr right height val label dsTitle =
    rect
        [ barTickStyle
        , width (toS barWidth)
        , onMouseOut HideTooltip
        , opacity "0.0"
        , onMouseOver (ShowTooltip ptr right height val label dsTitle)
        ]
        [ barTickAnimate height
        ]


lineTickItem : String -> String -> Svg Msg
lineTickItem ly1 ly2 =
    line
        [ x1 (toS barCenter)
        , x2 (toS barCenter)
        , y1 ly1
        , y2 ly2
        , style [ ( "stroke", "#999" ), ( "stroke-width", "0.7" ) ]
        ]
        []


makeSubTicks : Model -> Int -> List (Svg Msg)
makeSubTicks model ptr =
    model.userData.datasets
        |> List.map (\dataset -> floatByIndex ptr dataset.values)
        |> List.indexedMap (,)
        |> List.map (\( i, val ) -> subTick model i val)


subTick : Model -> Int -> Float -> Svg Msg
subTick model i val =
    let
        subWidth =
            barWidth / toFloat model.state.dsCount

        right =
            toFloat i * subWidth
    in
        case model.userData.chart of
            Bar ->
                subTickRect i val right subWidth model

            _ ->
                subTickCircle i val subWidth model


subTickRect : Int -> Float -> Float -> Float -> Model -> Svg Msg
subTickRect i val right subWidth model =
    rect
        [ width (toS subWidth)
        , style [ ( "fill", stringByIndex i model.state.colors ) ]
        , transform ("translate(" ++ toS right ++ ", 0)")
        ]
        [ barTickAnimate <| calcHeight model.state val ]


subTickCircle : Int -> Float -> Float -> Model -> Svg Msg
subTickCircle i val subWidth model =
    circle
        [ width (toS subWidth)
        , style [ ( "fill", stringByIndex i model.state.colors ) ]
        , Svg.Attributes.r "4"
        , Svg.Attributes.cx "17"
        , Svg.Attributes.cy <| toS <| calcHeight model.state val
        ]
        [ animate
            [ attributeName "cy"
            , from "0"
            , to (toS <| calcHeight model.state val)
            , dur "0.2s"
            , fill "freeze"
            ]
            []
        ]



-- Styles


barTickStyle : Html.Attribute msg
barTickStyle =
    style
        [ ( "fill", "#C0D6E4" )
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
