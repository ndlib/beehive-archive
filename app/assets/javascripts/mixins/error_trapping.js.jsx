/** @jsx React.DOM */

var ErrorTrapping = {
  getInitialState: function() {
    return {
      errors: [],
    };
  },
  display_error: function(msg) {
    var errors = this.state.errors;
    errors.push(msg);
    this.setState({
      errors: errors
    });
  }
}
