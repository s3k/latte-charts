module Latte.Percentage exposing (view)

import Html exposing (Html, Attribute, div, span, i, text)
import Html.Attributes exposing (style, class)
import Latte.Common.Helper exposing (..)
import Latte.Percentage.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Common.Title as Title
import Latte.Common.Tooltip as Tooltip
import Svg.Events exposing (onMouseOut, onMouseOver)
import Round


view : Model -> Html Msg
view model =
    div [ boxStyle model ]
        [ Title.view model
        , Tooltip.viewPr model
        , div
            [ class "latte-percentage"
            , style
                [ ( "height", "20px" )
                , ( "border-radius", "4px" )
                , ( "overflow", "hidden" )
                ]
            ]
            (makeBars model)
        , legend model
        ]


makeBars : Model -> List (Html Msg)
makeBars model =
    let
        colors =
            model.state.colors

        percents =
            calcFirstDsPercents model

        labels =
            model.userData.labels
    in
        (List.map4
            (\ptr color percent label -> barItem ptr color percent label)
            (List.range 0 (List.length colors - 1))
            colors
            percents
            labels
        )


legend : Model -> Html Msg
legend model =
    let
        colors =
            model.state.colors

        labels =
            model.userData.labels
    in
        div [ legendStyle ]
            (List.map2
                (\color label -> legendItem color label)
                colors
                labels
            )


legendItem : String -> String -> Html Msg
legendItem color title =
    span
        [ style
            [ ( "margin-right", "10px" )
            ]
        ]
        [ i
            [ style
                [ ( "color", color )
                , ( "margin-right", "5px" )
                ]
            ]
            [ text "●" ]
        , span [ style commonFont ] [ text title ]
        ]


barItem : Int -> String -> Float -> String -> Html Msg
barItem ptr color percent label =
    let
        attrs =
            style
                [ ( "background", color ++ " none repeat scroll 0% 0%" )
                , ( "width", toPr percent )
                , ( "height", "20px" )
                , ( "float", "left" )
                ]
    in
        div
            [ attrs
            , onMouseOver (ShowTooltip ptr 50 0 0 label (Round.round 2 percent))
            , onMouseOut HideTooltip
            ]
            []



-- Styles


legendStyle : Attribute msg
legendStyle =
    style
        [ ( "margin-top", "20px" )
        , ( "text-align", "center" )
        ]


boxStyle : Model -> Attribute msg
boxStyle model =
    style
        [ ( "padding", "10px" )
        , ( "margin", "10px" )
        , ( "position", "relative" )
        , ( "border", "1px solid #ccc" )
        , ( "max-width", toPx model.state.width )
        , ( "border-radius", "3px" )
        ]
