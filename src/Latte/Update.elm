module Latte.Update exposing (update)

import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Helper exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowTooltip x y val label dsTitle ->
            { model | state = showTooltip x y val label dsTitle model.state }

        HideTooltip ->
            { model | state = hideTooltip model.state }



-- Updaters


showTooltip : Float -> Float -> Float -> String -> String -> State -> State
showTooltip x y val label dsTitle state =
    let
        tooltip =
            state.tooltip

        newTooltip =
            { tooltip
                | x = x
                , y = (state.height - y) - 70
                , value = (toS val)
                , label = label
                , dsTitle = dsTitle
                , display = "block"
            }
    in
        { state | tooltip = newTooltip }


hideTooltip : State -> State
hideTooltip state =
    let
        tooltip =
            state.tooltip

        newTooltip =
            { tooltip | display = "none" }
    in
        { state | tooltip = newTooltip }
