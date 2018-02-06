module Latte.Update exposing (update)

import Latte.Common.Helper exposing (..)
import Latte.Bar.Helper exposing (calcMarginRight, leftAlign)
import Latte.Common.Style exposing (barWidth, chartPaddingLeft)
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

        tooltipY =
            case model.userData.chart of
                Percentage ->
                    6

                _ ->
                    (state.height - y) - 62 - 10

        commonTpX =
            x
                - 3.5
                + chartPaddingLeft
                / 2
                - barWidth
                * (toFloat <| List.length model.userData.datasets)

        tooltipX =
            case model.userData.chart of
                Percentage ->
                    percentageOffset ptr model

                _ ->
                    commonTpX

        barChart =
            state.barChart

        newTooltip =
            { tooltip
                | x = tooltipX
                , y = tooltipY
                , label = label
                , title = dsTitle
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
        |> List.map (\n -> ( n.title, toS <| floatByIndex ptr n.values ))


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
