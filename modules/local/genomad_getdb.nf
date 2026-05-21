process GENOMAD_GETDB {

    tag "GENOMAD DB version 1.11.0"

    container "antoniopcamargo/genomad:1.11.0"

    publishDir "${params.dbs}", mode: 'copy'

    output:
    tuple path("genomad_db/", type: "dir"), val("1.11.0"), emit: genomad_db

    script:
    """
    set -euo pipefail

    mkdir -p genomad_db

    genomad download-database genomad_db

    echo "1.11.0 2025-02-24" > genomad_db/VERSION.txt
    """
}