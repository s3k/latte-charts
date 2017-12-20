module Latte.Update exposing (update)

import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowTooltip ptr x y val label dsTitle ->
            { model | state = showTooltip ptr x y val label dsTitle model.state }

        HideTooltip ->
            { model | state = hideTooltip model.state }



-- Updaters


showTooltip : Int -> Float -> Float -> Float -> String -> String -> State -> State
showTooltip ptr x y val label dsTitle state =
    let
        tooltip =
            state.tooltip

        barChart =
            state.barChart

        newTooltip =
            { tooltip
                | x = x - 17
                , y = (state.height - y) - 55
                , value = toS val
                , label = label
                , dsTitle = dsTitle
                , display = "block"
            }

        newBarChart =
            { barChart | selected = ptr }
    in
        { state | tooltip = newTooltip, barChart = newBarChart }


hideTooltip : State -> State
hideTooltip state =
    let
        tooltip =
            state.tooltip

        newTooltip =
            { tooltip | display = "none" }

        barChart =
            state.barChart

        newBarChart =
            { barChart | selected = -1 }
    in
        { state | tooltip = newTooltip, barChart = newBarChart }
