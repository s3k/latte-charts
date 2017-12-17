module Latte.Bar.Title exposing (view)

import Html exposing (Attribute, Html, div, text)
import Html.Attributes exposing (style)
import Latte.Helper exposing (..)
import Latte.Model exposing (..)
import Latte.Msg exposing (..)


view : Model -> Html Msg
view model =
    div [ titleStyle ]
        [ text model.userData.title
        ]



-- Style


titleStyle : Attribute msg
titleStyle =
    style
        (commonFont
            ++ [ ( "margin-bottom", "10px" )
               , ( "margin-top", "5px" )
               ]
        )
