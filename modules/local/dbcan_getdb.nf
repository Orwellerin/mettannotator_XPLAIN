process DBCAN_GETDB {

    tag "DBCan v5-2_9-13-2025"

    container "${ workflow.containerEngine in ['singularity', 'apptainer'] ?
        'https://depot.galaxyproject.org/singularity/gnu-wget:1.18--h36e9172_9' :
        'biocontainers/gnu-wget:1.18--h36e9172_9' }"

    publishDir "${params.dbs}", mode: 'copy'

    output:
    tuple path("dbcan/", type: "dir"), val("v5-2_9-13-2025"), emit: dbcan_db

    shell:
"""
/bin/bash
"""

    script:
"""
set -euo pipefail

mkdir -p dbcan

curl -L -s \
"https://pro.unl.edu/dbCAN2/browse_download.php?path=run_dbCAN_database_total/db_v5-2_9-13-2025" \
| grep -oP 'download_file.php\?file=[^"]+' \
| while read file; do
wget -P dbcan --content-disposition "https://pro.unl.edu/dbCAN2/\$file"
done

if [ -f "dbcan/dbCAN_sub.hmm" ]; then
mv "dbcan/dbCAN_sub.hmm" "dbcan/dbCAN-sub.hmm"
fi

echo 'v5-2_9-13-2025' > dbcan/VERSION.txt
"""
}
