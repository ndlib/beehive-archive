var converter = new Showdown.converter()

var SectionList = React.createClass({
  sectionRows: function() {
    var i, rows, section, key;
    rows = [];
    i = 0;
    while (i < this.props.sections.length) {
      section = this.props.sections[i];
      rows.push(this.section_tag(section));
      rows.push(this.spacer_tag(section.id))
      i++;
    }
    if (rows.length === 0) {
      rows.push(this.spacer_tag(0));
    }
    return rows;
  },
  section_tag: function(section) {
    return (<Section section={section} key={section.id} onSectionClick={this.props.onSectionClick} />)
  },
  spacer_tag: function(order) {
    var  key = "spacer-" + order;
    return (<SectionSpacer key={key} currentDragItem={this.props.currentDragItem} onDrop={this.props.onDrop} new_index= {order + 1} />);
  },
  render: function() {
    return (<div className="sections-content-inner">{this.sectionRows()}</div>);
  }
});


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


var SectionSpacer = React.createClass({
  getInitialState: function() {
    return {
      hover: false
    };
  },
  classes: function() {
    return ['section_spacer', this.active() ? 'active' : void 0, this.state.hover ? 'hover' : void 0].join(' ');
  },
  onMouseEnter: function() {
    return this.setState({
      hover: true
    });
  },
  onMouseLeave: function() {
    return this.setState({
      hover: false
    });
  },
  active: function() {
    return this.props.currentDragItem;
  },
  onDrop: function() {
    if (this.active()) {
      return this.props.onDrop(this.props.currentDragItem, this.props.new_index);
    }
  },
  render: function() {
    return (
      <div className={this.classes()} onMouseEnter={this.onMouseEnter} onMouseLeave={this.onMouseLeave} onMouseUp={this.onDrop}>
        <div>Create New Section HERE!!</div>
     </div>);
  }
});



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

