<p align="center">
  <img width="274" src="https://s3k.github.io/latte/www/images/logo.svg">
</p>

### Hello

It is an experimental Elm charting library. Here I’m attempting to figure out how to use Elm language in practice. At this moment my project goes through pre-alpha version, so your feedback, suggestions and pull requests are welcome ;)

![](https://s3k.github.io/latte/www/images/chart.png "Elm Latte Bar Chart")

### TL; DR

1. Add Latte Chart package to your project with `$ elm package install s3k/latte`
1. Import functions and types from Latte package
1. Describe new latte state in your Html.program (The Elm Architecture pattern). Use **latteMake** helper
1. Connect all chart events in **update** section
1. To render Latte Chart component in your view use **latteDraw** function through **Html.map**

Download full [Example here](https://github.com/s3k/latte/blob/master/example/BarChart.elm)  
Check interactive [Demo](https://s3k.github.io/latte/)

### How to install?

Just add a new package by running the following command:

```
$ elm package install s3k/latte
```

And import main functions and types.

```
import Latte exposing (..)
import Latte.Model as LatteModel exposing (Chart(..), Dataset)
import Latte.Msg as LatteMsg
```

### Model. Data preparation

Use helper **latteMake** to create Latte Chart model:

1. Set rendering options: hight x width
1. Choose the chart type: **Bar | Line | Scatter | Percentage**
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
                        , Dataset "Diameter" <|
                            List.map ( -> n * 1000) [ 3660.0, 3121.6, 5262.4, 4820.6, 4000 ]
                        , Dataset "Semi-Major" [ 421700, 671034, 1070412, 1882709, 1882709 ]
                        ]
                    , title = "Biggest Moons of Jupiter"
                    }
            }
    in
        model ! []
```


### Update. Connect latte chart to update event loop

Create new message type and add handler in update section

```
type Msg
    = Latte LatteMsg.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Latte msg ->
            ( { model | latte = latteUpdate msg model.latte }, Cmd.none )


```

### View. Render a component

Use **latteDraw** function to render a chart through **Html.map** function to route all events in a component.

```
view : Model -> Html Msg
view model =
    div []
        [ Html.map Latte (latteDraw model.latte)]

```

### Outro

As I told before — it’s a pre-alpha, which is very far from production.
The next steps are adding negative values, fixing bugs with tooltip position and realization of based on width auto-scaling.
If someone have ideas of how to do that, let me know! Also PR's are welcome)

