" This interface models the OpenAPI 3.1 specification in ABAP.
" It uses snake_case for field names, *_map for dictionary-like fields,
" and standard tables for array-like fields.

INTERFACE zif_openapi PUBLIC.

" Info object (OpenAPI info)
TYPES: BEGIN OF info,
        "! Title of the API
        title            TYPE string,
        "! Short summary of the API
        summary          TYPE string,
        "! Description of the API
        description      TYPE string,
        "! Terms of Service URL
        terms_of_service TYPE string,
        "! Contact information for the API
        contact          TYPE string,
        "! License information for the API
        license          TYPE string,
        "! Version of the API
        version          TYPE string,
      END OF info.

" ServerVariable and server variables map
TYPES: BEGIN OF server_variable,
        "! Default value to use for substitution
        default      TYPE string,
        "! Description of this variable
        description  TYPE string,
        "! Possible enumeration of values for this variable
        enum         TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      END OF server_variable.
TYPES: BEGIN OF server_variables_map_entry,
        key   TYPE string,
        value TYPE server_variable,
      END OF server_variables_map_entry.
TYPES: server_variables_map TYPE STANDARD TABLE OF server_variables_map_entry WITH EMPTY KEY.

" Server object (OpenAPI server)
TYPES: BEGIN OF server,
        "! A URL to the target host
        url         TYPE string,
        "! Description of the server
        description TYPE string,
        "! A map between variable names and their values
        variables   TYPE server_variables_map,
      END OF server.
TYPES: servers TYPE STANDARD TABLE OF server WITH EMPTY KEY.

" Parameter object
TYPES: BEGIN OF parameter,
        "! Parameter name
        name          TYPE string,
        "! Parameter location: path, query, header, or cookie
        in            TYPE string,
        "! Parameter description
        description   TYPE string,
        "! Whether this parameter is required
        required      TYPE abap_bool,
        "! Whether reserved characters are allowed
        allow_reserved TYPE abap_bool,
        "! Schema reference or inline schema details
        schema_ref    TYPE string,
      END OF parameter.
TYPES: parameters TYPE STANDARD TABLE OF parameter WITH EMPTY KEY.

" Response object
TYPES: BEGIN OF response,
        "! Description of this response
        description TYPE string,
      END OF response.

" Map from status code or 'default' to a response
TYPES: BEGIN OF responses_map_entry,
        key   TYPE string,
        value TYPE response,
      END OF responses_map_entry.
TYPES: responses_map TYPE STANDARD TABLE OF responses_map_entry WITH EMPTY KEY.

" Operation object
TYPES: BEGIN OF operation,
        "! List of tags
        tags          TYPE STANDARD TABLE OF string WITH EMPTY KEY,
        "! Short summary of the operation
        summary       TYPE string,
        "! Long description of the operation
        description   TYPE string,
        "! Unique identifier for the operation
        operation_id  TYPE string,
        "! List of applicable parameters
        parameters    TYPE parameters,
        "! Map of status code → response
        responses     TYPE responses_map,
      END OF operation.

" PathItem object (uses explicit fields for each HTTP method)
TYPES: BEGIN OF path_item,
        "! Reference to another path item
        ref         TYPE string,
        "! Short summary of the path
        summary     TYPE string,
        "! Description of the path
        description TYPE string,
        "! List of servers applicable to this path
        servers     TYPE servers,
        "! List of applicable parameters
        parameters  TYPE parameters,
        "! HTTP method: GET
        get         TYPE operation,
        "! HTTP method: PUT
        put         TYPE operation,
        "! HTTP method: POST
        post        TYPE operation,
        "! HTTP method: DELETE
        delete      TYPE operation,
        "! HTTP method: OPTIONS
        options     TYPE operation,
        "! HTTP method: HEAD
        head        TYPE operation,
        "! HTTP method: PATCH
        patch       TYPE operation,
        "! HTTP method: TRACE
        trace       TYPE operation,
      END OF path_item.

" Map of path-string → path_item
TYPES: BEGIN OF path_map_entry,
        key   TYPE string,
        value TYPE path_item,
      END OF path_map_entry.
TYPES: path_map TYPE STANDARD TABLE OF path_map_entry WITH EMPTY KEY.

" Webhooks (like paths) is also a map of name → path_item
TYPES: BEGIN OF webhook_map_entry,
        key   TYPE string,
        value TYPE path_item,
      END OF webhook_map_entry.
TYPES: webhook_map TYPE STANDARD TABLE OF webhook_map_entry WITH EMPTY KEY.

" Schema object (highly simplified)
TYPES: BEGIN OF schema,
        "! Type of the schema (object, string, array, etc.)
        type        TYPE string,
        "! Title of the schema
        title       TYPE string,
        "! Description of the schema
        description TYPE string,
      END OF schema.

" Map of schema_name → schema
TYPES: BEGIN OF schemas_map_entry,
        key   TYPE string,
        value TYPE schema,
      END OF schemas_map_entry.
TYPES: schemas_map TYPE STANDARD TABLE OF schemas_map_entry WITH EMPTY KEY.

" Additional maps for responses, parameters, etc. used inside components
TYPES: BEGIN OF responses_map_entry2,
        key   TYPE string,
        value TYPE response,
      END OF responses_map_entry2.
TYPES: responses_map_in_components TYPE STANDARD TABLE OF responses_map_entry2 WITH EMPTY KEY.

TYPES: BEGIN OF parameters_map_entry,
        key   TYPE string,
        value TYPE parameter,
      END OF parameters_map_entry.
TYPES: parameters_map TYPE STANDARD TABLE OF parameters_map_entry WITH EMPTY KEY.

" Components object
TYPES: BEGIN OF components,
        "! Reusable schemas
        schemas    TYPE schemas_map,
        "! Reusable responses
        responses  TYPE responses_map_in_components,
        "! Reusable parameters
        parameters TYPE parameters_map,
      END OF components.

" Security requirement: map of scheme name → list of scopes
TYPES: BEGIN OF security_req_entry,
        key   TYPE string,
        value TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      END OF security_req_entry.
TYPES: security_requirement TYPE STANDARD TABLE OF security_req_entry WITH EMPTY KEY.
TYPES: security TYPE STANDARD TABLE OF security_requirement WITH EMPTY KEY.

" Tag object
TYPES: BEGIN OF external_docs,
        "! Description of the external documentation
        description TYPE string,
        "! URL to the external documentation
        url         TYPE string,
      END OF external_docs.
TYPES: BEGIN OF tag,
        "! Name of the tag
        name        TYPE string,
        "! Description of the tag
        description TYPE string,
        externaldocs TYPE external_docs,
      END OF tag.
TYPES: tags TYPE STANDARD TABLE OF tag WITH EMPTY KEY.

" The root open_api object
TYPES: BEGIN OF open_api,
        "! Version of the OpenAPI spec
        openapi    TYPE string,
        "! Metadata about the API
        info       TYPE info,
        "! Array of Server objects
        servers    TYPE servers,
        "! Map of paths to path_items
        paths      TYPE path_map,
        "! Map of webhooks
        webhooks   TYPE webhook_map,
        "! Reusable components
        components TYPE components,
        "! Security requirements
        security   TYPE security,
        "! A list of tags for documentation
        tags       TYPE tags,
        externaldocs TYPE external_docs,
      END OF open_api.

ENDINTERFACE.