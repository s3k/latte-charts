module Latte.Update exposing (update)

import Latte.Model exposing (..)
import Latte.Msg exposing (..)
import Latte.Helper exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        Update x y val ->
            { model | state = updateTooltip x val model.state }


updateTooltip : Float -> Float -> State -> State
updateTooltip x val state =
    let
        tooltip =
            state.tooltip

        newTooltip =
            { tooltip | x = x, value = (toS val) }
    in
        { state | tooltip = newTooltip }
