/** @jsx React.DOM */

var JsonLdMixin = {

  get: function(url, success) {
    $.get(url, success);
  },
  post: function(url, attributes) {

  },
  put: function(url, attributes) {

  },
  delete: function(url) {

  },
  log_error: function (xhr, status, err) {
    console.error(url, status, err.toString());
  }
}

