/** @jsx React.DOM */

var SectionForm = React.createClass({
  mixins: [ JsonLdMixin, SectionMixin, ErrorTrapping ],
  propTypes: {
    url: React.PropTypes.string.isRequired,
  },
  componentDidMount: function () {
    this.loadSection(this.props.url);
    this.display_error("hi hi ");
  },
  render: function() {
    console.log(this.state.errors)
    return (
    <div id="section-form">
      <BootstrapPageHeader title={this.state.section.title} subtitle="Edit" />
      <BootstrapErrorDisplay errors={this.state.errors} />
      <p>YO YO YO</p>
    </div>)
  }

});
