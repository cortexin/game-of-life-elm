module Subscriptions exposing (..)

import Time exposing (every, millisecond)
import Types exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    every (200 * millisecond) (always RunGeneration)
