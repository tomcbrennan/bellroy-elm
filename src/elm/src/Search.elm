module Search exposing (..)

import Browser
import Html exposing (Html, div, form, input, label)
import Html.Attributes exposing (class, placeholder, type_, value)
import Html.Events exposing (onInput)



-- MAIN

main =
    Browser.sandbox { init = init, update = update, view = view }


-- MODEL

type alias Model =
    { content : String
    }

init : Model
init =
    { content = "" }


-- UPDATE

type Msg
    = Change String

update : Msg -> Model -> Model
update msg model =
    case msg of
        Change newContent ->
            { model | content = newContent }


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "container flex items-center h-full" ]
        [ form [ class "flex items-center w-full h-full" ]
            [ label [ class "search-input-wrapper w-full h-full flex items-center gap-4" ]
                [ input
                    [ type_ "text"
                    , placeholder "What are you looking for?"
                    , class "search-input text-lg lg:text-3xl text-[#333] w-full h-full outline-none"
                    , value model.content
                    , onInput Change
                    ]
                    []
                ]
            ]
        ]
