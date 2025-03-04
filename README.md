# Codygen ABAP use case  

## What is Codygen?

[Codygen](https://github.com/theplenkov-npm/codygen/blob/main/packages/codygen/README.md) - is a Cody CLI wrapper delivering following features:
- construct the prompt from other files
- provide the context files
- call chat command
- parse chat response and fetch file content from the response and store it to the drive

## Prerequisites

- Install Cody CLI, or preferably open in a devcontainer ( it's just enough to open in a Codespace )
- Login to Cody CLI with your sourcegraph account


## Use cases

### Petstore openAPI spec generation ( only descriptor )

Here is how we generate this [spec](./src/petstore/zcl_petstore_v3.clas.abap) 

- create [codygen-petstore.config.ts](./codygen-petstore.config.ts)
```typescript
import { config, from } from 'codygen';
import { glob } from 'node:fs/promises';

export default config({
    prompt: from('prompts').read(['petstore.md', 'abap.md']),
    context: Array.fromAsync(
        glob([
            'specs/openapi/openapi_3_0.yaml',
            'specs/petstore/petstore3.json',
            'src/openapi/zif_openapi_3_0.intf.abap',
            'samples/zcl_petstore_v3.clas.abap'
        ])
    ),
    output: 'src/petstore',
});
```

* here are prompts, which we merge in a config
  We split them to break apart generic requirements such as abap and sepcifc product requirements. By doing this we can share promp parts in different scenarios
  - [prompts/petstore.md](./prompts/petstore.md)
  - [prompts/abap.md](./prompts/abap.md)
* here are context files we use
  - [specs/openapi/openapi_3_0.yaml](./specs/openapi/openapi_3_0.yaml) - OpenApi spec in a yaml format
  - [specs/petstore/petstore3.json](./specs/petstore/petstore3.json) - Petstore spec implementing the petstore API
  - [src/openapi/zif_openapi_3_0.intf.abap](./src/openapi/zif_openapi_3_0.intf.abap) - previously generated Openapi interface to make AI aware of the interface which describes openapi spec type
  - [samples/zcl_petstore_v3.clas.abap](./samples/zcl_petstore_v3.clas.abap) - sample implementation. Sample is important beacuse AI follows a pattern from a sample

- Run a command like `npx codygen --config codygen-petstore.config.ts`




  
