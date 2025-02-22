INTERFACE zif_openapi_3_0 PUBLIC.

  TYPES:
    " XML object
    BEGIN OF xml,
      name      TYPE string,
      namespace TYPE string,
      prefix    TYPE string,
      attribute TYPE abap_bool,
      wrapped   TYPE abap_bool,
    END OF xml,

    " Contact object
    BEGIN OF contact,
      name  TYPE string,
      url   TYPE string,
      email TYPE string,
    END OF contact,

    " License object  
    BEGIN OF license,
      name TYPE string,
      url  TYPE string,
    END OF license,

    " Info object
    BEGIN OF info,
      title            TYPE string,
      description      TYPE string,
      terms_of_service TYPE string,
      contact          TYPE contact,
      license          TYPE license,
      version         TYPE string,
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

    " External docs
    BEGIN OF external_docs,
      description TYPE string,
      url         TYPE string,
    END OF external_docs,

    " Discriminator
    BEGIN OF discriminator,
      property_name TYPE string,
      mapping      TYPE STANDARD TABLE OF string WITH EMPTY KEY,
    END OF discriminator,

    " Schema object
    BEGIN OF schema,
      title              TYPE string,
      multiple_of        TYPE f,
      maximum           TYPE f,
      exclusive_maximum TYPE abap_bool,
      minimum           TYPE f,
      exclusive_minimum TYPE abap_bool,
      max_length        TYPE i,
      min_length        TYPE i,
      pattern           TYPE string,
      max_items         TYPE i,
      min_items         TYPE i,
      unique_items      TYPE abap_bool,
      max_properties    TYPE i,
      min_properties    TYPE i,
      required          TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      enum             TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      type             TYPE string,
      all_of           TYPE STANDARD TABLE OF REF TO data WITH EMPTY KEY, "schema
      one_of           TYPE STANDARD TABLE OF REF TO data WITH EMPTY KEY, "schema  
      any_of           TYPE STANDARD TABLE OF REF TO data WITH EMPTY KEY, "schema
      not              TYPE REF TO data, "schema
      items            TYPE REF TO data, "schema
      properties       TYPE REF TO data, "schema_map
      description      TYPE string,
      format           TYPE string,
      default          TYPE string,
      nullable         TYPE abap_bool,
      discriminator    TYPE discriminator,
      read_only        TYPE abap_bool,
      write_only       TYPE abap_bool,
      xml              TYPE xml,
      external_docs    TYPE external_docs,
      example          TYPE string,
      deprecated       TYPE abap_bool,
    END OF schema,

    " Schema map
    BEGIN OF schema_map_entry,
      key   TYPE string,
      value TYPE schema,
    END OF schema_map_entry,
    schema_map TYPE STANDARD TABLE OF schema_map_entry WITH EMPTY KEY,

    " Example object
    BEGIN OF example,
      summary        TYPE string,
      description    TYPE string,
      value         TYPE string,
      external_value TYPE string,
    END OF example,

    " Example map
    BEGIN OF example_map_entry,
      key   TYPE string,
      value TYPE example,
    END OF example_map_entry,
    example_map TYPE STANDARD TABLE OF example_map_entry WITH EMPTY KEY,

    " Encoding object
    BEGIN OF encoding,
      content_type   TYPE string,
      headers        TYPE REF TO data, "header_map
      style         TYPE string,
      explode       TYPE abap_bool,
      allow_reserved TYPE abap_bool,
    END OF encoding,

    " Encoding map
    BEGIN OF encoding_map_entry,
      key   TYPE string,
      value TYPE encoding,
    END OF encoding_map_entry,
    encoding_map TYPE STANDARD TABLE OF encoding_map_entry WITH EMPTY KEY,

    " Media type
    BEGIN OF media_type,
      schema    TYPE schema,
      example   TYPE string,
      examples  TYPE example_map,
      encoding  TYPE encoding_map,
    END OF media_type,

    " Media type map
    BEGIN OF media_type_map_entry,
      key   TYPE string,
      value TYPE media_type,
    END OF media_type_map_entry,
    media_type_map TYPE STANDARD TABLE OF media_type_map_entry WITH EMPTY KEY,

    " Header
    BEGIN OF header,
      description     TYPE string,
      required        TYPE abap_bool,
      deprecated      TYPE abap_bool,
      allow_empty_value TYPE abap_bool,
      style           TYPE string,
      explode         TYPE abap_bool,
      allow_reserved   TYPE abap_bool,
      schema          TYPE schema,
      example         TYPE string,
      examples        TYPE example_map,
      content         TYPE media_type_map,
    END OF header,

    " Header map
    BEGIN OF header_map_entry,
      key   TYPE string,
      value TYPE header,
    END OF header_map_entry,
    header_map TYPE STANDARD TABLE OF header_map_entry WITH EMPTY KEY,

    " Link
    BEGIN OF link,
      operation_id  TYPE string,
      operation_ref TYPE string,
      parameters    TYPE string,
      request_body  TYPE string,
      description   TYPE string,
      server        TYPE server,
    END OF link,

    " Link map
    BEGIN OF link_map_entry,
      key   TYPE string,
      value TYPE link,
    END OF link_map_entry,
    link_map TYPE STANDARD TABLE OF link_map_entry WITH EMPTY KEY,

    " Response
    BEGIN OF response,
      description TYPE string,
      headers     TYPE header_map,
      content     TYPE media_type_map,
      links       TYPE link_map,
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
      content     TYPE media_type_map,
      required    TYPE abap_bool,
    END OF request_body,

    " Parameter
    BEGIN OF parameter,
      name              TYPE string,
      in                TYPE string,
      description       TYPE string,
      required          TYPE abap_bool,
      deprecated        TYPE abap_bool,
      allow_empty_value TYPE abap_bool,
      style             TYPE string,
      explode           TYPE abap_bool,
      allow_reserved    TYPE abap_bool,
      schema            TYPE schema,
      example           TYPE string,
      examples          TYPE example_map,
      content           TYPE media_type_map,
    END OF parameter,

    " Operation
    BEGIN OF operation,
      tags         TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      summary      TYPE string,
      description  TYPE string,
      external_docs TYPE external_docs,
      operation_id TYPE string,
      parameters   TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,
      request_body TYPE request_body,
      responses    TYPE response_map,
      deprecated   TYPE abap_bool,
      security     TYPE REF TO data, "security_requirement
      servers      TYPE STANDARD TABLE OF server WITH EMPTY KEY,
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
      servers     TYPE STANDARD TABLE OF server WITH EMPTY KEY,
      parameters  TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,
    END OF path_item,

    " Paths
    BEGIN OF paths_map_entry,
      key   TYPE string,
      value TYPE path_item,
    END OF paths_map_entry,
    paths_map TYPE STANDARD TABLE OF paths_map_entry WITH EMPTY KEY,

    " Components
    BEGIN OF components,
      schemas         TYPE schema_map,
      responses       TYPE response_map,
      parameters      TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,
      examples        TYPE example_map,
      request_bodies  TYPE REF TO data, "request_body_map
      headers         TYPE header_map,
      security_schemes TYPE REF TO data, "security_scheme_map
      links           TYPE link_map,
    END OF components,

    " Security requirement
    BEGIN OF security_requirement_entry,
      key   TYPE string,
      value TYPE STANDARD TABLE OF string WITH EMPTY KEY,
    END OF security_requirement_entry,
    security_requirement TYPE STANDARD TABLE OF security_requirement_entry WITH EMPTY KEY,

    " Tag
    BEGIN OF tag,
      name         TYPE string,
      description  TYPE string,
      external_docs TYPE external_docs,
    END OF tag,

    " Root object
    BEGIN OF root,
      openapi      TYPE string,
      info         TYPE info,
      servers      TYPE STANDARD TABLE OF server WITH EMPTY KEY,
      paths        TYPE paths_map,
      components   TYPE components,
      security     TYPE STANDARD TABLE OF security_requirement WITH EMPTY KEY,
      tags         TYPE STANDARD TABLE OF tag WITH EMPTY KEY,
      external_docs TYPE external_docs,
    END OF root.

ENDINTERFACE.
