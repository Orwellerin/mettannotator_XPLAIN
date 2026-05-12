process DBCAN_GETDB {

    tag "DBCan v5-2_9-13-2025"

    container "${ workflow.containerEngine in ['singularity', 'apptainer'] ?
        'https://depot.galaxyproject.org/singularity/gnu-wget:1.18--h36e9172_9' :
        'biocontainers/gnu-wget:1.18--h36e9172_9' }"

    publishDir "${params.dbs}", mode: 'copy'

    output:
    tuple path("dbcan/", type: "dir"), val("v5-2_9-13-2025"), emit: dbcan_db


    script:
"""
set -euo pipefail

mkdir -p dbcan

files=\$(curl -L -s \
"https://pro.unl.edu/dbCAN2/browse_download.php?path=run_dbCAN_database_total/db_v5-2_9-13-2025" \
| grep -oE 'download_file.php\\?file=[^"]+' || true)

if [ -z "\$files" ]; then
    echo "ERROR: No files found from dbCAN download page"
    exit 1
fi

echo "\$files" | while read -r file; do
    wget -P dbcan --content-disposition \
    "https://pro.unl.edu/dbCAN2/\$file"
done

if [ -f "dbcan/dbCAN_sub.hmm" ]; then
    mv "dbcan/dbCAN_sub.hmm" "dbcan/dbCAN-sub.hmm"
fi

echo 'v5-2_9-13-2025' > dbcan/VERSION.txt
"""
}
