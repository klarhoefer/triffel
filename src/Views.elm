module Views exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Shared exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ case model.screen of
            Start -> viewStart model
            Game -> viewGame model
        ]


viewStart : Model -> Html Msg
viewStart model =
    div []
        [ div []
            [ img [ src "Triffel.png", class "triffel-logo" ] []
            ]
        , fieldset []
            [ legend [] [ text "Spielart" ]
            , label []
                [ input [ type_ "radio", name "spielart", checked (model.gameType == Classic), onClick (GameTypeChanged Classic) ] []
                , text "Classic"
                ]
            , label [ class "label-offset" ]
                [ input [ type_ "radio", name "spielart", checked (model.gameType == Seven), onClick (GameTypeChanged Seven) ] []
                , text "Kniffel 7"
                ]
            ]
        , fieldset []
            [ legend [] [ text "Spielregeln" ]
            , label []
                [ input [ type_ "radio", name "spielregeln", checked (model.gameRules == Single), onClick (GameRulesChanged Single) ] []
                , text "Classic"
                ]
            , label [ class "label-offset" ]
                [ input [ type_ "radio", name "spielregeln", checked (model.gameRules == Triffel), onClick (GameRulesChanged Triffel) ] []
                , text "Triffel"
                ]
            ]
        , fieldset []
            [ legend [] [ text "Spieler" ]
            , ul []
                (List.map viewPlayer model.players)
            , input [ onInput PlayerChanged, autofocus True ] []
            , button [ onClick AddPlayer ] [ text "Hinzufügen" ]
            ]
        , div []
            [ button [ class "start-button", onClick StartGame ] [ text "Start" ]
            ]
        ]

viewPlayer : String -> Html Msg
viewPlayer name =
    li []
        [ span [] [ text name ]
        , button [ onClick (RemovePlayer name)] [ text "-" ]
        ]



viewGame : Model -> Html Msg
viewGame _ =
    div []
        []
