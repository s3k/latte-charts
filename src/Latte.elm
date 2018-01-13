{-
   Main latte module
-}


module Latte exposing (latteDraw, latteMake, latteUpdate)

import Latte.Bar
import Latte.Percentage
import Latte.Helper exposing (..)
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
        , colors = [ "#7cd6fd", "#5e64ff", "#743ee2", "#c79dd7", "#4d1b7b" ]
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
            Latte.Percentage.view model
