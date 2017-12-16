{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake, latteUpdate)

import Latte.Bar
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Svg exposing (Svg, svg)
import Latte.Msg exposing (..)


latteUpdate : Msg -> Model -> Model
latteUpdate msg model =
    case msg of
        Update x y ->
            { model | state = updateTooltip x model.state }


updateTooltip : Float -> State -> State
updateTooltip x state =
    let
        tooltip =
            state.tooltip

        newTooltip =
            { tooltip | x = x }
    in
        { state | tooltip = newTooltip }


latteMake : Float -> Float -> UserData -> Model
latteMake width height data =
    { userData =
        data
    , state =
        { width = width
        , height = height
        , maxDsValue = maxDsValue data
        , maxBarLines = maxBarLines height
        , elemCount = List.length data.labels
        , tooltip =
            { title = "Tooltip title"
            , x = 100
            , y = 100
            }
        }
    }


latteDraw : Model -> Svg Msg
latteDraw model =
    case model.userData.chart of
        Bar ->
            Latte.Bar.view model

        Line ->
            svg [] []

        Scatter ->
            svg [] []

        Pie ->
            svg [] []

        Percentage ->
            svg [] []
