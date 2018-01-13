module Latte.Common.Title exposing (view)

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
        [ ( "margin-bottom", "4px" )
        , ( "margin-top", "16px" )
        , ( "font-size", "12px" )
        , ( "font-family", "\"proxima-nova\", sans-serif" )
        , ( "color", "#6c7680" )
        ]
