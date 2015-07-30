HydraEditor.models = ["Image", "Document", "GenericSet", "ExternalAsset"]
HydraEditor::Fields::Generator.factory = OregonDigital::Fields::InputFactory.new(
  HydraEditor::Fields::Factory,
  DecoratorList.new(HasHintOption, HasURIInputType)
)
