import Html exposing (Html, button, div, text, input, label)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { message : String
  , sendButton : SendMessage
  }

type SendMessage
    = NotDone
    | Error String
    | Sended String

-- UPDATE


type Msg
    = Message String
    | Submit


model : Model
model = { message = "", sendButton = NotDone }

update : Msg -> Model -> Model
update action model =
  case action of
    Message message ->
      { model | message = message }

    Submit ->
      { model | sendButton = validate model}

validate : Model -> SendMessage
validate model =
  if (String.length model.message) < 1 then
        Error "Please enter a message"
  else
        Sended model.message

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ label [ for "message-box" ] [ text "Entrez un message" ]
    , input [ id "message-box", type_ "text", placeholder "Message", onInput Message ] []
    , button [ onClick Submit ] [ text "submit" ]
    , viewValidation model
    ]

viewValidation : Model -> Html msg
viewValidation model = 
  let
    (color, message) =
      case model.sendButton of
        NotDone -> ("", "")
        Error message -> ("red", message)
        Sended message -> ("green", message)
  in
    div [ style [("color", color)] ] [ text message ]