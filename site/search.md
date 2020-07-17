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

<script src="https://cdn.jsdelivr.net/npm/minisearch@2.4.1/dist/umd/index.min.js"></script>
<script src="/systems.js"></script>
<script>
  let miniSearch = new MiniSearch({
    fields: ['title', 'text'], // fields to index for full-text search
    storeFields: ['title', 'category'] // fields to return with search results
  });

  // Index all documents
  miniSearch.addAll(SYSTEMS);

  let clearResults = function() {
    $('#search-results').empty();
  }

  let doSearch = function() {
    let query = $('#inventory-search').val();
    if (!query || query.length === 0) {
      return false;
    }

    let results = miniSearch.search(query);
    clearResults();
    renderResults(results);
    return false;
  }

  let renderResults = function(results) {
    console.log(results);
    results.forEach(function(result, idx, all_results) {
      renderResult(result, idx);
    });
  }

  let renderResult = function(result, idx) {
    $('#search-results').append('<div class="result"><a href="' + result.id + '">' + result.title + '</a></div>');
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
