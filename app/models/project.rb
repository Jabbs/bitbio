class Project < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
  attr_accessible :description, :name, :science_type, :service_need, :start_date
  
  SCIENCE_TYPES = ["Antibody production", "Antibody purification", "Atomic force microscopy (AFM)", 
    "Bioinformatics", "Cell based assay", "Chromatin immunoprecipitation (ChIP) sequencing", "Cloning molecular constructs", 
    "Compound synthesis", "Computational Biology", "Confocal microscopy", "Consulting", 
    "Copy number variation (CNV) analysis", "Cytometry", "DNA Sequencing", "DNA fragment analysis", "DNA library screen", 
    "DNA microarray", "Data analysis", "Digital microscopy", "Electron microscopy", 
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
    
  # SCIENCE_EQUIPMENT = ['']
  
  
  belongs_to :user
  has_many :comments
  
  validates :description, presence: true, length: { minimum: 90, maximum: 2000 }
  validates :science_type, presence: true
  validates :name, presence: true, uniqueness: true
  after_validation :move_friendly_id_error_to_name

  def move_friendly_id_error_to_name
    errors.add :name, *errors.delete(:friendly_id) if errors[:friendly_id].present?
  end
  
  def self.search(keyword=nil, from=nil, to=nil, country=nil, science=nil)
    projects = self.scoped
    unless keyword.blank? || keyword == nil
      projects = projects.where("name LIKE ? OR description LIKE ? OR science_type LIKE ?", "%#{keyword}%","%#{keyword}%","%#{keyword}%")
    end
    unless science.blank? || science == nil
      projects = projects.where("science_type LIKE ?", "%#{science}%")
    end
    unless country.blank? || country == nil
      projects = projects.joins(:user).where(users: {country: country})
    end
    unless from == nil || to == nil || from.blank? || to.blank?
      projects = projects.where(start_date: ( from..to) )
    end
    projects
  end
  
  def country
    user.country
  end
  
end
