/** @jsx React.DOM */

var BootstrapErrorDisplay;

BootstrapErrorDisplay = React.createClass({
  propTypes: {
    errors: React.PropTypes.array.isRequired,
  },
  display_messages: function () {
    if (this.props.errors.length > 0) {
      return (
        <div className="alert alert-danger" role="alert">
          {this.collect_messages()}
        </div>
        );
    } else {
      return "";
    }
  },
  collect_messages: function() {
    return _.each(this.props.errors, function (msg, index) {
      var key = "error-msg-"+index;
      return (<p key={key}>{msg}</p>)
    });
  },
  render: function () {
    return (
      <div id="page-notifications">
        {this.display_messages()}
      </div>
      )
  }
});
