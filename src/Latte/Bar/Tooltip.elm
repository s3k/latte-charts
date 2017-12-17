module Latte.Bar.Tooltip exposing (view)

import Html exposing (Attribute, Html, div, ul, li, text, strong)
import Html.Attributes exposing (style)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


view : Model -> Html Msg
view model =
    div [ tooltipStyle model.state ]
        [ div []
            [ text model.state.tooltip.label
            , ul [ ulStyle ]
                [ li [ liStyle ]
                    [ div [] [ text model.state.tooltip.value ]
                    , strong [] [ text model.state.tooltip.dsTitle ]
                    ]
                ]
            ]
        ]



-- Style


tooltipStyle : State -> Attribute msg
tooltipStyle state =
    style
        ([ ( "position", "absolute" )
         , ( "left", toPx state.tooltip.x )
         , ( "top", toPx state.tooltip.y )
         , ( "display", state.tooltip.display )
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
