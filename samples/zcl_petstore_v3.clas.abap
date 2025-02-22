CLASS zcl_petstore_v3 DEFINITION PUBLIC ABSTRACT.

    PUBLIC SECTION.
  
      " Static read-only property for the OpenAPI schema
      CLASS-DATA:
        schema TYPE zif_openapi=>open_api READ-ONLY.
  
      " Class constructor
      CLASS-METHODS class_constructor.
  
    PROTECTED SECTION.
  
    PRIVATE SECTION.
  
  ENDCLASS.
  
  CLASS zcl_petstore_v3 IMPLEMENTATION.
  
    METHOD class_constructor.
  
      " Initialize the schema property using inline declarations
      schema = VALUE zif_openapi=>open_api(
        openapi    = '3.1.0'
        info       = VALUE #(
          title          = 'Swagger Petstore'
          summary        = 'A sample API that uses a petstore as an example to demonstrate features in the OpenAPI 3.1 specification'
          description    = 'This is a sample Petstore server.'
          terms_of_service = 'http://swagger.io/terms/'
          contact        = 'apiteam@swagger.io'
          license        = 'Apache 2.0'
          version        = '1.0.0'
        )
        servers    = VALUE #(
          ( url = 'https://petstore3.swagger.io/api/v3' )
        )
        paths      = VALUE #(
          ( key = '/pet'
            value = VALUE #(
              post = VALUE #(
                tags        = VALUE #( ( 'pet' ) )  " Correct ABAP inline table format
                summary     = 'Add a new pet to the store'
                description = ''
                operation_id = 'addPet'
                responses   = VALUE #(
                  ( key = '200'
                    value = VALUE #(
                      description = 'Successful operation'
                    )
                  )
                  ( key = '405'
                    value = VALUE #(
                      description = 'Invalid input'
                    )
                  )
                )
              )
            )
          )
          ( key = '/pet/{petId}'
            value = VALUE #(
              get = VALUE #(
                tags        = VALUE #( ( 'pet' ) )  " Correct ABAP inline table format
                summary     = 'Find pet by ID'
                description = 'Returns a single pet'
                operation_id = 'getPetById'
                responses   = VALUE #(
                  ( key = '200'
                    value = VALUE #(
                      description = 'successful operation'
                    )
                  )
                  ( key = '400'
                    value = VALUE #(
                      description = 'Invalid ID supplied'
                    )
                  )
                  ( key = '404'
                    value = VALUE #(
                      description = 'Pet not found'
                    )
                  )
                )
              )
            )
          )
        )
        components = VALUE #(
          schemas = VALUE #(
            ( key = 'Pet'
              value = VALUE #(
                type        = 'object'
                title       = 'Pet'
                description = 'A pet for sale in the pet store'
              )
            )
          )
        )
        tags       = VALUE #(
          ( name = 'pet'
            description = 'Everything about your Pets'
          )
        )
      ).
  
    ENDMETHOD.
  
  ENDCLASS.
  