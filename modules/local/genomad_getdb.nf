process GENOMAD_GETDB {

    tag "GENOMAD DB version 1.11.0"
    container "https://depot.galaxyproject.org/singularity/genomad:1.9.0--pyhdfd78af_1"

    publishDir "${params.dbs}/genomad_db", mode: 'copy', overwrite: true

    output:
    tuple path("genomad_db"), val("1.11.0"), emit: genomad_db

    script:
    """
    set -euo pipefail

    mkdir -p genomad_db

    genomad download-database genomad_db

    echo "genomad-db\t1.11.0" > genomad_db/VERSION.txt
    """
}
