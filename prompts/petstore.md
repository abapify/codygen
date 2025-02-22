# Describe Petstore schema in ABAP

Task: generate ZCL_PETSTORE_V3 class for the given in the context spec where version is the version of the spec.

Spec: specs/petstore/petstore3.json

- class is abstract
- it has only static attribute schema of type zif_openapi_3_0=>schema
- schema is initialized in the class constructor
- schema is initialized only with one value #( ... ) statment including all nested structures and tables
- describe everything possible presented in schema using abap

## Supported operations

Pet Operations:

addPet: Add a new pet to the store.
updatePet: Update an existing pet.
findPetsByStatus: Find pets by status.
findPetsByTags: Find pets by tags.
getPetById: Find pet by ID.
updatePetWithForm: Update a pet in the store with form data.
deletePet: Delete a pet.
uploadFile: Upload an image.
Store Operations:

getInventory: Returns pet inventories by status.
placeOrder: Place an order for a pet.
getOrderById: Find purchase order by ID.
deleteOrder: Delete purchase order by ID.
User Operations:

createUser: Create a user.
createUsersWithArrayInput: Create users with an array input.
createUsersWithListInput: Create users with a list input.
loginUser: Logs user into the system.
logoutUser: Logs out current logged-in user.
getUserByName: Get user by username.
updateUser: Update user.
deleteUser: Delete use

# Cyclic dependencies resoltuion

If you see something like this in a context:

```
not              TYPE REF TO data, "schema
      items            TYPE REF TO data, "schema
      properties       TYPE REF TO data, "schema_map
```

It means that in your class you need to use new zif_openapi_3_0=>schema( ) instead of value #( ). Please follow the type from a comment For example:

```
  components = VALUE #(
        schemas = VALUE #(
          ( key = 'Order'
            value = VALUE #(
              type = 'object'
              properties = NEW zif_openapi_3_0=>schema_map(
                ( key = 'id' value = value #( type = 'integer' format = 'int64' example = 10 )  )
                ( key = 'petId' value = value #( type = 'integer' format = 'int64' example = 198772  )  )
              )  "schema_map
            )
          )
```

please notice schema_map here - is the type which is supposed to be used here. In another place the type might be different and it's mentioned in a comment in the interface.
