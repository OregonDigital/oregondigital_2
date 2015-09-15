var ds = new Miso.Dataset({
  importer : Miso.Dataset.Importers.GoogleSpreadsheet,
  parser : Miso.Dataset.Parsers.GoogleSpreadsheet,
  key : "1LxyKjlWB6AYpIHGZaDeo9d3ffhBbpJ_QqPiQjOc1ZlE",
  worksheet : "1"
});

ds.fetch({ 
  success : function() {
    log(ds.columnNames());
  },
  error : function() {
    log("Are you sure you are connected to the internet?");
  }
});