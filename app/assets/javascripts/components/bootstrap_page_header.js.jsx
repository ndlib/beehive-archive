/** @jsx React.DOM */

var BootstrapPageHeader = React.createClass({
  propTypes: {
    title: React.PropTypes.string.isRequired,
    subtitle: React.PropTypes.string,

  },
  render: function () {
    return (
      <div className="page-header">
        <h1>
          {this.props.title}
          <small>{this.props.subtitle}</small>
        </h1>
      </div>
    )
  }
});
