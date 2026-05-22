process GENOMAD {

    tag "${meta.prefix}"
    label 'process_medium'

    container "antoniopcamargo/genomad:1.11.0"

    input:
    tuple val(meta), path(fna)
    tuple path(db), val(db_version)

    output:
    tuple val(meta), path("${meta.prefix}"), emit: results
    path "versions.yml", emit: versions

    script:
    """
    set -euo pipefail

    genomad end-to-end \
        "${fna}" \
        "${meta.prefix}" \
        "${db}"
    """
}
