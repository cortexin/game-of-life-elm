module Update exposing (update)

import Matrix exposing (..)
import Types exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RunGeneration ->
            ( { model | grid = runGeneration model }, Cmd.none )

        SwitchState ->
            let
                newState =
                    case model.state of
                        Paused ->
                            Running

                        Running ->
                            Paused
            in
                ( { model | state = newState }, Cmd.none )

        InvertCell p ->
            ( { model | grid = invertCell model p }, Cmd.none )


invertCell : Model -> Location -> Matrix Cell
invertCell model p =
    let
        newCell =
            case get p model.grid of
                Just cell ->
                    case cell of
                        Alive ->
                            Empty

                        Empty ->
                            Alive

                Nothing ->
                    Empty
    in
        case model.state of
            Running ->
                model.grid

            Paused ->
                set p newCell model.grid


runGeneration : Model -> Matrix Cell
runGeneration model =
    mapWithLocation (determineCellState model.grid) model.grid


determineCellState : Matrix Cell -> Location -> Cell -> Cell
determineCellState grid coord cell =
    let
        numNeighbors =
            countAliveNeighbors coord grid
    in
        case cell of
            Alive ->
                if 1 < numNeighbors && numNeighbors < 4 then
                    Alive
                else
                    Empty

            Empty ->
                case numNeighbors of
                    3 ->
                        Alive

                    _ ->
                        Empty


countAliveNeighbors : Location -> Matrix Cell -> Int
countAliveNeighbors coord grid =
    let
        gridSize =
            colCount grid

        x =
            col coord

        y =
            row coord

        neighbors =
            [ loc (x + 1) (y + 1)
            , loc (x + 1) (y - 1)
            , loc (x + 1) y
            , loc (x - 1) (y + 1)
            , loc (x - 1) (y - 1)
            , loc (x - 1) y
            , loc x (y + 1)
            , loc x (y - 1)
            ]
    in
        neighbors
            |> List.map (toInt << getLocOverflow grid)
            |> List.sum


toInt : Cell -> Int
toInt cell =
    case cell of
        Alive ->
            1

        Empty ->
            0


preventOverflow : Int -> Int -> Int
preventOverflow x maxX =
    if x < 0 then
        maxX
    else if x > maxX then
        0
    else
        x


getLocOverflow : Matrix Cell -> Location -> Cell
getLocOverflow grid coord =
    let
        x =
            preventOverflow (col coord) (colCount grid - 1)

        y =
            preventOverflow (row coord) (rowCount grid - 1)
    in
        case Matrix.get (loc x y) grid of
            Just p ->
                p

            Nothing ->
                Empty
