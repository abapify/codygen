## abapGit support

- all generated ABAP artifacts should be provided with a corresponing abapGit descriptor
- there is no need to generate root-level abapgit.xml since is already present in the project

Follow provided example, but use all possible properties

## codygen

- this is a machine generated prompt
- do not include summary or intro, only files are important, because this response will be parsed and files from the response will be stored
- do not try to follow the path of the context files - always generate in a root folder

## Proper type definition sequence

Remember that in ABAP you cannot reference a type before it is defined. So this is wrong:

```abap
  TYPES:
    " Basic types
    BEGIN OF info,
      contact        TYPE contact,
    END OF info,

    BEGIN OF contact,
      name  TYPE string,
      url   TYPE string,
      email TYPE string,
    END OF contact
```

but this is correct:

```abap
  TYPES:
    BEGIN OF contact,
      name  TYPE string,
      url   TYPE string,
      email TYPE string,
    END OF contact,
    " Basic types
    BEGIN OF info,
      contact        TYPE contact,
    END OF info,
```
