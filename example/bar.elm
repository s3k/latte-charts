module Bar exposing (..)

import Html exposing (Html, div, text)
import Latte exposing (..)
import Latte.Model as Latte exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { hello : String
    , latte : Latte.Model
    }


model : Model
model =
    { hello =
        "Hello"
    , latte =
        latteMake 640 200 <|
            { chart = Bar
            , labels = [ "Io", "Europa", "Ganymede", "Callisto" ]
            , datasets = [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000 ] ]
            , title = "Moons of Jupyter"
            }
    }



-- UPDATE


type Msg
    = Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ latteDraw model.latte
        ]
