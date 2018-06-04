module Subscriptions exposing (..)

import Time exposing (every, millisecond)
import Types exposing (..)


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        Paused ->
            Sub.none

        Running ->
            every (200 * millisecond) (always RunGeneration)
