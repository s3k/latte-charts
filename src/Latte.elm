{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake)

import Svg exposing (Svg, svg)
import Latte.Model exposing (..)
import Latte.Bar


latteMake : Float -> Float -> UserData -> Model
latteMake width height data =
    { userData =
        data
    , state =
        { width = width
        , height = height
        , maxDsValue = 0
        , maxBarLines = 5
        , elemCount = 0
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
