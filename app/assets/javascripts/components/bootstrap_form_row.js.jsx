/** @jsx React.DOM */

var BootstrapFormRow = React.createClass({
  propTypes: {
    label: React.PropTypes.string.isRequired,
    required: React.PropTypes.bool.isRequired,
    id: React.PropTypes.string.isRequired,
  },
  required_class: function () {
    return this.props.required ? 'required' : 'optional'
  },
  div_class: function () {
    return "form-group " + this.required_class();
  },
  label_class: function () {
    return "string control-label "  + this.required_class();
  },
  render: function () {
    return (
      <div className={this.div_class()}>
        <label className={this.label_class()} for={this.props.id}>{this.props.label}</label>
        {this.props.children}
      </div>
    )
  }
})
