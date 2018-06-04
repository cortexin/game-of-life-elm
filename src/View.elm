module View exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Matrix exposing (..)
import Svg exposing (Svg, svg, rect, g)
import Svg.Attributes exposing (..)
import Types exposing (..)


view : Model -> Html Msg
view model =
    let
        btnText =
            case model.state of
                Running ->
                    "stop"

                Paused ->
                    "start"
    in
        div []
            [ button [ onClick SwitchState ] [ text btnText ]
            , drawGrid model
            ]


cellColor : Model -> Matrix.Location -> String
cellColor model coord =
    case Matrix.get coord model.grid of
        Just x ->
            case x of
                Alive ->
                    "white"

                Empty ->
                    "black"

        Nothing ->
            "black"


getViewBox : Options -> String
getViewBox options =
    let
        side =
            options.cells
                * options.cellSize
                |> toString
    in
        "0 0 " ++ side ++ " " ++ side


drawGrid : Model -> Html Msg
drawGrid model =
    let
        sidePx =
            model.options.cells
                * model.options.cellSize
                |> toString

        row =
            List.range 0 (model.options.cells - 1)
    in
        svg
            [ width sidePx, height sidePx, getViewBox model.options |> viewBox ]
            (List.map
                (drawRow model)
                row
            )


drawRow : Model -> Int -> Svg Msg
drawRow model currY =
    let
        col =
            List.range 0 (model.options.cells - 1)
    in
        g []
            (List.map
                (drawCell model currY)
                col
            )


drawCell : Model -> Int -> Int -> Svg Msg
drawCell model currY currX =
    let
        p =
            Matrix.loc currX currY
    in
        rect
            [ currX * model.options.cellSize |> toString |> x
            , currY * model.options.cellSize |> toString |> y
            , toString model.options.cellSize |> width
            , toString model.options.cellSize |> height
            , cellColor model p |> fill
            , stroke "grey"
            , strokeWidth "2"
            ]
            []
