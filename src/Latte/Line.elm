module Latte.Line exposing (view)

import Html exposing (Attribute, div, text)
import Html.Attributes exposing (style)
import Latte.Common.Style exposing (..)
import Latte.Common.Title as Title
import Latte.Common.Tooltip as Tooltip
import Latte.Common.Area as Area
import Latte.Common.Ticks as Ticks
import Latte.Common.Lines as Lines


-- import Latte.Line.Ticks as Ticks

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
                , lines model
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


lines : Model -> Svg Msg
lines model =
    Lines.view model
