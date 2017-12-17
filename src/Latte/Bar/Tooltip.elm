module Latte.Bar.Tooltip exposing (view)

import Html exposing (Attribute, Html, div, ul, li, text, strong)
import Html.Attributes exposing (style)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


view : Model -> Html Msg
view model =
    div [ tooltipStyle model ]
        [ div []
            [ text "label"
              -- text (tooltipName model)
            , ul [ ulStyle ]
                [ li [ liStyle ]
                    [ div [] [ text "value" ]
                    , strong [] [ text "dataset name" ]
                    ]
                ]
            ]
        ]



-- Style


tooltipStyle : Model -> Attribute msg
tooltipStyle model =
    style
        ([ ( "position", "absolute" )
         , ( "left", toPx model.state.tooltip.x )
         , ( "top", toPx model.state.tooltip.y )
         ]
            ++ commonFont
        )


liStyle : Attribute msg
liStyle =
    style [ ( "border-top", "2px solid #ff00ff" ) ]


ulStyle : Attribute msg
ulStyle =
    style
        [ ( "list-style-type", "none" )
        , ( "padding", "0" )
        , ( "margin", "0" )
        ]
