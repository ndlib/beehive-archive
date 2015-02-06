/** @jsx React.DOM */

var SectionForm = React.createClass({
  mixins: [ JsonLdMixin, SectionMixin, ErrorTrapping ],
  propTypes: {
    url: React.PropTypes.string.isRequired,
  },
  componentDidMount: function () {
    this.loadSection(this.props.url);
  },
  render: function() {
    var form = (
      <Schema>
        <Property name="section[title]" label="Title" />
      </Schema>
    )
    console.log(this.state.section.title)
    return (
    <div id="section-form">
      <BootstrapPageHeader title={this.state.section.title} subtitle="Edit" />
      <BootstrapErrorDisplay errors={this.state.errors} />
      <Form schema={form} />

    </div>)
  }

});
