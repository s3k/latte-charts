module Latte.Common.Tooltip exposing (view, viewPr)

import Html exposing (Attribute, Html, div, li, node, strong, text, ul)
import Html.Attributes exposing (class, style)
import Latte.Common.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


-- Common View


view : Model -> Html Msg
view model =
    div
        [ tooltipStyle model.state
        , class "tooltip-latte"
        ]
        [ node "style" [] [ arrowStyle ]
        , div []
            [ div [ labelStyle ] [ text model.state.tooltip.label ]
            , ul [ ulStyle ] (showDatasets model.state)
            ]
        ]



-- Percentage View


viewPr : Model -> Html Msg
viewPr model =
    div
        [ tooltipStyle model.state
        , class "tooltip-latte"
        ]
        [ node "style" [] [ arrowStyle ]
        , div []
            [ div [ labelStyle ]
                [ text model.state.tooltip.label
                , text <| " " ++ model.state.tooltip.title ++ "%"
                ]
            ]
        ]


showDatasets : State -> List (Html Msg)
showDatasets state =
    state.tooltip.ds
        |> List.indexedMap (,)
        |> List.map (\( i, ( val, title ) ) -> showDataset i state val title)


showDataset : Int -> State -> String -> String -> Html Msg
showDataset i state val title =
    li [ liStyle i state ]
        [ div [ style [ ( "margin", "6px" ) ] ]
            [ div [] [ text val ]
            , strong [ dsTitleStyle ] [ text title ]
            ]
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
                 -- , ( "min-width", "110px" )
                 -- , ( "height", "82px" )
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
        , ( "font-weight", "600" )
        , opacityStyle
        ]


liStyle : Int -> State -> Attribute msg
liStyle i state =
    style
        [ ( "border-top", "3px solid " ++ stringByIndex i state.colors )
          -- , ( "padding", "0px 8px" )
        , ( "display", "inline" )
        , ( "float", "left" )
        , ( "width", "70px" )
        , ( "height", "50px" )
        ]


ulStyle : Attribute msg
ulStyle =
    style
        [ ( "list-style-type", "none" )
        , ( "padding", "0px" )
        , ( "margin", "0" )
        ]


opacityStyle =
    ( "opacity", "0.8" )


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
    border-bottom-width: 0px;
    border-style: solid;
    border-color: black transparent transparent transparent;
}
  """
