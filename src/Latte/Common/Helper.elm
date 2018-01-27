{-
   Helper module with common used functions
-}


module Latte.Common.Helper exposing (..)

import Bitwise exposing (..)
import Hex
import Latte.Model exposing (Model, UserData, Dataset)


toPx : a -> String
toPx val =
    toS val ++ "px"


toPr : a -> String
toPr val =
    toS val ++ "%"


toS : a -> String
toS val =
    toString val



-- Model Helpers


maxDsPoints : Model -> List Float
maxDsPoints model =
    model.userData.datasets
        |> List.map (\ds -> ds.values)
        |> transpose
        |> List.map
            (\vals ->
                List.maximum vals
                    |> Maybe.withDefault 0.0
            )


maxBarLines : Float -> Float
maxBarLines height =
    height / 35.0


maxDsValue : UserData -> Float
maxDsValue model =
    model.datasets
        |> List.map (\n -> n.values)
        |> List.concat
        |> List.maximum
        |> justNumber


calcFirstDsPercents : Model -> List Float
calcFirstDsPercents model =
    let
        dataset =
            model.userData.datasets
                |> List.head
                |> Maybe.withDefault (Dataset "" [])

        dsSum =
            List.sum dataset.values
    in
        dataset.values
            |> List.map (\n -> n * 100 / dsSum)


percentageOffset : Int -> Model -> Float
percentageOffset ptr model =
    model
        |> calcFirstDsPercents
        |> List.indexedMap (,)
        |> List.filter (\( i, n ) -> i <= ptr)
        |> List.map (\( i, n ) -> n)
        |> divLastElem
        |> List.sum
        |> (\n -> n * 640 / 100 - 24)


divLastElem : List Float -> List Float
divLastElem items =
    items
        |> List.indexedMap (,)
        |> List.map
            (\( i, n ) ->
                if i == (List.length items) - 1 then
                    n / 2
                else
                    n
            )


floatByIndex : Int -> List Float -> Float
floatByIndex i items =
    listItemByIndex i items |> justNumber


stringByIndex : Int -> List String -> String
stringByIndex i items =
    listItemByIndex i items |> justString


listItemByIndex : Int -> List a -> Maybe a
listItemByIndex i items =
    items
        |> List.indexedMap (,)
        |> List.filter (\n -> Tuple.first n == i)
        |> List.map (\n -> Tuple.second n)
        |> List.head


justNumber item =
    case item of
        Just x ->
            x

        Nothing ->
            0


justString item =
    case item of
        Just x ->
            x

        Nothing ->
            ""



-- Darken color


darken : String -> String
darken strColor =
    let
        color =
            String.dropLeft 1 strColor
                |> (++) "0x"
    in
        case String.toInt color of
            Ok intColor ->
                intColor
                    |> and 0x00FFFFFF
                    |> shiftRightBy 1
                    |> Hex.toString
                    |> (++) "#"

            Err msg ->
                "#333333"



-- Scale Y Axis chart


scaleY : Float -> Float
scaleY n =
    let
        base =
            toFloat (logBase 10 n |> ceiling)

        n_ =
            n / 10 ^ base
    in
        roundNumberScale n_ * 10 ^ base


roundNumberScale : Float -> Float
roundNumberScale n =
    if n <= 0.1 then
        0.1
    else if n <= 0.2 && n > 0.1 then
        0.2
    else if n <= 0.3 && n > 0.2 then
        0.3
    else if n <= 0.4 && n > 0.3 then
        0.4
    else if n <= 0.5 && n > 0.4 then
        0.5
    else if n <= 0.6 && n > 0.5 then
        0.6
    else if n <= 0.7 && n > 0.6 then
        0.7
    else if n <= 0.8 && n > 0.7 then
        0.8
    else if n <= 0.9 && n > 0.8 then
        0.9
    else
        1.0



-- Transpose matrix


transpose : List (List a) -> List (List a)
transpose ll =
    case ll of
        [] ->
            []

        [] :: xss ->
            transpose xss

        (x :: xs) :: xss ->
            let
                heads =
                    List.filterMap List.head xss

                tails =
                    List.filterMap List.tail xss
            in
                (x :: heads) :: transpose (xs :: tails)
