module Latte.Bar.Tooltip exposing (view)

import Html exposing (Attribute, div, text)
import Html.Attributes exposing (style)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, g, svg)
import Svg.Attributes exposing (height, transform, viewBox, width)


view : Model -> Svg Msg
view model =
    div [ tooltipStyle model ]
        [ text (tooltipName model)
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
