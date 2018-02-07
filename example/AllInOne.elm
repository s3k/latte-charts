module AllInOne exposing (..)

import Html exposing (Html, div, li, ol, s, strong, text)
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { latte : LatteModel.Model
    , latte2 : LatteModel.Model
    , lattePercentage : LatteModel.Model
    , latteLine : LatteModel.Model
    , latteScatter : LatteModel.Model
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : ( Model, Cmd Msg )
init =
    ( { latte =
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
      , latte2 =
            latteInit 640 200 <|
                { chart = Bar
                , labels =
                    [ "Io", "Europa", "Ganymede", "Callisto" ]
                , datasets =
                    [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                    ]
                , title = "Moons of Jupiter"
                }
      , lattePercentage =
            latteInit 640 200 <|
                { chart = Percentage
                , labels =
                    [ "Io", "Europa", "Ganymede", "Callisto" ]
                , datasets =
                    [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                    ]
                , title = "Moons of Jupiter"
                }
      , latteLine =
            latteInit 640 200 <|
                { chart = Line
                , labels =
                    [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
                , datasets =
                    [ Dataset "Mars avg high"
                        [ 7, 18, 23, 20, 4, 0, 2, 1, 1, 4, 1, 3 ]
                    , Dataset
                        "Jupiter"
                      <|
                        List.map (\n -> n * 1.3) [ 8, 35, 14, 20, 4, 7, 2, 5, 7, 4, 1, 8 ]
                    , Dataset "Neptune"
                        [ 33, 8, 15, 45, 4, 10, 2, 4, 3, 7, 3, 1 ]
                    ]
                , title = "Temperature on planets"
                }
      , latteScatter =
            latteInit 640 200 <|
                { chart = Scatter
                , labels =
                    [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
                , datasets =
                    [ Dataset "Mars avg high"
                        [ 7, 18, 23, 20, 4, 0, 2, 1, 1, 4, 1, 3 ]
                    , Dataset
                        "Jupiter"
                      <|
                        List.map (\n -> n * 1.3) [ 8, 35, 14, 20, 4, 7, 2, 5, 7, 4, 1, 8 ]
                    , Dataset "Neptune"
                        [ 33, 8, 15, 45, 4, 10, 2, 4, 3, 7, 3, 1 ]
                    ]
                , title = "Temperature on planets"
                }
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | LatteSecond LatteMsg.Msg
    | LattePercentage LatteMsg.Msg
    | LatteLine LatteMsg.Msg
    | LatteScatter LatteMsg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )

        LatteSecond msg ->
            ( { model | latte2 = latteUpdate msg model.latte2 }, Cmd.none )

        LattePercentage msg ->
            ( { model | lattePercentage = latteUpdate msg model.lattePercentage }, Cmd.none )

        LatteLine msg ->
            ( { model | latteLine = latteUpdate msg model.latteLine }, Cmd.none )

        LatteScatter msg ->
            ( { model | latteScatter = latteUpdate msg model.latteScatter }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map LatteLine (latteView model.latteLine)
        , Html.map LatteScatter (latteView model.latteScatter)
        , Html.map Latte (latteView model.latte)
        , Html.map LattePercentage (latteView model.lattePercentage)
        , Html.map LatteSecond (latteView model.latte2)
        ]
