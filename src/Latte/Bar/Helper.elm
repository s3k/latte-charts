module Latte.Bar.Helper exposing (..)

import Latte.Common.Style exposing (barWidth, chartPaddingLeft)
import Latte.Model exposing (..)


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

        areaWidth =
            state.width - chartPaddingLeft * 2

        barMarginRight =
            areaWidth / barsCount

        centerShift =
            areaWidth
                - (barsCount * barMarginRight)
                + (barMarginRight - barWidth / 2)
                / 2
    in
        chartPaddingLeft
            + (step * barMarginRight)
            + centerShift


calcMarginRight : Model -> Float
calcMarginRight model =
    let
        barsCount =
            toFloat model.state.elemCount

        areaWidth =
            model.state.width - chartPaddingLeft * 2
    in
        areaWidth / barsCount



-- paddingLeft + (step * barWidthAndMargin) + centerShift


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
