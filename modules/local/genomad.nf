process GENOMAD {
    tag "${meta.prefix}"
    container "${ workflow.containerEngine in ['singularity', 'apptainer'] ?
        'https://depot.galaxyproject.org/singularity/genomad%3A1.9.0--pyhdfd78af_1' :
        'genomad%3A1.9.0--pyhdfd78af_1'}"
    input :
    tuple val(meta), path(fna), path(gff)
    tuple path(genomad_getdb, stageAs: "genomad_getdb"), val(db_version)
}    
