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
