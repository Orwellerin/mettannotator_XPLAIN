process ANNOTALE {

    tag "${meta.prefix ?: 'sample'}"
    label 'process_medium'

    container = 'docker://eclipse-temurin:17-jre-jammy'

    input:
    tuple val(meta), path(fasta)
    path jar
    path class_xml

    output:
    tuple val(meta), path("${meta.id ?: meta.sample ?: 'sample'}.annotale"), emit: results
    path "versions.yml", emit: versions

    script:
    def prefix = meta.id ?: meta.sample ?: "sample"

    """
    java -jar AnnoTALEcli-1.5.jar predict -h
    set -euo pipefail

    OUTDIR="${prefix}.annotale"
    mkdir -p "\$OUTDIR"

    java -jar ${jar} predict g=${fasta} outdir="\$OUTDIR"

    java -jar ${jar} analyze \
        t="\$OUTDIR/TALE_DNA_sequences.fasta" \
        outdir="\$OUTDIR"

    java -jar ${jar} assign \
        c=${class_xml} \
        t="\$OUTDIR/TALE_DNA_parts.fasta" \
        outdir="\$OUTDIR"

    cat <<EOF > versions.yml
    ANNOTALE:
        java: \$(java -version 2>&1 | head -n 1)
        annotale: "1.5"
    EOF
    """
}
