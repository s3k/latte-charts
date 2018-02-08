module Latte.Model exposing (..)

{-| Latte Chart Types.

@docs Chart, Dataset, BarArea, BarArea, State, UserData, Model, BarChart, Tooltip

-}


{-| Latte chart types.
Pick one.
-}
type Chart
    = Bar
    | Line
    | Scatter
    | Percentage


{-| String title and List of Float's.
-}
type alias Dataset =
    { title : String
    , values : List Float
    }


{-| Legenda
-}
type alias BarArea =
    { i : Float
    , label : Float
    }


{-| Tooltip datastructire.
Position and dataset values under cursor.
-}
type alias Tooltip =
    { label : String
    , title : String
    , display : String
    , x : Float
    , y : Float
    , ds : List ( String, String )
    }


{-| On mouse over state.
-}
type alias BarChart =
    { selected : Int
    }


{-| Chart state.
-}
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


{-| User data.
-}
type alias UserData =
    { chart : Chart
    , labels : List String
    , datasets : List Dataset
    , title : String
    }


{-| Chart model. Composing user data and chart state.
-}
type alias Model =
    { userData : UserData
    , state : State
    }
