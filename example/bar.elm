module Bar exposing (..)

import Html exposing (Html, div, text, ol, li, strong, s)
import Latte exposing (..)
import Latte.Msg as LatteMsg
import Latte.Model as LatteModel exposing (Chart(..), Dataset)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { hello : String
    , latte : LatteModel.Model
    , latte2 : LatteModel.Model
    , lattePercentage : LatteModel.Model
    }


model : Model
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
                , Dataset "Diameter" <| List.map (\n -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6 ]
                , Dataset "Semi-Major" [ 421700, 671034, 1070412, 1882709 ]
                ]
            , title = "Moons of Jupiter"
            }
    , latte2 =
        latteMake 640 200 <|
            { chart = Bar
            , labels =
                [ "Io", "Europa", "Ganymede", "Callisto" ]
            , datasets =
                [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                ]
            , title = "Moons of Jupiter"
            }
    , lattePercentage =
        latteMake 640 200 <|
            { chart = Percentage
            , labels =
                [ "Io", "Europa", "Ganymede", "Callisto" ]
            , datasets =
                [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ]
                ]
            , title = "Moons of Jupiter"
            }
    }



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | LatteSecond LatteMsg.Msg
    | LattePercentage LatteMsg.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Latte msg ->
            { model | latte = (latteUpdate msg model.latte) }

        LatteSecond msg ->
            { model | latte2 = (latteUpdate msg model.latte2) }

        LattePercentage msg ->
            { model | lattePercentage = (latteUpdate msg model.lattePercentage) }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map LattePercentage (latteDraw model.lattePercentage)
        , Html.map Latte (latteDraw model.latte)
        , Html.map LatteSecond (latteDraw model.latte2)
        , ol []
            [ strong [] [ text "Todo:" ]
            , li [] [ s [] [ text "Aspect Bars by X" ] ]
            , li [] [ s [] [ text "Humanize dataset labels" ] ]
            , li [] [ s [] [ text "Add onClick action to bar" ] ]
            , li [] [ s [] [ text "Implement triples" ] ]
            , li [] [ s [] [ text "Implement colors for datasets" ] ]
            , li [] [ text "Implement css styles in single file" ]
            , li [] [ text "Tooltip for Percentage" ]
            , li [] [ text "Find same code pices" ]
            , li [] [ text "Tune fonts" ]
            , li [] [ text "Refactoring (clean up mess in code)" ]
            ]
        ]
