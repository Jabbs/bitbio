class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  attr_accessible :description, :name, :science_type, :service_need, :start_date, :instruments_attributes,
                  :tag, :visability, :expiration_date
  
  VISABILITY_OPTIONS = ["public", "private", "locked"]
  
  SCIENCE_TYPES = ["Antibody production", "Antibody purification", "Atomic force microscopy (AFM)", 
    "Bioinformatics", "Cell based assay", "Chromatin immunoprecipitation (ChIP) sequencing", "Cloning molecular constructs", 
    "Compound synthesis", "Computational Biology", "Confocal microscopy", "Consulting", 
    "Copy number variation (CNV) analysis", "Cytometry", "DNA Sequencing", "DNA fragment analysis", "DNA library screen", 
    "DNA microarray", "Digital microscopy", "Electron microscopy", 
    "Enzyme-linked immunosorbent assay (ELISA)", "Experimental design", "Flow cytometry", "Flow cytometry data analysis", 
    "Fluorescence microscopy", "Fluorescence-activated cell sorting (FACS)", "Gene synthesis", "Genomic DNA amplification", 
    "Genomic DNA extraction", "Genotyping", "Genotyping by PCR", "Glycoprotein", "High performance computing", 
    "High throughput screening (HTS)", "High-throughput screening", "Histology", "Image analysis", "Imaging", 
    "Immunofluorescence", "Immunohistochemistry", "Immunostaining", "In situ hybridization (ISH)", "Instrumentation", 
    "Inverted microscopy", "Ion beam microscopy", "Laser capture microdissection", 
    "Library generation for next-generation sequencing", 'Liquid chromatography (LC)', "Liquid chromatography-mass spectrometry (LC-MS)", 
    "Mass spectrometry", "Mass spectrometry data analysis", "Media preparation", "Metabolomics", 
    "Metagenomics data analysis", "Method development", "Methylation analysis", "Microarray data analysis", 
    "Microbial identification", "Microscopy", "Microscopy consulting", "Microscopy data analysis", 
    "Microscopy image analysis", "Molecular biology", "Monoclonal antibody production", 
    "Multidimensional protein identification technology (MudPIT)", "Multiphoton microscopy", "Next-Generation Sequencing", 
    "Next-Generation Sequencing data analysis", "Nuclear magnetic resonance (NMR)", 
    "Nuclear magnetic resonance (NMR) data analysis", "Oligonucleotide synthesis", "Paraffin embedding of tissue", 
    "Pathology", "Peptide synthesis", "Plasmid DNA extraction", "Polyclonal antibody production", 
    "Polymerase chain reaction (PCR)", "Protein digestion", "Protein expression", "Protein identification", 
    "Protein purification", "Protein sequencing", "Proteomics", "Pyrosequencing", "RNA Sequencing", "RNA extraction", 
    "RNA microarray", "RNA purification", "Recombinant IgG production", "Sample processing", 
    "Scanning Tunneling Microscopy", "Scanning electron microscopy (SEM)", "Scanning probe microscopy", 
    "Sectioning of frozen tissue", "Serum testing", "Shotgun DNA sequencing", "Site directed mutagenesis", 
    "Software development", "Spinning disk confocal microscopy", "Statistical Analysis", "Targeted gene sequencing", "Tissue culture", 
    "Transgenic mouse development", "Transmission electron microscopy (TEM)", "Transmitted light microscopy", "Virus production",
    "Whole exome sequencing", "Whole genome assembly", "Whole genome sequencing", "Widefield fluorescence microscopy", 
    "cDNA library construction", "single molecule real time (SMRT) sequencing"]
    
  SCIENCE_EQUIPMENT = ['ABI 3730 DNA Analyzer', 'Biomek FX Liquid Handling Robot', 'Tecan Freedom EVO Liquid Handling Robot',
    'Qpix2 Colony Picking Robot', 'Singer RoTor HDA robot', 'Hydra II Microdispenser', 'CAS 4200 PCR Setup Robot',
    'Illumina GAIIx']
    
  SERVICE_NEEDS = ["Science", "Services", "Science + Services", "Data Analysis", "Research Validation", "Clinical Studies"]
  
  TAGS = ["abiogenesis", "anatomy", "antibiotics", 
    "astrobiology", "bacteriology", "biochemistry", "biophysics", "biotechnology", "botany", 
    "cardiology", "cell-biology", "cell-culturing", "cloning", "cytogenetics", "cytology", 
    "developmental-biology", "dna-sequencing", "ecology", "electrophysiology", 
    "embryology", "endocrinology", "entomology", "epidemiology", "epigenetics", 
    "ethology", "gene-annotation", "gene-expression", 
    "gene-regulation", "genetics", "genomics", "hematology", "histology", 
    "human-genetics", "human-genome", "ichthyology", "imaging", "immunology", 
    "marine-biology", "medicinal-chemistry", "metabolism", "microbiology", "microscopy", 
    "molecular-biology", "mycology", "neuroanatomy", "neurology", "neuroscience", 
    "neurotransmission", "next-generation-sequencing", "nutrition", "ornithology", 
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
  validates :tag, presence: true
  
  # associations
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :instruments, dependent: :destroy
  has_many :messages
  accepts_nested_attributes_for :instruments, allow_destroy: true
  
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
  
  def self.search(keyword=nil, from=nil, to=nil, location=nil, science=nil, tag=nil)
    projects = self.scoped
    unless keyword.blank? || keyword == nil
      projects = projects.where("name LIKE ? OR description LIKE ? OR science_type LIKE ?", "%#{keyword}%","%#{keyword}%","%#{keyword}%")
    end
    unless science.blank? || science == nil
      projects = projects.where(service_need: science)
    end
    unless location.blank? || location == nil
      projects = projects.joins(:user).where(users: {continent: location})
    end
    unless tag.blank? || tag == nil
      # projects = projects.joins(:instruments).where(instruments: {alias: instrument})
      projects = projects.where(tag: tag)
    end
    unless from == nil || to == nil || from.blank? || to.blank?
      projects = projects.where(created_at: ( from..to) )
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
