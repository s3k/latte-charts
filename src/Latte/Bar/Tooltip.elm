module Latte.Bar.Tooltip exposing (view)

import Html exposing (Attribute, Html, div, li, node, strong, text, ul)
import Html.Attributes exposing (class, style)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


view : Model -> Html Msg
view model =
    div
        [ tooltipStyle model.state
        , class "tooltip-latte"
        ]
        [ node "style" [] [ arrowStyle ]
        , div []
            [ div [ labelStyle ] [ text model.state.tooltip.label ]
            , ul [ ulStyle ] (showDatasets model.state.tooltip)
            ]
        ]


showDatasets : Tooltip -> List (Html Msg)
showDatasets tooltip =
    tooltip.ds
        |> List.map (\n -> showDataset (Tuple.first n) (Tuple.second n))


showDataset : String -> String -> Html Msg
showDataset val title =
    li [ liStyle ]
        [ div [] [ text val ]
        , strong [ dsTitleStyle ] [ text title ]
        ]



-- Style


tooltipStyle : State -> Attribute msg
tooltipStyle state =
    style
        (commonFont
            ++ [ ( "position", "absolute" )
               , ( "left", toPx state.tooltip.x )
               , ( "top", toPx state.tooltip.y )
               , ( "display", state.tooltip.display )
               , ( "color", "white" )
               , ( "background-color", "black" )
               , ( "border-radius", "3px" )
               , opacityStyle
               , ( "min-width", "110px" )
               , ( "height", "82px" )
               ]
        )


dsTitleStyle : Attribute msg
dsTitleStyle =
    style
        [ opacityStyle
        , ( "padding", "10px 0px" )
        ]


labelStyle : Attribute msg
labelStyle =
    style
        [ ( "padding", "8px" )
        , opacityStyle
        ]


liStyle : Attribute msg
liStyle =
    style
        [ ( "border-top", "3px solid #C0D6E4" )
        , ( "padding", "8px" )
        , ( "display", "inline" )
        , ( "float", "left" )
        ]


ulStyle : Attribute msg
ulStyle =
    style
        [ ( "list-style-type", "none" )
        , ( "padding", "0" )
        , ( "margin", "0" )
        ]


opacityStyle =
    ( "opacity", "0.7" )


arrowStyle =
    text
        """
.tooltip-latte::after {
    content: "";
    position: absolute;
    top: 100%;
    left: 50%;
    margin-left: -5px;
    border-width: 5px;
    border-style: solid;
    border-color: black transparent transparent transparent;
}
  """
