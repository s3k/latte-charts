module Latte.Update exposing (update)

import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowTooltip ptr x y val label dsTitle ->
            { model | state = showTooltip ptr x y val label dsTitle model }

        HideTooltip ->
            { model | state = hideTooltip model.state }



-- Updaters


showTooltip : Int -> Float -> Float -> Float -> String -> String -> Model -> State
showTooltip ptr x y val label dsTitle model =
    let
        state =
            model.state

        tooltip =
            state.tooltip

        barChart =
            state.barChart

        newTooltip =
            { tooltip
                | x = x - 17
                , y = (state.height - y) - 55
                , label = label
                , display = "block"
                , ds = makeTooltipDataset ptr model.userData.datasets
            }

        newBarChart =
            { barChart | selected = ptr }
    in
    { state | tooltip = newTooltip, barChart = newBarChart }


makeTooltipDataset : Int -> List Dataset -> List ( String, String )
makeTooltipDataset ptr ds =
    ds
        |> List.map (\n -> ( n.title, toS <| listItemByIndex ptr n.values ))


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
