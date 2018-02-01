module Landing exposing (..)

import Html exposing (Html, div, li, ol, s, strong, text, h1, h2, h3, h4, p, a, header)
import Html.Attributes exposing (class, style)
import Html.Events exposing (onClick)
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
import Window
import Markdown


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
                        , Dataset "Diameter" <| List.map (\n -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6, 4000 ]
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
        [ Window.resizes (\{ height, width } -> Resize height width)
        ]



-- UPDATE


type Msg
    = Latte LatteMsg.Msg
    | ChangeChart Chart
    | Resize Int Int


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

        Resize w h ->
            ( Debug.log "123" model, Cmd.none )



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
                , installView model
                  -- , jupiterView model
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
                    [ text <| (toString chart) ++ " Chart" ]
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



-- Markdown description


installView : Model -> Html Msg
installView model =
    div [ class "row" ]
        [ Markdown.toHtml [ class "content" ] """

##### Hello


It is an experimental Elm charting library. Here I’m attempting to figure out how to use Elm language in practice. At this moment my project goes through pre-alpha version, so your feedback, suggestions and pull requests are welcome;)

##### Installation

Add package Latte Chart package

```
$ elm package install s3k/latte
```

##### Imports

```
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
```

##### Prepare model

Use helper **latteMake** to create Latte Chart model.

1. Declare resolution height x width and fill structure
1. Choose chart type: **Bar | Line | Scatter | Percentage**
1. Fill labels and datasets. Labels are Strings and datasets are Floats

```
type alias Model =
    { latte : LatteModel.Model
    }


init : ( Model, Cmd Msg )
init =
    let
        model =
            { latte =
                latteMake 950 200 <|
                    { chart = Bar
                    , labels =
                        [ "Io", "Europa", "Ganymede", "Callisto", "Fake" ]
                    , datasets =
                        [ Dataset "Mass" [ 8931900, 4800000, 14819000, 10759000, 10759000 ]
                        , Dataset "Diameter" <| List.map (
 -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6, 4000 ]
                        , Dataset "Semi-Major" [ 421700, 671034, 1070412, 1882709, 1882709 ]
                        ]
                    , title = "Biggest Moons of Jupiter"
                    }
            }
    in
        model ! []
```

##### Setting up Update

```
type Msg
    = Latte LatteMsg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )


```

##### Emerge View

Use **latteDraw** function to render chart. Notice! Use **Html.map** to map all events.

```
view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteDraw model.latte)]

```

"""
        ]
