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
        ([ ( "color", "#555" )
         , ( "font-size", "14px" )
         , ( "font-weight", "300" )
         ]
            ++ commonFont
        )
