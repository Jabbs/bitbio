class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  attr_accessible :description, :name, :science_type, :service_need, :start_date, :instruments_attributes,
                  :visability, :expiration_date, :tag_list
  
  VISABILITY_OPTIONS = ["public", "private", "locked"]
  
  SCIENCE_TYPES = ["Alignment", "Allele-specific transcription", "Alternative Splicing", "Ancient DNA", 
    "Antibody production", "Antibody purification", "Atomic force microscopy (AFM)", "Bioinformatics", 
    "Bisulfite Sequencing", "Cancer biology", "Cell based assay", "ChIP-Seq", "ChIP-Seq Analysis", 
    "ChIP-on-chip", "Chromatin immunoprecipitation (ChIP) sequencing", "Chromosome Walking", 
    "Clone verification", "Cloning molecular constructs", "Comparative genomics", 
    "Comparative transcriptomics", "Compound synthesis", "Computational Biology", "Confocal microscopy", 
    "Consulting", "Copy number estimation", "Copy number variation (CNV) analysis", "Cytometry", 
    "DNA Sequencing", "DNA fragment analysis", "DNA library screen", "DNA methylation", "DNA microarray", 
    "DNA-Seq", "De novo assembly", "De novo sequencing", "De novo transcriptome assembly", 
    "Differential Expression", "Differential methylated regions identification", "Digital microscopy", 
    "Electron microscopy", "Enzyme-linked immunosorbent assay (ELISA)", "Epigenomics", "Exome analysis", 
    "Exome and whole genome variant detection", "Experimental design", "Flow cytometry", 
    "Flow cytometry data analysis", "Fluorescence microscopy", "Fluorescence-activated cell sorting (FACS)", 
    "Functional Genomics", "Fusion genes", "Fusion transcripts", "Gene Expression Analysis", 
    "Gene annotation retrieval", "Gene expression", "Gene finding", "Gene regulation", 
    "Gene structure and RNA splicing", "Gene synthesis", "General bioinformatics (pipeline)", 
    "Genetic variation", "Genome Wide Association Studies", "Genomic Assembly", "Genomic DNA amplification", 
    "Genomic DNA extraction", "Genotype and phenotype", "Genotyping", "Genotyping by PCR", "Glycoprotein", 
    "High performance computing", "High throughput screening (HTS)", "High-throughput screening", 
    "High-throughput sequencing", "Histology", "Homology", "Image analysis", "Imaging", 
    "Immunofluorescence", "Immunohistochemistry", "Immunostaining", "In situ hybridization (ISH)", 
    "In vitro selection", "InDel discovery", "Instrumentation", "Integrated solution", "Inverted microscopy", 
    "Ion beam microscopy", "Laser capture microdissection", "Library generation for next-generation sequencing", 
    "Liquid chromatography (LC)", "Liquid chromatography-mass spectrometry (LC-MS)", "Mass spectrometry", 
    "Mass spectrometry data analysis", "MeDIP-Seq", "Media preparation", "Metabolic pathways", 
    "Metabolic reconstruction", "Metabolomics", "Metagenomics", "Metagenomics data analysis", 
    "Metatranscriptomics", "Method development", "Methylation analysis", "MiRNA", "MiRNA-Seq", 
    "Microarray data analysis", "Microbial identification", "Microscopy", "Microscopy consulting", 
    "Microscopy data analysis", "Microscopy image analysis", "Molecular biology", 
    "Monoclonal antibody production", "Motif analysis", "Motif discovery", 
    "Multidimensional protein identification technology (MudPIT)", "Multiphoton microscopy", "Mutations", 
    "Mutations and regulatory sites", "NcRNAs", "New gene discovery", 
    "Next-Generation Sequencing", "Next-Generation Sequencing data analysis", 
    "Nuclear magnetic resonance (NMR)", "Nuclear magnetic resonance (NMR) data analysis", 
    "Nucleosome Positioning", "Oligonucleotide synthesis", "Paraffin embedding of tissue", "Pathology", 
    "Pathway analysis", "Pathways, networks and models", "Peptide synthesis", "Personal genomics", 
    "Phylogenetics", "Plasmid DNA extraction", "Polyclonal antibody production", 
    "Polymerase chain reaction (PCR)", "Population Genomics", "Protein digestion", "Protein expression", 
    "Protein identification", "Protein interactions", "Protein purification", "Protein sequencing", 
    "Protein structure analysis", "Proteomics", "Pyrosequencing", "Quality Control", "RNA Sequencing", 
    "RNA extraction", "RNA microarray", "RNA purification", "RNA-Seq", "RNA-Seq Alignment", 
    "RNA-Seq Quantitation", "Read alignment", "Recombinant IgG production", "Reference assembly", 
    "Regulatory element annotation", "Regulatory genomics", "Regulatory genomics epigenomics", 
    "Regulatory sites", "Resequencing", "SNP Annotation", "SNP discovery", "SRNA", "Sample processing", 
    "Scanning Tunneling Microscopy", "Scanning electron microscopy (SEM)", "Scanning probe microscopy", 
    "Sectioning of frozen tissue", "Sequence Quality Control", "Sequence alignment", "Sequence analysis", 
    "Sequence assembly", "Sequence comparison", "Sequence motifs", "Serum testing", 
    "Shotgun DNA sequencing", "Site directed mutagenesis", "Small RNA", "Software development", 
    "Somatic mutations", "Spinning disk confocal microscopy", "Statistical Analysis", 
    "Structural variation", "Structural variation discovery", "Systems biology", "Targeted assembly", 
    "Targeted gene sequencing", "Targeted resequencing", "Tissue culture", 
    "Transcription Factor Binding Site identification", "Transcription Factor analysis", 
    "Transcription regulation", "Transgenic mouse development", "Transmission electron microscopy (TEM)", 
    "Transmitted light microscopy", "Transposable Elements", "Viral genomics", "Viral metagenomics", 
    "Virus production", "Whole Genome Resequencing", "Whole Genome Resequencing Analysis", 
    "Whole exome sequencing", "Whole genome assembly", "Whole genome sequencing", 
    "Widefield fluorescence microscopy", "Yeast one-hybrid", "Yeast two-hybrid", "cDNA library construction", 
    "single molecule real time (SMRT) sequencing"]
    
  SCIENCE_EQUIPMENT = ["4peaks", "AB Large Indel Tool", "AB Small Indel Tool", "ABBA", "ABI 3730 DNA Analyzer", "ABI 7500 Real Time System", "ABI 7900HT Real Time System", "ABMapper", "ABySS", "AGE", "AGILE", "ALEXA-Seq", "ALLPATHS", "AMOS", "ANCHOR", "ANNOVAR", "AREM", "ASC", "ATAC", "Adapter Removal (software)", "Affymetrix GeneChip Fluidics Station 450", "Affymetrix GeneChip Scanner 3000", "Agilent Array Scanner", "Agilent BioAnalyzer", "Agp2amos", "Alcovna", "Alta-Cyclic", "Anno-J", "Arachne", "Arf", "Array Suite (Array Studio/Server)", "ArrayExpressHTS", "ArrayStar", "Atlas Suite", "Atlas-SNP2", "Avadis NGS", "BAMseek", "BBSeq", "BEADS", "BEAP", "BEDTools", "BFAST", "BFCounter", "BING", "BLAST", "BLAT", "BOAT", "BRAT", "BRCA-diagnostic", "BS Seeker", "BS-Seq", "BSMAP", "BSSim", "BWA", "BWA-SW", "Baa.pl", "BamTools", "BamView", "Bambino", "Bambus", "Barcode generator", "Barcrawl Bartab", "BarraCUDA", "Batman", "BaySeq", "BayesCall", "BayesPeak", "Bcbio-nextgen", "Bedutils", "Belvu", "BiQ Analyzer", "BiQ Analyzer HT", "BioSmalltalk", "Biomek FX Liquid Handling Robot", "Bionimbus", "Biopieces", "Biopython", "Bis-SNP", "Bismark", "Bison", "Blixem", "Bort", "Bowtie", "BreakDancer", "BreakSeq", "Breakpointer", "Breakway", "Btrim", "CABOG", "CANGS", "CARPET", "CAS 4200 PCR Setup Robot", "CASHX", "CATCH", "CGA Tools", "CHiPSeq", "CLCbio Genomics Workbench", "CLEVER", "CNANorm", "CNAseg", "CNB MetaGenomics tools", "CNVer", "CNVnator", "CNVseq", "CORAL (Contig Ordering Algorithm)", "CPTRA", "CRAC", "CRISP", "CUDA-EC", "Caliper Labchip 90 System", "CatchAll", "ChIP-Seq (application)", "ChIPMunk", "ChIPmeta", "ChIPseqR", "ChimeraScan", "Chipster", "ChromHMM", "ChromaSig", "CisGenome", "Cistrome", "Clean reads", "CleaveLand", "ClipCrop", "CloudAligner", "CloudBurst", "ClustDB", "CnD", "CnvHMM", "CoNAn-SNV", "CompreheNGSive", "ConDeTri", "ContEst", "Contra", "Contrail", "CopySeq", "Coral", "Cortex", "Crossbow", "Cufflinks", "CummeRbund", "Curtain", "Cutadapt", "DEGseq", "DESeq", "DIAL", "DNA Baser", "DNA Chromatogram Explorer", "DNAA", "DNAzip", "DSAP", "DSGseq", "DSRC", "DeFuse", "DecGPU", "DeconSeq", "DiBayes", "Diffreps", "Dindel", "DrFAST", "E-miR", "EBCall", "ECHO", "EDENA", "ELAND", "EMBF", "ERANGE", "ERDS", "ERNE", "ESTcalc", "EULER", "Ea-utils", "EagleView", "EagleView genome viewer", "EdgeR", "EpiGRAPH", "Epigenome", "Error Correction Evaluation Toolkit", "Est2assembly", "ExomeCNV", "ExomeCopy", "ExomePicks", "Exonerate", "FAAST", "FACS", "FDM", "FLASH", "FREEC", "FastQ Screen", "FastQC", "FastQValidator", "FeatureCounts", "Figaro", "Filter", "FindPeaks 3.1", "FindPeaks 4.0 (Vancouver Short Read Package)", "Flexbar", "FlowSim", "Flower", "Flux", "Forge", "FragGeneScan", "FrameDP", "FreClu", "Freebayes", "FusionAnalyser", "FusionCatcher", "FusionHunter", "FusionMap", "FusionSeq", "Fuzzypath", "G-Mo.R-Seq", "G-SQZ", "GAMES", "GASSST", "GASV", "GATK", "GBrowse", "GEM", "GEM library", "GENE-Counter", "GMAP", "GPS", "GPSeq", "GRS", "GSNAP", "Galign", "Gambit", "GeeFu", "GenVision", "GeneProf", "GeneTalk", "Geneious", "GenoMiner", "GenoViewer", "Genomatix Mining Station (GMS)", "Genome Trax", "GenomeBrowse", "GenomeJack", "GenomeMapper", "GenomeTools", "GenomeView", "Genomedata", "Genometa", "GenomicTools", "GensearchNGS", "Geoseq", "GigaBayes", "GimmeMotifs", "Girafe", "Gk arrays", "Gnumap", "Goby framework", "Golden Helix", "Goseq", "Gowinda", "HI", "HMMSplicer", "HPeak", "HTSeq", "Hairpin Annotation", "Haplowser", "HawkEye", "HeliSphere", "HiTEC", "Hicup", "Hybrid-SHREC", "Hydra II Microdispenser", "IBD2", "ICORN", "IDBA", "IGV", "IOmics", "IQSeq", "ISAAC", "ISSAKE", "Ibis", "Illumina GAIIx", "Illumina HiScan SQ", "Illumina HiSeq 1000/1500", "Illumina HiSeq 2000/2500", "Illumina MiSeq", "Illumina Next-Generation Sequencing", "Illuminator", "InGAP", "Inchworm", "Ingenuity Variant Analysis", "Integrated Genome Browser", "Ion PGM 314", "Ion PGM 316", "Ion PGM 318", "Ion Proton PI", "Ion Proton PII", "Ion Proton PIII", "Ion Torrent Next-Generation Sequencing", "Isas", "IsoEM",
      "JBrowse", "Jellyfish", "JointSLM", "KARMA", "KNIME", "Kismeth", "Kissnp", "Knime4Bio", "Krona", "LAST", "LASTZ", "LOCAS", "Lab7", "Lasergene", "LobSTR", "LookSeq", "MACS", "MAQ", "MAQGene", "MARGARITA", "MAXIMUS", "MAYDAY", "MEGAN", "METAGENassist", "MG-RAST", "MICSA", "MIP Scaffolder", "MIRA", "MISO", "MJ Research Tetrad Thermocycler", "MMSEQ", "MOM", "MOSAIK", "MPscan", "MTR", "MU2A", "MUMmer", "MUMmerGPU", "MagicViewer", "MapDamage", "MapNext", "MapSplice", "MapView", "Mapsembler", "Mason", "Matrical Bioscience SonicMan Plate Sonicator", "Mauve", "MeV", "Meerkat", "Megraft", "Meraculous", "MetMap", "MetaSim", "Metaxa", "MethMarker", "MethylCoder", "MiRCat", "MiRDeep", "MiRNAkey", "MiRProf", "MiRanalyzer", "MiRspring", "MicroRazerS", "Microsoft Biology Foundation", "Minia", "MirTools", "Mlgt", "MoDIL", "MochiView", "MrCaNaVaR", "MrFAST", "MrsFAST", "MuMRescueLite", "MuSICA 2", "MuTect", "Mutascope", "Myrialign", "Myrna", "Mzip", "NGS-DesignTools", "NGSUtils", "NGSView", "NOISeq", "NPS", "Nesoni", "Newbler", "Nexalign", "Next-Generation Sequencing (NGS)", "NextGENe", "NextGen Utility Scripts", "Ngs backbone", "Ngs-pipeline", "NovelSeq", "Novocraft", "NucleR", "OLego", "Oases", "Omixon Variant Toolkit", "Optimus Primer", "PALMA", "PALMapper", "PARalyzer", "PASH", "PASS", "PE-Assembler", "PECAN", "PEMer", "PERalign", "PICS", "PIQA", "PRICE", "PRINSEQ", "PaCGeE", "PacBio RS", "PacBio conversion tools", "Pacific Biosciences SMRT Next-Generation Sequencing", "PanGEA", "Partek Genomics Suite", "PatMaN", "Patchwork", "PeakAnalyzer", "PeakRanger", "PeakSeq", "PerM", "Phred", "Phred Phrap Consed Cross match", "Phymm", "PiCall", "PileLine", "Pindel", "Pipeline Pilot", "PoPoolation", "PoPoolation2", "PoissonSeq", "PolyBayesShort", "PoolHap", "ProbHD", "ProbeMatch", "Proxygenes", "Pybedtools", "PyroBayes", "PyroMap", "PyroNoise", "QCALL", "QIAgility PCR Setup Robot", "QSRA", "QSeq", "QUAST", "Qpalma", "Qpix2 Colony Picking Robot", "QuEST", "QuadGT", "Quake", "QualiMap", "Quip", "R2R", "R453Plus1Toolbox", "RACA", "RAPSearch", "RApiD", "RDP Pyrosequencing Pipeline", "RDiff", "REAL", "RECOUNT", "RGA", "RMAP", "RNA", "RNA-MATE", "RNASEQR", "RSAT peak-motifs", "RSEM", "RSEQtools", "RTG Investigator", "RUbioSeq", "Ray", "RazerS", "ReSeqSim", "ReadDepth", "Readaligner", "Reaper", "Reconciliator", "RefCov", "Repitools", "Reptile", "RiboPicker", "Rnnotator", "RobiNA", "Roche 454 Next-Generation Sequencing", "Roche GS FLX+", "Roche GS Jr", "Rolexa", "Rsolid", "Rsubread",
      "S-MART", "SAMMate", "SAMStat", "SAMtools", "SCALCE", "SCARF", "SEAL", "SEECER", "SEED", "SESAME", "SEWAL", "SGA", "SHARCGS", "SHE-RA", "SHOREmap", "SHORTY", "SHRAP", "SHREC", "SHRiMP", "SICER", "SLOPE", "SNIP-Seq", "SNP-o-matic", "SNPSeeker", "SNVMix", "SNVer", "SOAP", "SOAPdenovo", "SOAPsnp", "SOCS", "SOLID software tools", "SOLiD 5500", "SOLiD 5500 Wildfire", "SOLiD 5500xl", "SOLiD 5500xl Wildfire", "SOLiD Next-Generation Sequencing", "SOPRA", "SPLINTER", "SPP", "SR-ASM", "SRAdb", "SRMA", "SSA", "SSAHA", "SSAKE", "SSPACE", "STADEN", "STAR", "SUDS genome browser", "SUTTA", "SVDetect", "SVMerge", "SWAP454", "SWT", "SXOligoSearch", "Samscope", "Savant Genome Browser", "Scaffolder", "Scripture", "Segemehl", "Segtor", "Seq2HLA", "SeqAn", "SeqBuster", "SeqCons", "SeqEM", "SeqGSEA", "SeqMINER", "SeqMan NGen", "SeqMap", "SeqMonk", "SeqPrep", "SeqSaw", "SeqSeg", "SeqSite", "SeqSolve", "SeqTrim", "SeqWare", "SeqWords", "Sequedex", "SequenceVariantAnalyzer", "Sequencher", "Sff2fastq", "Sherman", "ShoRAH", "Shore", "ShortFuse", "ShortRead", "SiLoCo", "Sibelia", "Sim4cc", "SimNext", "SimSeq", "Singer RoTor HDA robot", "Sissrs", "SlideSort", "Slider", "SmashCommunity", "Sniper", "Solas", "Sole-Search", "SolexaQA", "SolexaTools", "SomaticCall", "Spectramax M2e Microplate reader", "Spiral Genetics", "SpliceGrapher", "SpliceMap", "SpliceTrap", "SplicingViewer", "SplitSeek", "SsahaSNP", "Stampy", "Standalone hamming", "Standardized Velvet Assembly Report", "Strelka", "Subjunc", "Subread", "SuccinctAssembly", "Suffixerator", "Supersplat", "SwDMR", "Swalign", "Swift", "Syapse", "Syzygy", "T-lex", "TAPyR", "TASE", "TASR", "TEQC", "TMAP", "TOTALRECALLER", "Ta-si prediction", "Tablet", "TagCleaner", "TagDust", "Taipan", "Tally", "Tallymer", "Tecan Freedom EVO Liquid Handling Robot", "Thermocycler", "TiMat2", "TileQC", "TopHat", "TopHat-Fusion", "Tracembler", "Trans-ABySS", "Trimmomatic", "Trinity", "Tripal", "Tview", "UGENE", "USeq", "UnoSeq", "V-Xtractor", "VAAL", "VAAST", "VARiD", "VCAKE", "VCFtools", "VIP", "VarScan", "Variant Effect Predictor", "VariantClassifier", "Variation toolkit", "VariationHunter", "Velvet", "VelvetOptimiser", "Vicuna", "ViralFusionSeq", "VirusHunter", "VirusSeq", "VisSR", "Vmatch", "WHAM", "WebApollo", "WebPrInSeS", "XMatchView", "YASS", "ZINBA", "ZOOM", "ZORRO"]
  
  SERVICE_NEEDS = ["Services", "Science + Services", "Collaboration", "Data Analysis", "Research Validation", "Clinical Studies"]
  
  TAGS = ["abiogenesis", "anatomy", "antibiotics", 
    "astrobiology", "bacteriology", "biochemistry", "bioinformatics", "biophysics", "biotechnology", "botany", 
    "cardiology", "cell-biology", "cell-culturing", "cloning", "cytogenetics", "cytology", 
    "developmental-biology", "dna", "dna-sequencing", "ecology", "electrophysiology", 
    "embryology", "endocrinology", "entomology", "epidemiology", "epigenetics", 
    "ethology", "gene-annotation", "gene-expression", 
    "gene-regulation", "genetics", "genomics", "hematology", "histology", 
    "human-genetics", "human-genome", "ichthyology", "imaging", "immunology", 
    "marine-biology", "medicinal-chemistry", "metabolism", "microbiology", "microscopy", 
    "molecular-biology", "mycology", "neuroanatomy", "neurology", "neuroscience", 
    "neurotransmission", "next-gen-sequencing", "nutrition", "ornithology", 
    "palaeontology", "parasitology", "pathology", "pharmacology", "phylogenetics", 
    "physiology", "plant-anatomy", "plant-physiology", "population-biology", 
    "protein-binding", "protein-folding", "psychology", 
    "rna-sequencing", "sequence-analysis", "software-development", "species-identification", "staining", 
    "statistics", "stem-cells", "structural-biology", "stynthetic-biology", "stystems-biology", 
    "taxonomy", "theoretical-biology", "toxicology", 
    "vaccination", "virology", "vitamins", "zoology"]
  
  TAGS_FOR_LANDING_PAGE = ["next-gen-sequencing", "bioinformatics", "virology", "epigenetics", "protein-folding",
                            "dna", "cell-biology", "toxicology", "stynthetic-biology", "imaging"]
  
  # callbacks
  after_validation :move_friendly_id_error_to_name
  before_save :strip_inputs
  
  # validations
  validates :description, presence: true, length: { minimum: 90, maximum: 2000 }
  validates :science_type, presence: true
  validates :visability, presence: true, inclusion: { in: VISABILITY_OPTIONS, message: "%{value} isn't an allowed option" }
  validates :name, presence: true, uniqueness: true
  validates :start_date, presence: true
  
  # associations
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :messages
  has_many :taggings, as: :taggable, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :taggings, allow_destroy: true
  accepts_nested_attributes_for :instruments, allow_destroy: true

  def self.tagged_with(name)
    Tag.find_by_name(name).projects if Tag.find_by_name(name)
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
  def inactive?
    !self.active?
  end
  
  def strip_inputs
    self.name = self.name.strip
    self.science_type = self.science_type.strip
  end
  
  def days_til_start
    (self.start_date - Date.today).to_i
  end
  
  def move_friendly_id_error_to_name
    errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end

  def self.search(any=nil, na=nil, eur=nil, asia=nil, aus=nil, science=nil, tag=nil)
    projects = self.scoped
    # unless keyword.blank? || keyword == nil
    #   projects = projects.where("name LIKE ? OR description LIKE ? OR science_type LIKE ?", "%#{keyword}%","%#{keyword}%","%#{keyword}%")
    # end
    # unless location.blank? || location == nil
    #   projects = projects.joins(:user).where(users: {continent: location})
    # end
    # unless from == nil || to == nil || from.blank? || to.blank?
    #   projects = projects.where(created_at: ( from..to) )
    # end
    unless science.blank? || science == nil
      projects = projects.where(service_need: science)
    end
    unless tag.blank? || tag == nil
      # projects = projects.joins(:instruments).where(instruments: {alias: instrument})
      projects = projects.joins(:tags).where(tags: {name: tag})
    end

    unless any.present? && any == 'yes'
      continents = []
      unless na.blank? || na == nil
        continents << "North America" if na == 'yes'
      end
      unless eur.blank? || eur == nil
        continents << "Europe" if eur == 'yes'
      end
      unless asia.blank? || asia == nil
        continents << "Asia" if asia == 'yes'
      end
      unless aus.blank? || aus == nil
        continents << "Australia" if aus == 'yes'
      end
    
      projects = projects.joins(:user).where(users: {continent: continents})
    end
    projects
  end
  
  def add_view_count
    self.view_count += 1
    save
  end
  
  def country
    user.country
  end
  
end
