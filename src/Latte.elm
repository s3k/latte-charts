{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake, latteUpdate)

import Latte.Bar
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Update exposing (update)
import Svg exposing (Svg, svg)
import Latte.Msg exposing (..)


latteUpdate : Msg -> Model -> Model
latteUpdate msg model =
    update msg model


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
            { title = "Tooltip"
            , x = 100
            , y = 100
            , value = ""
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
