---
title: Inventory Search
layout: page
---

<form onsubmit="return false" class="usa-form">
 <label class="usa-label">Search</label>
 <input class="usa-input" name="q" id="inventory-search" autocomplete="off" >
 <button onclick="return doSearch()" class="usa-button">Search</button>
</form>

<script src="https://cdn.jsdelivr.net/npm/minisearch@2.4.1/dist/umd/index.min.js"></script>
<script src="/softwares.js"></script>
<script>
  let miniSearch = new MiniSearch({
    fields: ['title', 'text'], // fields to index for full-text search
    storeFields: ['title', 'category'] // fields to return with search results
  });

  // Index all documents
  miniSearch.addAll(SOFTWARES);

  let doSearch = function() {
    let query = $('#inventory-search').val();
    if (!query || query.length === 0) {
      return false;
    }

    let results = miniSearch.search(query);
    renderResults(results);
    return false;
  }

  let renderResults = function(results) {
    console.log(results);
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
