import { config, from } from 'codygen';
import { glob } from 'node:fs/promises';

export default config({
    prompt: from('prompts').read(['openapi.md', 'abap.md']),
    context: Array.fromAsync(
        glob([
            'specs/openapi/openapi_3_0.yaml',
            'samples/zif_openapi.intf.abap'
        ])
    ),
    output: 'src/openapi',
});
