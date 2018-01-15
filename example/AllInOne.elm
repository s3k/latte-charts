module AllInOne exposing (..)

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
    , latteLine : LatteModel.Model
    , latteScatter : LatteModel.Model
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
    , latteLine =
        latteMake 640 200 <|
            { chart = Line
            , labels =
                [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
            , datasets =
                [ Dataset "Mars avg high"
                    [ 7, 18, 23, 20, 4, 0, 2, 1, 1, 4, 1, 3 ]
                , Dataset
                    "Jupyter"
                  <|
                    List.map (\n -> n * 1.3) [ 8, 35, 14, 20, 4, 7, 2, 5, 7, 4, 1, 8 ]
                , Dataset "Neptune"
                    [ 33, 8, 15, 45, 4, 10, 2, 4, 3, 7, 3, 1 ]
                ]
            , title = "Moons of Jupiter"
            }
    , latteScatter =
        latteMake 640 200 <|
            { chart = Scatter
            , labels =
                [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ]
            , datasets =
                [ Dataset "Mars avg high"
                    [ 7, 18, 23, 20, 4, 0, 2, 1, 1, 4, 1, 3 ]
                , Dataset
                    "Jupyter"
                  <|
                    List.map (\n -> n * 1.3) [ 8, 35, 14, 20, 4, 7, 2, 5, 7, 4, 1, 8 ]
                , Dataset "Neptune"
                    [ 33, 8, 15, 45, 4, 10, 2, 4, 3, 7, 3, 1 ]
                ]
            , title = "Moons of Jupiter"
            }
    }



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | LatteSecond LatteMsg.Msg
    | LattePercentage LatteMsg.Msg
    | LatteLine LatteMsg.Msg
    | LatteScatter LatteMsg.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Latte msg ->
            { model | latte = (latteUpdate msg model.latte) }

        LatteSecond msg ->
            { model | latte2 = (latteUpdate msg model.latte2) }

        LattePercentage msg ->
            { model | lattePercentage = (latteUpdate msg model.lattePercentage) }

        LatteLine msg ->
            { model | latteLine = (latteUpdate msg model.latteLine) }

        LatteScatter msg ->
            { model | latteScatter = (latteUpdate msg model.latteScatter) }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map LatteLine (latteDraw model.latteLine)
        , Html.map LatteScatter (latteDraw model.latteScatter)
        , Html.map Latte (latteDraw model.latte)
        , Html.map LattePercentage (latteDraw model.lattePercentage)
        , Html.map LatteSecond (latteDraw model.latte2)
        , ol []
            [ strong [] [ text "Todo:" ]
            , li [] [ s [] [ text "Aspect Bars by X" ] ]
            , li [] [ s [] [ text "Humanize dataset labels" ] ]
            , li [] [ s [] [ text "Add onClick action to bar" ] ]
            , li [] [ s [] [ text "Implement triples" ] ]
            , li [] [ s [] [ text "Implement colors for datasets" ] ]
            , li [] [ s [] [ text "Tooltip for Percentage" ] ]
            , li [] [ text "RENDER DOTS!" ]
            , li [] [ text "Implement Line Chart" ]
            , li [] [ text "Implement css styles in single file" ]
            , li [] [ text "Refactoring (clean up mess in code)" ]
            , li [] [ text "Tune Design" ]
            ]
        ]
