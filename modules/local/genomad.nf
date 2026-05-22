process GENOMAD {

    tag "${meta.prefix}"
    label 'process_medium'

    container "https://depot.galaxyproject.org/singularity/genomad:1.9.0--pyhdfd78af_1"

    input:
    tuple val(meta), path(fna)
    tuple path(db), val(db_version)

    output:
    tuple val(meta), path("${meta.prefix}/**"), emit: results
    path "versions.yml", emit: versions

    script:
    """
    set -euo pipefail

    genomad end-to-end \
        "${fna}" \
        genomad_out \
        "${db}"

    echo "genomad\t1.11.0" > versions.yml
    """
}
