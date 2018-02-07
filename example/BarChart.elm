module BarChart exposing (..)

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
    }


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


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        []



-- UPDATE


type Msg
    = Latte LatteMsg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteView model.latte)
        ]
