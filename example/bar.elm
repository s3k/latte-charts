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
            , datasets = [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ] ]
            , title = "Moons of Jupiter"
            }
    }



-- UPDATE


type Msg
    = Latte LatteMsg.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Latte msg ->
            { model | latte = (latteUpdate msg model.latte) }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteDraw model.latte)
        , ol []
            [ strong [] [ text "Todo:" ]
            , li [] [ s [] [ text "Aspect Bars by X" ] ]
            , li [] [ s [] [ text "Humanize dataset labels" ] ]
            , li [] [ text "Tune fonts" ]
            , li [] [ text "Add onClick action to bar" ]
            , li [] [ text "Refactoring (clean up mess in code)" ]
            ]
        ]
