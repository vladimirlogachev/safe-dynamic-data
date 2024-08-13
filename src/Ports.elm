port module Ports exposing (..)

import Json.Encode


port input : (String -> msg) -> Sub msg


port sendOutput : Json.Encode.Value -> Cmd msg
