process MACSYFINDER {
    tag "${meta.prefix}"
    container "https://depot.galaxyproject.org/singularity/macsyfinder%3A2.1.6--pyhdfd78af_0"
    input:
    tuple val(meta), path(compliant_gbk)
    tuple path(macsyfinder_db), val(db_version)

    output:
    tuple val(meta), file("${meta.prefix}_macsyfinder"), emit: macsyfinder
    path "versions.yml" , emit: versions
}
