module Types exposing (..)

import Matrix exposing (Matrix, Location)


type alias Options =
    { cells : Int
    , cellSize : Int
    }


type alias Model =
    { options : Options
    , grid : Matrix Cell
    , state : State
    }


type Cell
    = Alive
    | Empty


type Msg
    = RunGeneration
    | SwitchState
    | InvertCell Location


type State
    = Paused
    | Running
