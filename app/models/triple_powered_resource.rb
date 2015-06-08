class TriplePoweredResource < ActiveTriples::Resource
  property :preflabel, :predicate => RDF::SKOS.prefLabel
  def initialize(*args)
    super
    set_persistence_strategy MarmottaStrategy::Factory.new(OregonDigital.marmotta)
    reload
  end

  def preferred_label
    @preferred_label ||= composite_label.to_s
  end

  private

  def composite_label
    CompositeLabel.new(label_finder.labels)
  end

  def label_finder
    LanguageSelector::LabelFinderFactory.new(AllLabelFinder).new(self)
  end

end
