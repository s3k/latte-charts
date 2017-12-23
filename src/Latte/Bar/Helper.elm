module Latte.Bar.Helper exposing (..)

import Latte.Model exposing (..)


barWidth : Float
barWidth =
    34


barCenter : Float
barCenter =
    barWidth / 2


leftAlign : State -> Int -> Float
leftAlign state step_ =
    let
        barsCount =
            toFloat state.elemCount

        step =
            toFloat step_

        paddingLeft =
            70

        areaWidth =
            state.width - paddingLeft

        barMarginRight =
            30

        barWidthAndMargin =
            barWidth + barMarginRight

        centerShift =
            areaWidth / 2 - (barsCount * 70 + barWidth) / 2
    in
        paddingLeft + (step * barWidthAndMargin) + centerShift


calcHeight : State -> Float -> Float
calcHeight state val =
    let
        mbl =
            state.maxBarLines

        yMaxPx =
            mbl * state.height / (mbl + 1)

        coeff =
            state.maxDsValue / yMaxPx
    in
        val / coeff
