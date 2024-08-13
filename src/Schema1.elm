module Schema1 exposing (main, result)

import Html exposing (Html, text)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (required)
import Result



-- Example


exampleData : String
exampleData =
    """
    {
        "name": "John Doe",
        "age": 30,
        "dogName": "Rex",
        "isDogOwner": true
    }
    """


result : Result Decode.Error ReactRenderable
result =
    Decode.decodeString dbDocumentDecoder exampleData
        |> Result.map toReactRenderable


main : Html msg
main =
    text "Hello"



-- Not editable by support engineer


type ReactRenderable
    = Int { name : String, value : Int }
    | String { name : String, value : String }
    | BoolValue { name : String, value : Bool }
    | Nested (List ReactRenderable)



-- Editable by support engineer:
--
-- Required to be implemented: DbDocument, dbDocumentDecoder, toReactRenderable


type alias DbDocument =
    { name : String
    , age : Int
    , dogName : String
    , isDogOwner : Bool
    }


dbDocumentDecoder : Decoder DbDocument
dbDocumentDecoder =
    Decode.succeed DbDocument
        |> required "name" Decode.string
        |> required "age" Decode.int
        |> required "dogName" Decode.string
        |> required "isDogOwner" Decode.bool


toReactRenderable : DbDocument -> ReactRenderable
toReactRenderable doc =
    Nested
        [ String { name = "Name", value = doc.name }
        , Int { name = "Age", value = doc.age }
        , String { name = "Dog Name", value = doc.dogName }
        ]
