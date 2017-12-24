module Latte.Model exposing (..)


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
    { label : String
    , display : String
    , x : Float
    , y : Float
    , ds : List ( String, String )
    }


type alias BarChart =
    { selected : Int
    }


type alias State =
    { width : Float
    , height : Float
    , maxDsValue : Float
    , maxBarLines : Float
    , elemCount : Int
    , dsCount : Int
    , tooltip : Tooltip
    , barChart : BarChart
    , colors : List String
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
