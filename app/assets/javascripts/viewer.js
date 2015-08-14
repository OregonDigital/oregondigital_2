$(document).ready(
  function(){

    /*
    * try getting an identifier from the url?
    */
    function getFileID(url){
      var query = url.indexOf('?');
      end = query > 0 ? query : url.length;
      return url.substring(url.lastIndexOf(':') +1, end);
    }

    /*
    * try getting the term from the url?
    */
    function getTerm(url){
      var query = url.indexOf('?');
      if (query)
        return url.substring(query + 1, url.length);
      else return -1;
    }

    var options = {
      container:null
    };

    //get elt to hold the viewer and do setup
    options.container = document.getElementById('viewerContainer');
    var p_view = new PDFJS.PDFViewer(options);

    console.log(getFileID(document.URL));
    console.log(getTerm(document.URL));
    
    //var fname = getFileID(document.URL); // ore build path however.
    var path = '/assets/ode.pdf'; //until then...
    var term = getTerm(document.URL);
    
      PDFJS.getDocument(path).then(function (pdfDoc_) {
        pdfDoc = pdfDoc_;
        p_view.setDocument(pdfDoc);
      });
    
    //set up find
    p_findController = new PDFFindController({
      pdfViewer: p_view,
    });

    p_findBar = new PDFFindBar({ // lifted from original viewer.js
      bar: document.getElementById('findbar'),
      toggleButton: document.getElementById('viewFind'),
      findField: document.getElementById('findInput'),
      highlightAllCheckbox: document.getElementById('findHighlightAll'),
      caseSensitiveCheckbox: document.getElementById('findMatchCase'),
      findMsg: document.getElementById('findMsg'),
      findStatusIcon: document.getElementById('findStatusIcon'),
      findPreviousButton: document.getElementById('findPrevious'),
      findNextButton: document.getElementById('findNext'),
      findController: p_findController
    });

    p_view.setFindController(p_findController);
    p_findController.setFindBar(p_findBar);
    
    
    if (term){//as suggested by commenter on issue #1875
    // $('#findbar').show(); //right now it's not hidden
      $('#findInput').val(term);
      $('#findHighlightAll').trigger('click');
      $('#findNext').trigger('click');
    }
    
  
    
   // p_view._setScale(.5); //for now. 
    console.log("reached end of viewer.js");
});