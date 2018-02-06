module Landing exposing (..)

import Html exposing (Html, a, div, footer, h1, h2, h3, h4, header, img, li, ol, p, s, strong, text)
import Html.Attributes exposing (class, height, href, src, style, target)
import Html.Events exposing (onClick)
import LandingDesc
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
import Window


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- MODEL


type alias Model =
    { latte : LatteModel.Model
    , chartBtns : List ( Chart, String )
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { latte =
                latteMake 800 200 <|
                    { chart = Bar
                    , labels =
                        [ "Io", "Europa", "Ganymede", "Callisto", "Fake" ]
                    , datasets =
                        [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000, 10759000 ]
                        , Dataset "Diameter" <|
                            List.map (\n -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6, 4000 ]
                        , Dataset "Semi-Major" [ 421700, 671034, 1070412, 1882709, 1882709 ]
                        ]
                    , title = "Biggest Moons of Jupiter"
                    }
            , chartBtns =
                [ ( Bar, "active" )
                , ( Line, "" )
                , ( Scatter, "" )
                , ( Percentage, "" )
                ]
            }
    in
    model ! []


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [-- Window.size (\{ height, width } -> WindowSize height width)
        ]



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | ChangeChart Chart
    | WindowSize Int Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )

        ChangeChart msg ->
            let
                lt =
                    model.latte

                ltUserData =
                    lt.userData

                ltUserData_ =
                    { ltUserData | chart = msg }

                lt_ =
                    { lt | userData = ltUserData_ }

                chartBtns =
                    model.chartBtns
                        |> List.map
                            (\( chart, _ ) ->
                                ( chart
                                , if msg == chart then
                                    "active"
                                  else
                                    ""
                                )
                            )
            in
            ( { model | latte = lt_, chartBtns = chartBtns }, Cmd.none )

        WindowSize w h ->
            ( Debug.log "Window Size" model, Cmd.none )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ header []
            [ div [ class "container" ]
                [ div [ class "row" ]
                    [ div [ class "column" ]
                        [ div [ class "logo animated bounceInDown" ] []
                        , p [ class "subtitle animated fadeIn" ]
                            [ text "Library for creating charts in Elm language"
                            ]
                        ]
                    ]
                ]
            ]
        , div [ class "section" ]
            [ div
                [ class "container content animated fadeIn"
                ]
                [ mainChart model
                , div [ class "row" ] [ LandingDesc.view ]

                -- , jupiterView model
                ]
            ]
        , footer []
            [ div [ class "row footer" ]
                [ div [ class "center columns" ]
                    [ a
                        [ href "http://github.com/s3k/latte"
                        , target "_blank"
                        ]
                        [ img
                            [ height 70
                            , src "./www/images/GitHub_Logo.png"
                            ]
                            []
                        ]
                    , a
                        [ href "http://elm-lang.org"
                        , target "_blank"
                        ]
                        [ img
                            [ height 70
                            , src "./www/images/elm.svg"
                            ]
                            []
                        ]
                    ]
                ]
            ]
        ]



-- View Sections


mainChart : Model -> Html Msg
mainChart model =
    div [ class "row" ]
        [ h2 [ class "center" ]
            [ text "Moons of Jupiter" ]
        , div
            [ class "content-item" ]
            [ Html.map Latte (latteDraw model.latte)
            , div [ class "center btn-group" ] <| makeChartBtns model
            ]
        ]


makeChartBtns : Model -> List (Html Msg)
makeChartBtns model =
    model.chartBtns
        |> List.map
            (\( chart, status ) ->
                a
                    [ class <| String.join " " [ "btn", status ]
                    , onClick (ChangeChart chart)
                    ]
                    [ text <| toString chart ++ " Chart" ]
            )


jupiterView : Model -> Html Msg
jupiterView model =
    div [ class "row" ]
        [ div [ class "six columns" ]
            [ h1 []
                [ text "Moons of Jupiter" ]
            , p
                []
                [ text
                    """
                      There are 69 known moons of Jupiter.
                      This gives Jupiter the largest number of moons with reasonably stable orbits of any planet in the Solar System.
                    """
                ]
            , p [] [ text "Compare the biggest on latte bar chart!" ]
            ]
        , div [ class "six columns content-item" ]
            [ Html.map Latte (latteDraw model.latte)
            ]
        ]
