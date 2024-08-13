module Worker exposing (main)

import Json.Decode as Decode
import Json.Encode
import Platform
import Ports
import ReactRenderable exposing (ReactRenderable(..))
import Schema1



-- Interop with JS


main : Program () () String
main =
    Platform.worker
        { init = always <| ( (), Cmd.none )
        , update = \str _ -> ( (), Ports.sendOutput <| encodeResult ReactRenderable.encoder <| processInput str )
        , subscriptions = always <| Ports.input identity
        }


processInput : String -> Result Decode.Error ReactRenderable
processInput =
    Decode.decodeString Schema1.dbDocumentDecoder >> Result.map Schema1.toReactRenderable


encodeResult : (a -> Json.Encode.Value) -> Result Decode.Error a -> Json.Encode.Value
encodeResult encodeValue r =
    case r of
        Ok a ->
            Json.Encode.object
                [ ( "Ok", encodeValue a ) ]

        Err e ->
            Json.Encode.object
                [ ( "Err", Json.Encode.string <| Decode.errorToString e ) ]
