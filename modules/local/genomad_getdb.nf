process GENOMAD_GETDB {

    tag "GENOMAD DB version 1.11.0"
    container "antoniopcamargo/genomad:1.11.0"
    publishDir "${params.dbs}/genomad", mode: 'copy'

    output:
    tuple path("genomad_db"), val("1.11.0"), emit: genomad_db

    script:
    """
    set -euo pipefail

    mkdir -p genomad_db
    genomad download-database genomad_db

    echo "1.11.0" > genomad_db/VERSION.txt
    """
}
