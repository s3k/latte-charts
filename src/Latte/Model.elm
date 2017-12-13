module Latte.Model exposing (..)


type Msg
    = Update Float Float
    | ShowTooltip


type Chart
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


type alias Tooltip =
    { title : String
    , x : Float
    , y : Float
    }


type alias State =
    { width : Float
    , height : Float
    , maxDsValue : Float
    , maxBarLines : Int
    , elemCount : Int
    , tooltip : Tooltip
    }


type alias UserData =
    { chart : Chart
    , labels : List String
    , datasets : List Dataset
    , title : String
    }


type alias Model =
    { userData : UserData
    , state : State
    }



-- Helpers
{-
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
-}
