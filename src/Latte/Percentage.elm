module Latte.Percentage exposing (view)

import Html exposing (Html, Attribute, div, span, i, text)
import Html.Attributes exposing (style, class)
import Latte.Helper exposing (..)
import Latte.Percentage.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Common.Title as Title
import Latte.Common.Tooltip as Tooltip
import Svg.Events exposing (onMouseOut, onMouseOver)


view : Model -> Html Msg
view model =
    div [ boxStyle model ]
        [ Title.view model
        , Tooltip.view model
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
    in
        (List.map3
            (\ptr color percent -> barItem ptr color percent)
            (List.range 0 (List.length colors - 1))
            colors
            percents
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


barItem : Int -> String -> Float -> Html Msg
barItem ptr color percent =
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
            , onMouseOver (ShowTooltip ptr 50 0 0 "Label" "Title")
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
