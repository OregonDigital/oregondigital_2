HydraEditor.models = ["Image", "Document", "GenericSet"]
HydraEditor::Fields::Generator.factory = OregonDigital::Fields::InputFactory.new(
  HydraEditor::Fields::Factory,
  DecoratorList.new(HasHintOption, HasURIInputType)
)
