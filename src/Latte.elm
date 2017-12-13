{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake)

import Latte.Bar
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Svg exposing (Svg, svg)


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


latteDraw : Model -> Svg msg
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
