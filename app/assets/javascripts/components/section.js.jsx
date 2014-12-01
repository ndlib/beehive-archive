var Section = React.createClass({
  propTypes: {
    section: React.PropTypes.object.isRequired,
    onSectionClick: React.PropTypes.func.isRequired
  },

  handleClick: function(e) {
    e.preventDefault();
    this.props.onSectionClick(this.props.section);
  },

  render: function() {
    return (
      <div className="section">
        <SectionImage section={this.props.section} />
        <SectionDescription section={this.props.section} />
        <div className="edit" onClick={this.handleClick}>Edit</div>
      </div>
    );
  }
});
