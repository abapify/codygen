INTERFACE zif_openapi_3_0 PUBLIC.

  TYPES:
    " Reference object
    BEGIN OF reference,
      _ref TYPE string,
    END OF reference.

  TYPES:
    BEGIN OF xml,
      name TYPE string,
      namespace TYPE string,
      prefix TYPE string,
      attribute TYPE abap_bool,
      wrapped TYPE abap_bool,
    END OF xml.

  TYPES:
    BEGIN OF discriminator,
      property_name TYPE string,
      mapping TYPE string, "TODO: should be map
    END OF discriminator.

  TYPES:
    BEGIN OF schema,
      title TYPE string,
      multiple_of TYPE f,
      maximum TYPE f,
      exclusive_maximum TYPE abap_bool,
      minimum TYPE f, 
      exclusive_minimum TYPE abap_bool,
      max_length TYPE i,
      min_length TYPE i,
      pattern TYPE string,
      max_items TYPE i,
      min_items TYPE i,
      unique_items TYPE abap_bool,
      max_properties TYPE i,
      min_properties TYPE i,
      required TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      enum TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      type TYPE string,
      all_of TYPE REF TO data, "table of schema
      one_of TYPE REF TO data, "table of schema  
      any_of TYPE REF TO data, "table of schema
      not TYPE REF TO data, "schema
      items TYPE REF TO data, "schema
      properties TYPE REF TO data, "schema_map
      additional_properties TYPE REF TO data, "schema
      description TYPE string,
      format TYPE string,
      default TYPE string,
      nullable TYPE abap_bool,
      discriminator TYPE discriminator,
      read_only TYPE abap_bool,
      write_only TYPE abap_bool,
      xml TYPE xml,
      external_docs TYPE REF TO data, "external_documentation
      example TYPE string,
      deprecated TYPE abap_bool,
    END OF schema.

  TYPES:
    BEGIN OF schema_map_entry,
      key TYPE string,
      value TYPE schema,
    END OF schema_map_entry,
    schema_map TYPE STANDARD TABLE OF schema_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF external_documentation,
      description TYPE string,
      url TYPE string,
    END OF external_documentation.

  TYPES:
    BEGIN OF example,
      summary TYPE string,
      description TYPE string,
      value TYPE string,
      external_value TYPE string,
    END OF example.

  TYPES:
    BEGIN OF example_map_entry,
      key TYPE string,
      value TYPE example,
    END OF example_map_entry,
    example_map TYPE STANDARD TABLE OF example_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF encoding,
      content_type TYPE string,
      headers TYPE REF TO data, "header_map
      style TYPE string,
      explode TYPE abap_bool,
      allow_reserved TYPE abap_bool,
    END OF encoding.

  TYPES:
    BEGIN OF encoding_map_entry,
      key TYPE string,
      value TYPE encoding,
    END OF encoding_map_entry,
    encoding_map TYPE STANDARD TABLE OF encoding_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF media_type,
      schema TYPE schema,
      example TYPE string,
      examples TYPE example_map,
      encoding TYPE encoding_map,
    END OF media_type.

  TYPES:
    BEGIN OF media_type_map_entry,
      key TYPE string,
      value TYPE media_type,
    END OF media_type_map_entry,
    media_type_map TYPE STANDARD TABLE OF media_type_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF header,
      description TYPE string,
      required TYPE abap_bool,
      deprecated TYPE abap_bool,
      allow_empty_value TYPE abap_bool,
      style TYPE string,
      explode TYPE abap_bool,
      allow_reserved TYPE abap_bool,
      schema TYPE schema,
      example TYPE string,
      examples TYPE example_map,
      content TYPE media_type_map,
    END OF header.

  TYPES:
    BEGIN OF header_map_entry,
      key TYPE string,
      value TYPE header,
    END OF header_map_entry,
    header_map TYPE STANDARD TABLE OF header_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF link,
      operation_id TYPE string,
      operation_ref TYPE string,
      parameters TYPE string, "TODO: map
      request_body TYPE string,
      description TYPE string,
      server TYPE REF TO data, "server
    END OF link.

  TYPES:
    BEGIN OF link_map_entry,
      key TYPE string,
      value TYPE link,
    END OF link_map_entry,
    link_map TYPE STANDARD TABLE OF link_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF response,
      description TYPE string,
      headers TYPE header_map,
      content TYPE media_type_map,
      links TYPE link_map,
    END OF response.

  TYPES:
    BEGIN OF response_map_entry,
      key TYPE string,
      value TYPE response,
    END OF response_map_entry,
    response_map TYPE STANDARD TABLE OF response_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF request_body,
      description TYPE string,
      content TYPE media_type_map,
      required TYPE abap_bool,
    END OF request_body.

  TYPES:
    BEGIN OF parameter,
      name TYPE string,
      in TYPE string,
      description TYPE string,
      required TYPE abap_bool,
      deprecated TYPE abap_bool,
      allow_empty_value TYPE abap_bool,
      style TYPE string,
      explode TYPE abap_bool,
      allow_reserved TYPE abap_bool,
      schema TYPE schema,
      example TYPE string,
      examples TYPE example_map,
      content TYPE media_type_map,
    END OF parameter.

  TYPES:
    BEGIN OF parameter_map_entry,
      key TYPE string,
      value TYPE parameter,
    END OF parameter_map_entry,
    parameter_map TYPE STANDARD TABLE OF parameter_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF operation,
      tags TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      summary TYPE string,
      description TYPE string,
      external_docs TYPE external_documentation,
      operation_id TYPE string,
      parameters TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,
      request_body TYPE request_body,
      responses TYPE response_map,
      callbacks TYPE REF TO data, "callback_map
      deprecated TYPE abap_bool,
      security TYPE REF TO data, "security_requirement
      servers TYPE REF TO data, "server table
    END OF operation.

  TYPES:
    BEGIN OF path_item,
      _ref TYPE string,
      summary TYPE string,
      description TYPE string,
      get TYPE operation,
      put TYPE operation,
      post TYPE operation,
      delete TYPE operation,
      options TYPE operation,
      head TYPE operation,
      patch TYPE operation,
      trace TYPE operation,
      servers TYPE REF TO data, "server table
      parameters TYPE STANDARD TABLE OF parameter WITH EMPTY KEY,
    END OF path_item.

  TYPES:
    BEGIN OF path_map_entry,
      key TYPE string,
      value TYPE path_item,
    END OF path_map_entry,
    path_map TYPE STANDARD TABLE OF path_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF server_variable,
      enum TYPE STANDARD TABLE OF string WITH EMPTY KEY,
      default TYPE string,
      description TYPE string,
    END OF server_variable.

  TYPES:
    BEGIN OF server_variable_map_entry,
      key TYPE string,
      value TYPE server_variable,
    END OF server_variable_map_entry,
    server_variable_map TYPE STANDARD TABLE OF server_variable_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF server,
      url TYPE string,
      description TYPE string,
      variables TYPE server_variable_map,
    END OF server.

  TYPES:
    BEGIN OF oauth_flows,
      implicit TYPE REF TO data, "oauth_flow
      password TYPE REF TO data, "oauth_flow
      client_credentials TYPE REF TO data, "oauth_flow
      authorization_code TYPE REF TO data, "oauth_flow
    END OF oauth_flows.

  TYPES:
    BEGIN OF security_scheme,
      type TYPE string,
      description TYPE string,
      name TYPE string,
      in TYPE string,
      scheme TYPE string,
      bearer_format TYPE string,
      flows TYPE oauth_flows,
      open_id_connect_url TYPE string,
    END OF security_scheme.

  TYPES:
    BEGIN OF security_scheme_map_entry,
      key TYPE string,
      value TYPE security_scheme,
    END OF security_scheme_map_entry,
    security_scheme_map TYPE STANDARD TABLE OF security_scheme_map_entry WITH EMPTY KEY.

  TYPES:
    BEGIN OF components,
      schemas TYPE schema_map,
      responses TYPE response_map,
      parameters TYPE parameter_map,
      examples TYPE example_map,
      request_bodies TYPE REF TO data, "request_body_map
      headers TYPE header_map,
      security_schemes TYPE security_scheme_map,
      links TYPE link_map,
      callbacks TYPE REF TO data, "callback_map
    END OF components.

  TYPES:
    BEGIN OF tag,
      name TYPE string,
      description TYPE string,
      external_docs TYPE external_documentation,
    END OF tag.

  TYPES:
    BEGIN OF contact,
      name TYPE string,
      url TYPE string,
      email TYPE string,
    END OF contact.

  TYPES:
    BEGIN OF license,
      name TYPE string,
      url TYPE string,
    END OF license.

  TYPES:
    BEGIN OF info,
      title TYPE string,
      description TYPE string,
      terms_of_service TYPE string,
      contact TYPE contact,
      license TYPE license,
      version TYPE string,
    END OF info.

  TYPES:
    BEGIN OF openapi,
      openapi TYPE string,
      info TYPE info,
      external_docs TYPE external_documentation,
      servers TYPE STANDARD TABLE OF server WITH EMPTY KEY,
      security TYPE REF TO data, "security_requirement
      tags TYPE STANDARD TABLE OF tag WITH EMPTY KEY,
      paths TYPE path_map,
      components TYPE components,
    END OF openapi.

ENDINTERFACE.
