process ANNOTALE {

    tag "${meta.prefix}"
    label 'process_medium'

    container 'docker://eclipse-temurin:17-jre-jammy'

    publishDir "${params.outdir}/annotale", mode: 'copy'

    input:
    tuple val(meta), path(fna), path(faa)
    path jar
    path class_xml

    output:
    tuple val(meta), path("${meta.prefix}.annotale"), emit: results
    path "versions.yml", emit: versions

    script:
    """
    set -euo pipefail

    OUTDIR="${meta.prefix}.annotale"
    mkdir -p "\$OUTDIR"

    java -jar "${jar}" predict g="${fna}" outdir="\$OUTDIR"

    java -jar "${jar}" analyze \
        t="\$OUTDIR/TALE_DNA_sequences.fasta" \
        outdir="\$OUTDIR"

    java -jar "${jar}" assign \
        c="${class_xml}" \
        t="\$OUTDIR/TALE_DNA_parts.fasta" \
        outdir="\$OUTDIR"

    cat <<EOF > versions.yml
    ANNOTALE:
        java: \$(java -version 2>&1 | head -n 1)
        annotale: "1.5"
    EOF
    """
}