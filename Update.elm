module Update exposing (..)

import Navigation exposing (Location)


--

import Model exposing (Model)
import Router exposing (screenFromLocation)
import First.Update
import Second.Update
import Third.Update


type Msg
    = Reset
    | ChangeLocation Location
    | FirstEvent First.Update.Msg
    | SecondEvent Second.Update.Msg
    | ThirdEvent Third.Update.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeLocation location ->
            { model | screen = screenFromLocation location } ! []

        FirstEvent e ->
            wrapScreen FirstEvent <| First.Update.update e model

        SecondEvent e ->
            wrapScreen SecondEvent <| Second.Update.update e model

        ThirdEvent e ->
            wrapScreen ThirdEvent <| Third.Update.update e model

        _ ->
            model ! []


wrapScreen : (msg -> Msg) -> ( Model, Cmd msg ) -> ( Model, Cmd Msg )
wrapScreen toMsg ( model, cmd ) =
    ( model, Cmd.map toMsg cmd )
