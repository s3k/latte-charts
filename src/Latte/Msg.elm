module Latte.Msg exposing (..)

{-| Latte Chart Events.

@docs Msg

-}


{-| Show and Hide Tooltip.
-}
type Msg
    = ShowTooltip Int Float Float Float String String
    | HideTooltip
