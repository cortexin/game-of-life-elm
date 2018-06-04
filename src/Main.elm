module Main exposing (..)

import Html exposing (..)
import Matrix exposing (..)
import Types exposing (..)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { options =
            { cells = 20
            , cellSize = 20
            }
      , grid = square 20 (always Empty)
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
