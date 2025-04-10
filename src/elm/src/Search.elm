port module Search exposing (..)

import Browser
import Html exposing (Html, div, form, input, label, text, span, a)
import Html.Attributes exposing (class, placeholder, type_, value, href)
import Html.Events exposing (onInput)


-- MAIN

main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


-- PORTS

port onCloseSearch : (() -> msg) -> Sub msg


-- MODEL

type alias Model =
    { content : String
    , products : List Product
    }

type alias Product =
    { name : String
    , description : String
    , category : String
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( { content = ""
      , products =
            [Product "All Conditions Backpack" "Durable and weather-resistant backpack for everyday use" "Bags"
            , Product "Slim Wallet" "Minimalist wallet designed to hold all your essentials in a slim form" "Wallets"
            , Product "Tech Kit" "Organising kit to keep your tech essentials neatly stored" "Accessories"
            , Product "Laptop Sleeve" "Sleek sleeve designed to protect your laptop without the bulk" "Laptop Accessories"
            , Product "Phone Case" "Slim, protective case for your smartphone with a minimalist design" "Phone Accessories"
            , Product "Travel Wallet" "Premium wallet designed to keep your travel essentials organised" "Travel Accessories"
            , Product "Sling" "Compact and convenient bag designed for easy access and comfort" "Bags"
            , Product "Key Cover" "Stylish and functional key cover to protect your keys and keep them organised" "Accessories"
            , Product "Classic Backpack" "Timeless and functional backpack with thoughtful storage options" "Bags"
            , Product "Hide & Seek Wallet" "Classic wallet with premium leather and smart compartments for your cards and cash" "Wallets"
            ]
      }
    , Cmd.none
    )


-- UPDATE

type Msg
    = Change String
    | CloseSearch

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Change newContent ->
            ( { model | content = newContent }, Cmd.none )

        CloseSearch ->
            ( { model | content = "" }, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions _ =
    onCloseSearch (\_ -> CloseSearch)


-- VIEW

view : Model -> Html Msg
view model =
    div [ class "container flex items-center w-full h-full" ]
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
        , if model.content /= "" then
            viewResultsModal model
          else
            text ""
        ]


viewResultsModal : Model -> Html Msg
viewResultsModal model =
    let
        lowercaseQuery =
            String.toLower model.content

        matchesQuery product =
            String.contains lowercaseQuery (String.toLower product.name) ||
            String.contains lowercaseQuery (String.toLower product.description) ||
            String.contains lowercaseQuery (String.toLower product.category)

        filteredProducts =
            List.filter matchesQuery model.products
    in
    div
        [ class "results-modal overflow-y-scroll pb-40 lg:pb-14 absolute left-0 top-full bg-white w-full h-auto max-h-[calc(100vh-56px-56px)] lg:max-h-[calc(100vh-105px-105px)]" ]
        [ div [ class "container py-6 lg:py-12" ]
            [ div [ class "block-content" ]
                [ span [ class "is-h2" ] [ text "Are you looking for one of these?" ]
                , div
                    [ class "grid grid-flow-dense gap-1 initial:py-1 grid-cols-2 sm:grid-cols-[repeat(auto-fill,minmax(250px,1fr))] initial:sm:px-1 lg:grid-cols-[repeat(auto-fill,minmax(285px,1fr))] supports-[container-type]:sm:grid-cols-2 supports-[container-type]:sm:@[640px]:grid-cols-[repeat(auto-fill,minmax(250px,1fr))] supports-[container-type]:lg:@[1024px]:grid-cols-[repeat(auto-fill,minmax(285px,1fr))]" ]
                    (List.map viewProductCard filteredProducts)
                , div [ class "flex items-center justify-center w-full" ]
                    [ a [ href "#", class "underline text-sm" ] [ text "View all products" ] ]
                ]
            ]
        ]


viewProductCard : Product -> Html Msg
viewProductCard product =
    div [ class "search-card p-4 rounded m-1" ]
        [ div [ class "search-card-content" ]
            [ div [ class "text-lg font-bold" ] [ text product.name ]
            , div [ class "text-sm text-gray-600" ] [ text product.description ]
            , div [ class "text-xs text-gray-500 mt-2" ] [ text product.category ]
            ]
        ]
