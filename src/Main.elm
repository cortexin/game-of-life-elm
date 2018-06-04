module Main exposing (..)

import Html exposing (..)
import Matrix exposing (square, row)
import Subscriptions exposing (subscriptions)
import Types exposing (..)
import Update exposing (update)
import View exposing (view)


init : ( Model, Cmd Msg )
init =
    ( { options =
            { cells = 50
            , cellSize = 20
            }
      , grid =
            square 50
                (\l ->
                    if row l == 2 then
                        Alive
                    else
                        Empty
                )
      }
    , Cmd.none
    )


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
