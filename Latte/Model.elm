module Latte.Model exposing (..)


type ChartType
    = Bar
    | Line
    | Scatter
    | Pie
    | Percentage


type alias Dataset =
    { title : String
    , values : List Float
    }


type alias BarArea =
    { i : Float
    , label : Float
    }


type alias State =
    { width : Float
    , height : Float
    , maxDsValue : Float
    , maxBarLines : Int
    , elemCount : Int
    }


type alias Model =
    { chartType : ChartType
    , labels : List String
    , datasets : List Dataset
    }



-- Helpers


maxDsValue : Model -> Float
maxDsValue model =
    model.datasets
        |> List.map (\n -> n.values)
        |> List.concat
        |> List.maximum
        |> justNumber


justNumber item =
    case item of
        Just x ->
            x

        Nothing ->
            0
