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
    , labels = [ "Io", "Europa", "Ganymede", "Callisto" ]
    , datasets = [ (Dataset "Mass" (List.map (\n -> n / 1000) [ 8931900, 4800000, 14819000, 10759000 ])) ]
    , posX = 100
    , posY = 100
    }



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        Update posX posY ->
            { model | posX = posX, posY = posY }

        ShowTooltip ->
            model



-- VIEW


view : Model -> Html Msg
view model =
    latte model
