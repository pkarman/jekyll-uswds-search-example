---
title: Inventory Search
layout: page
---

<form onsubmit="return false" class="usa-search usa-search--big" role="search">
 <label class="usa-sr-only" for="inventory-search">Search</label>
 <input class="usa-input" name="q" id="inventory-search" type="search" autocomplete="off" >
 <button onclick="return doSearch()" class="usa-button" type="submit">
  <span class="usa-search__submit-text">Search</span>
 </button>
</form>

<div id="search-results" class="margin-top-2"></div>

<script src="https://unpkg.com/lunr/lunr.js"></script>
<script src="/systems.js"></script>
<script>
  let systemDocs = {}; // easy lookup

  let invIndex = lunr(function () {
    this.ref('id')
    this.field('content')
    this.field('title')
    this.field('agency')

    SYSTEMS.forEach(function (doc) {
      this.add(doc);
      systemDocs[doc.id] = doc;
    }, this)
  });

  let clearResults = function() {
    $('#search-results').empty();
  }

  let doSearch = function() {
    let query = $('#inventory-search').val();
    if (!query || query.length === 0) {
      return false;
    }

    let results = invIndex.search(query);
    clearResults();
    renderResults(results);
    return false;
  }

  let renderResults = function(results) {
    console.log(results);
    if (results.length === 0) {
      $('#search-results').append('<div>No results</div>');
      return;
    }
    results.forEach(function(result, idx, all_results) {
      renderResult(result, idx);
    });
  }

  let renderResult = function(result, idx) {
    let system = systemDocs[result.ref];
    $('#search-results').append('<div class="result"><a href="' + system.id + '">' + system.title + '</a></div>');
  }

  // listen for interaction on the search field
  $('#inventory-search').keypress(function(event){
    let keycode = (event.keyCode ? event.keyCode : event.which);
    if (keycode == '13') {
      event.preventDefault();
      doSearch();
    }
  });
</script>
