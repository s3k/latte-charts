module Latte.Bar exposing (view)

import Html exposing (Attribute, div, text)
import Latte.Common.Area as Area
import Latte.Common.Ticks as Ticks
import Latte.Common.Style exposing (..)
import Latte.Common.Title as Title
import Latte.Common.Tooltip as Tooltip
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Svg exposing (Svg, g, svg)


view : Model -> Svg Msg
view model =
    div [ boxStyle model ]
        [ Title.view model
        , Tooltip.view model
        , svg (chartStyle model)
            [ g (viewportStyle model)
                [ area model
                , ticks model
                ]
            ]
        ]



-- Helpers


area : Model -> Svg Msg
area model =
    Area.view model


ticks : Model -> Svg Msg
ticks model =
    Ticks.view model
