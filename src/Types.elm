module Types exposing (..)

import Matrix exposing (Matrix)


type alias Options =
    { cells : Int
    , cellSize : Int
    }


type alias Model =
    { options : Options
    , grid : Matrix Cell
    }


type Cell
    = Alive
    | Empty


type Msg
    = RunGeneration
