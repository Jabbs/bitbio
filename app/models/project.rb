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
    
  SCIENCE_EQUIPMENT = ['ABI 3730 DNA Analyzer', 'Biomek FX Liquid Handling Robot', 'Tecan Freedom EVO Liquid Handling Robot',
    'Qpix2 Colony Picking Robot', 'Singer RoTor HDA robot', 'Hydra II Microdispenser', 'CAS 4200 PCR Setup Robot',
    'Illumina GAIIx']
    
  SERVICE_NEEDS = ["Services", "Collaboration", "Science + Services", "Data Analysis", "Research Validation", "Clinical Studies"]
  
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
    "neurotransmission", "ngs", "nutrition", "ornithology", 
    "palaeontology", "parasitology", "pathology", "pharmacology", "phylogenetics", 
    "physiology", "plant-anatomy", "plant-physiology", "population-biology", 
    "protein-binding", "protein-folding", "psychology", 
    "rna-sequencing", "sequence-analysis", "software-development", "species-identification", "staining", 
    "statistics", "stem-cells", "structural-biology", "stynthetic-biology", "stystems-biology", 
    "taxonomy", "theoretical-biology", "toxicology", 
    "vaccination", "virology", "vitamins", "zoology"]
  
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
  has_many :comments, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :messages
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  accepts_nested_attributes_for :instruments, allow_destroy: true
  accepts_nested_attributes_for :taggings, allow_destroy: true

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

    unless any == 'yes'
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
