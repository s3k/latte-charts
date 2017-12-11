module Latte.Layout exposing (latte)

import Svg exposing (Svg, svg, g, text_, text)
import Svg.Attributes exposing (..)
import Latte.Model exposing (..)
import Latte.Bar.Area
import Latte.Bar.Ticks
import Latte.Model exposing (..)


latte : Model -> Svg Msg
latte model =
    case model.chartType of
        Bar ->
            makeBar model

        Line ->
            svg [] []

        Scatter ->
            svg [] []

        Pie ->
            svg [] []

        Percentage ->
            svg [] []


init : Model -> State
init model =
    { width = 600
    , height = 240
    , maxDsValue = maxDsValue model
    , maxBarLines = 5
    , elemCount = List.length model.labels
    }


makeBar : Model -> Svg Msg
makeBar model =
    let
        state =
            init model
    in
        view model state (Latte.Bar.Area.view model state) (Latte.Bar.Ticks.view model state)


view : Model -> State -> Svg Msg -> Svg Msg -> Svg Msg
view model state area ticks =
    svg
        [ width (toString state.width)
        , height (toString state.height)
        , viewBox (String.join " " [ "0", "0", toString state.width, toString (state.height + 20) ])
        ]
        [ g [ transform ("scale(1,-1) translate(0,-" ++ (toString state.height) ++ ")") ]
            [ area, ticks ]
        , g [ transform ("translate(" ++ toString model.pos ++ ",100)") ] [ text_ [] [ text "hello" ] ]
        ]
