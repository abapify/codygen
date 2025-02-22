# Generate ABAP interface from the OpenAPI specification

Task: create interface `ZIF_OPENAPI_{VERSION}` for the given in the context spec where versuon is the version of the spec.

Requirements:

- fully featured schema deep type which can be used to descipe openapi schema in ABAP
- object - is a structure
- array - is a table with empty key
- no cyclic dependencies, those fields are commented out
- since we cannot use polymorphism in table types, merge all schemas into one when required
- do not use any prefixes or suffixes like ts\_
- for table types use tt\_ however do not define table types if you can define them in-place ( type table of ... with empty key)

## Handling maps (additionalProperties)

In openapi spec we might see definitions like this:

```
      responses:
        type: object
        additionalProperties:
          $ref: '#/$defs/response-or-reference'
```

In ABAP we need to represent it as an array with key and value properties

- to be able to determine if it's a map array and it should be trasnformed to the object during serialization we will use type which must end with \_map suffix
- please follow the sample zif_openapi from the context

## Cyclic dependencies

For cyclic dependencies we will use the following approach:

- define the property as ref to data
- comment what should be the type of the data for the reference
- if the dependency is not cyclic - please still do use the normal `type entity_type_map`

## Handling $ symbol

- For schema columns which are named with $ symbol we will replace it with \_

## Handling polymorphism

In case of polymorphism ( `oneOf`, `allOf`, `anyOf` ) please construct a shared type which is a union of all possible types.
