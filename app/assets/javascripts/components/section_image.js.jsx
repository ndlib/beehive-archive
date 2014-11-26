var SectionImage = React.createClass({
  propTypes: {
    section: React.PropTypes.object.isRequired
  },

  render: function () {
    var caption = "";
    if (this.props.section.caption) {
      caption = (<div className="section-caption">{this.props.section.caption}</div>)
    }

    return (<div className="section-container">
      <img src={this.props.section.image } />
      { caption }
    </div>)
  }

});


var SectionDescription = React.createClass({
  propTypes: {
    section: React.PropTypes.object.isRequired
  },

  render: function () {
    var rawMarkup = false;
    if (this.props.section.description) {
      rawMarkup = this.props.section.description.toString();
    }

    if (rawMarkup) {
      return (<div className="section-container">
        <h2>{this.props.section.title}</h2>
        <div className="section-description" dangerouslySetInnerHTML={{__html: rawMarkup}}  />
      </div>)
    } else {
      return (<div />)
    }
  }

});

