HydraEditor.models = ["Image", "Document"]
HydraEditor::Fields::Generator.factory = OregonDigital::Fields::InputFactory.new(
  HydraEditor::Fields::Factory,
  DecoratorList.new(HasHintOption, HasURIInputType)
)
