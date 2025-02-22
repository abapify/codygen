CLASS zcl_petstore_v3 DEFINITION PUBLIC ABSTRACT.
  PUBLIC SECTION.
    CLASS-DATA schema TYPE zif_openapi_3_0=>root READ-ONLY.
    CLASS-METHODS class_constructor.
ENDCLASS.

CLASS zcl_petstore_v3 IMPLEMENTATION.
  METHOD class_constructor.
    schema = VALUE #(
      openapi = '3.0.2'
      info = VALUE #(
        title = 'Swagger Petstore - OpenAPI 3.0'
        description = 'This is a sample Pet Store Server based on the OpenAPI 3.0 specification.'
        terms_of_service = 'http://swagger.io/terms/'
        contact = VALUE #(
          email = 'apiteam@swagger.io'
        )
        license = VALUE #(
          name = 'Apache 2.0'
          url = 'http://www.apache.org/licenses/LICENSE-2.0.html'
        )
        version = '1.0.19'
      )
      servers = VALUE #(
        ( url = '/api/v3' )
      )
      tags = VALUE #(
        ( name = 'pet'
          description = 'Everything about your Pets'
          external_docs = VALUE #(
            description = 'Find out more'
            url = 'http://swagger.io'
          )
        )
        ( name = 'store'
          description = 'Access to Petstore orders'
          external_docs = VALUE #(
            description = 'Find out more about our store'
            url = 'http://swagger.io'
          )
        )
        ( name = 'user'
          description = 'Operations about user'
        )
      )
      paths = VALUE #(
        ( key = '/pet'
          value = VALUE #(
            put = VALUE #(
              tags = VALUE #( ( `pet` ) )
              summary = 'Update an existing pet'
              description = 'Update an existing pet by Id'
              operation_id = 'updatePet'
              responses = VALUE #(
                ( key = '200'
                  value = VALUE #(
                    description = 'Successful operation'
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
                ( key = '405'
                  value = VALUE #(
                    description = 'Validation exception'
                  )
                )
              )
            )
            post = VALUE #(
              tags = VALUE #( ( `pet` ) )
              summary = 'Add a new pet to the store'
              description = 'Add a new pet to the store'
              operation_id = 'addPet'
              responses = VALUE #(
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
        ( key = '/pet/findByStatus'
          value = VALUE #(
            get = VALUE #(
              tags = VALUE #( ( `pet` ) )
              summary = 'Finds Pets by status'
              description = 'Multiple status values can be provided with comma separated strings'
              operation_id = 'findPetsByStatus'
              parameters = VALUE #(
                ( name = 'status'
                  in = 'query'
                  description = 'Status values that need to be considered for filter'
                  required = abap_false
                  schema = VALUE #(
                    type = 'string'
                    enum = VALUE #( ( `available` ) ( `pending` ) ( `sold` ) )
                    default = 'available'
                  )
                )
              )
              responses = VALUE #(
                ( key = '200'
                  value = VALUE #(
                    description = 'successful operation'
                  )
                )
                ( key = '400'
                  value = VALUE #(
                    description = 'Invalid status value'
                  )
                )
              )
            )
          )
        )
      )
      components = VALUE #(
        schemas = VALUE #(
          ( key = 'Order'
            value = VALUE #(
              type = 'object'
              properties = NEW zif_openapi_3_0=>schema_map(
                ( key = 'id' value = VALUE #( type = 'integer' format = 'int64' example = '10' ) )
                ( key = 'petId' value = VALUE #( type = 'integer' format = 'int64' example = '198772' ) )
                ( key = 'quantity' value = VALUE #( type = 'integer' format = 'int32' example = '7' ) )
                ( key = 'shipDate' value = VALUE #( type = 'string' format = 'date-time' ) )
                ( key = 'status' value = VALUE #(
                    type = 'string'
                    description = 'Order Status'
                    enum = VALUE #( ( `placed` ) ( `approved` ) ( `delivered` ) )
                    example = 'approved'
                  ) )
                ( key = 'complete' value = VALUE #( type = 'boolean' ) )
              )
            )
          )
          ( key = 'Customer'
            value = VALUE #(
              type = 'object'
              properties = NEW zif_openapi_3_0=>schema_map(
                ( key = 'id' value = VALUE #( type = 'integer' format = 'int64' example = '100000' ) )
                ( key = 'username' value = VALUE #( type = 'string' example = 'fehguy' ) )
              )
            )
          )
        )
      )
    ).
  ENDMETHOD.
ENDCLASS.
