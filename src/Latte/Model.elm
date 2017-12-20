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
    , value : String
    , dsTitle : String
    , display : String
    , x : Float
    , y : Float
    }


type alias State =
    { width : Float
    , height : Float
    , maxDsValue : Float
    , maxBarLines : Float
    , elemCount : Int
    , tooltip : Tooltip
    , darkBar : Bool
    , selectedBar : Int
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
