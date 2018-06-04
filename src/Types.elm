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


type Msg
    = A
    | B


type Cell
    = Alive
    | Empty
