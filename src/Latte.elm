{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake, latteUpdate)

import Latte.Bar
import Latte.Percentage
import Latte.Line
import Latte.Scatter
import Latte.Common.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Update exposing (update)
import Svg exposing (Svg, svg)


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
        , maxDsValue = scaleY <| maxDsValue data
        , maxBarLines = maxBarLines height
        , elemCount = List.length data.labels
        , dsCount = List.length data.datasets
        , tooltip =
            { label = "Label"
            , title = "Title"
            , display = "none"
            , x = 0
            , y = 0
            , ds = [ ( "Value", "Title" ) ]
            }
        , barChart =
            { selected = -1
            }
        , colors =
            [ "#7cd6fd"
            , "#5e64ff"
            , "#743ee2"
            , "#ff5858"
            , "#ffa00a"
            , "#feef72"
            , "#28a745"
            , "#98d85b"
            , "#b554ff"
            , "#ffa3ef"
            , "#36114C"
            , "#bdd3e6"
            , "#f0f4f7"
            , "#b8c2cc"
            ]
        }
    }


latteDraw : Model -> Svg Msg
latteDraw model =
    case model.userData.chart of
        Bar ->
            Latte.Bar.view model

        Line ->
            Latte.Line.view model

        Scatter ->
            Latte.Scatter.view model

        Percentage ->
            Latte.Percentage.view model

        Pie ->
            svg [] []
