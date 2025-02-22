INTERFACE zif_openapi_3_1 PUBLIC.

  TYPES:
    " Contact object
    BEGIN OF contact,
      name  TYPE string,
      url   TYPE string,
      email TYPE string,
    END OF contact,

    " License object  
    BEGIN OF license,
      name       TYPE string,
      identifier TYPE string,
      url        TYPE string,
    END OF license,

    " Info object
    BEGIN OF info,
      title            TYPE string,
      summary          TYPE string,
      description      TYPE string,
      terms_of_service TYPE string,
      contact          TYPE contact,
      license          TYPE license,
      version          TYPE string,
    END OF info,

    " Server variable
    BEGIN OF server_variable,
      enum        TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      default     TYPE string,
      description TYPE string,
    END OF server_variable,

    " Server variables map
    BEGIN OF server_variables_map_entry,
      key   TYPE string,
      value TYPE server_variable,
    END OF server_variables_map_entry,
    server_variables_map TYPE STANDARD TABLE OF server_variables_map_entry WITH EMPTY KEY,

    " Server object
    BEGIN OF server,
      url         TYPE string,
      description TYPE string,
      variables   TYPE server_variables_map,
    END OF server,
    servers TYPE STANDARD TABLE OF server WITH EMPTY KEY,

    " Schema object
    BEGIN OF schema,
      type        TYPE string,
      title       TYPE string,
      description TYPE string,
      format      TYPE string,
      pattern     TYPE string,
      minimum     TYPE i,
      maximum     TYPE i,
      enum        TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      items       TYPE REF TO data, "TYPE schema
      properties  TYPE REF TO data, "TYPE schema_map
      required    TYPE STANDARD TABLE OF string WITH EMPTY KEY,
    END OF schema,

    " Schema map
    BEGIN OF schema_map_entry,
      key   TYPE string,
      value TYPE schema,
    END OF schema_map_entry,
    schema_map TYPE STANDARD TABLE OF schema_map_entry WITH EMPTY KEY,

    " Media type
    BEGIN OF media_type,
      schema TYPE schema,
    END OF media_type,

    " Content map
    BEGIN OF content_map_entry,
      key   TYPE string,
      value TYPE media_type,
    END OF content_map_entry,
    content_map TYPE STANDARD TABLE OF content_map_entry WITH EMPTY KEY,

    " Parameter
    BEGIN OF parameter,
      name            TYPE string,
      in              TYPE string,
      description     TYPE string,
      required        TYPE abap_bool,
      deprecated      TYPE abap_bool,
      allow_empty_value TYPE abap_bool,
      style           TYPE string,
      explode        TYPE abap_bool,
      allow_reserved TYPE abap_bool,
      schema         TYPE schema,
      content        TYPE content_map,
    END OF parameter,
    parameters TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,

    " Parameter map
    BEGIN OF parameter_map_entry,
      key   TYPE string,
      value TYPE parameter,
    END OF parameter_map_entry,
    parameter_map TYPE STANDARD TABLE OF parameter_map_entry WITH EMPTY KEY,

    " Response
    BEGIN OF response,
      description TYPE string,
      content     TYPE content_map,
    END OF response,

    " Response map
    BEGIN OF response_map_entry,
      key   TYPE string,
      value TYPE response,
    END OF response_map_entry,
    response_map TYPE STANDARD TABLE OF response_map_entry WITH EMPTY KEY,

    " Request body
    BEGIN OF request_body,
      description TYPE string,
      content     TYPE content_map,
      required    TYPE abap_bool,
    END OF request_body,

    " Operation
    BEGIN OF operation,
      tags         TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      summary      TYPE string,
      description  TYPE string,
      operation_id TYPE string,
      parameters   TYPE parameters,
      request_body TYPE request_body,
      responses    TYPE response_map,
      deprecated   TYPE abap_bool,
      servers      TYPE servers,
    END OF operation,

    " Path item
    BEGIN OF path_item,
      ref         TYPE string,
      summary     TYPE string,
      description TYPE string,
      get         TYPE operation,
      put         TYPE operation,
      post        TYPE operation,
      delete      TYPE operation,
      options     TYPE operation,
      head        TYPE operation,
      patch       TYPE operation,
      trace       TYPE operation,
      servers     TYPE servers,
      parameters  TYPE parameters,
    END OF path_item,

    " Paths map
    BEGIN OF paths_map_entry,
      key   TYPE string,
      value TYPE path_item,
    END OF paths_map_entry,
    paths_map TYPE STANDARD TABLE OF paths_map_entry WITH EMPTY KEY,

    " Components
    BEGIN OF components,
      schemas    TYPE schema_map,
      responses  TYPE response_map,
      parameters TYPE parameter_map,
    END OF components,

    " Security requirement
    BEGIN OF security_requirement_entry,
      key   TYPE string,
      value TYPE STANDARD TABLE OF string WITH EMPTY KEY,
    END OF security_requirement_entry,
    security_requirement TYPE STANDARD TABLE OF security_requirement_entry WITH EMPTY KEY,

    " External docs
    BEGIN OF external_docs,
      description TYPE string,
      url         TYPE string,
    END OF external_docs,

    " Tag
    BEGIN OF tag,
      name         TYPE string,
      description  TYPE string,
      external_docs TYPE external_docs,
    END OF tag,
    tags TYPE STANDARD TABLE OF tag WITH EMPTY KEY,

    " Root OpenAPI object
    BEGIN OF openapi,
      openapi           TYPE string,
      info              TYPE info,
      json_schema_dialect TYPE string,
      servers           TYPE servers,
      paths             TYPE paths_map,
      components        TYPE components,
      security          TYPE STANDARD TABLE OF security_requirement WITH EMPTY KEY,
      tags              TYPE tags,
      external_docs     TYPE external_docs,
    END OF openapi.

ENDINTERFACE.
