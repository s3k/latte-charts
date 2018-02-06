module BarChart exposing (..)

import Html exposing (Html, div, li, ol, s, strong, text)
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
import Window


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { hello : String
    , latte : LatteModel.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { hello =
                "Hello, this is a Latte Chart example"
            , latte =
                latteMake 640 200 <|
                    { chart = Bar
                    , labels =
                        [ "Io", "Europa", "Ganymede", "Callisto" ]
                    , datasets =
                        [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                        , Dataset "Diameter" <|
                            List.map (\n -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6 ]
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
        [ Window.resizes (\{ height, width } -> Resize height width)
        ]



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | Resize Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )

        Resize w h ->
            ( Debug.log "123" model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteDraw model.latte)
        ]
