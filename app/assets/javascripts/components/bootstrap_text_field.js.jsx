/** @jsx React.DOM */

var BootstrapTextField = React.createClass({
  propTypes: {
    label: React.PropTypes.string,
    required: React.PropTypes.bool,
    id: React.PropTypes.string,
    name: React.PropTypes.string,
    value: React.PropTypes.string
  },
  render: function () {
    return (
      <BootstrapFormRow label={this.props.label} id={this.props.id} required={this.props.required}>
        <input type="text" id={this.props.id} className="string form-control" name={this.props.name} value={this.props.value} />
      </BootstrapFormRow>
    );
  }
})
