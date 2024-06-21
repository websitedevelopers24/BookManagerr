import { Controller } from "stimulus";

export default class extends Controller {
  static targets = [ "titleSearch", "authorSearch", "searchResults" ];

  connect() {
    this.performSearch();
  }

  performSearch() {
    let titleQuery = this.titleSearchTarget.value.trim();
    let authorQuery = this.authorSearchTarget.value.trim();

    fetch(`/books?q[title_cont]=${encodeURIComponent(titleQuery)}&q[author_cont]=${encodeURIComponent(authorQuery)}`, {
      headers: {
        "X-Requested-With": "XMLHttpRequest",
        "Accept": "text/javascript"
      }
    })
    .then(response => response.text())
    .then(data => {
      this.searchResultsTarget.innerHTML = data;
    })
    .catch(error => console.error("Error performing search:", error));
  }
}
