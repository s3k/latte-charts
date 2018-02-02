module LandingDesc exposing (view)

import Markdown
import Html exposing (Html)
import Html.Attributes exposing (class)


view : Html msg
view =
    Markdown.toHtml [ class "content" ] """

##### Hello


It is an experimental Elm charting library. Here I’m attempting to figure out how to use Elm language in practice. At this moment my project goes through pre-alpha version, so your feedback, suggestions and pull requests are welcome;)

##### How to install?

Add package Latte Chart package

```
$ elm package install s3k/latte
```

##### Let's write something!

```
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
```

##### Data preparation

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

##### Connect latte chart to your program

```
type Msg
    = Latte LatteMsg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )


```

##### Behold!

Use **latteDraw** function to render chart. Notice! Use **Html.map** to map all events.

```
view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteDraw model.latte)]

```

"""
