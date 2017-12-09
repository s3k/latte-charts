module Main exposing (..)

import Html exposing (Html)
import Latte.Layout exposing (latte)
import Latte.Model exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


model : Model
model =
    { chartType = Bar
    , labels = [ "One", "Two", "Three", "Four" ]
    , datasets = [ (Dataset "First" [ 110, 20, 13, 30, 130, 230 ]) ]
    }



-- UPDATE


type Msg
    = Update


update : Msg -> Model -> Model
update msg model =
    case msg of
        Update ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    latte model
