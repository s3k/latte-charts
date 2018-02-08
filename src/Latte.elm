module Latte exposing (latteInit, latteUpdate, latteView)

{-| With this module you can create, update and draw chart in your `Html.program`.

For more details watch [Live Demo](https://s3k.github.io/latte-charts/)

@docs latteInit, latteUpdate, latteView

-}

import Latte.Bar
import Latte.Common.Helper exposing (..)
import Latte.Line
import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Percentage
import Latte.Scatter
import Latte.Update exposing (update)
import Svg exposing (Svg, svg)


{-| Use helper **latteInit** to create Latte Chart state:

1.  Set rendering options: hight x width
2.  Choose the chart type: **Bar | Line | Scatter | Percentage**
3.  Fill labels and datasets. Labels are Strings and datasets are Floats

```
init : ( Model, Cmd Msg )
init =
    let
        model =
            { latte =
                latteInit 640 200 <|
                    { chart = Bar
                    , labels =
                        [ "Io", "Europa", "Ganymede", "Callisto" ]
                    , datasets =
                        [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                        , Dataset "Diameter" <| List.map (\n -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6 ]
                        , Dataset "Semi-Major" [ 421700, 671034, 1070412, 1882709 ]
                        ]
                    , title = "Moons of Jupiter"
                    }
            }
    in
    model ! []
```

-}
latteInit : Float -> Float -> UserData -> Model
latteInit width height data =
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


{-| Create new message type and add handler in an update section.

    type Msg
        = Latte LatteMsg.Msg

    update : Msg -> Model -> ( Model, Cmd Msg )
    update msg model =
        case msg of
            Latte msg ->
                ( { model | latte = latteUpdate msg model.latte }, Cmd.none )

-}
latteUpdate : Msg -> Model -> Model
latteUpdate msg model =
    update msg model


{-| Use this function to render a chart through **Html.map** function to route all events in a component.

    view : Model -> Html Msg
    view model =
        div []
            [ Html.map Latte (latteDraw model.latte) ]

-}
latteView : Model -> Svg Msg
latteView model =
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
