//= require showdown
var converter = new Showdown.converter()

var Sections = React.createClass({
  propTypes: {
    sectionsJSONPath: React.PropTypes.string.isRequired,
    sectionsPath: React.PropTypes.string.isRequired,
    itemsJSONPath: React.PropTypes.string.isRequired
  },
  getInitialState: function() {
    return {
      currentDragItem: null,
      sections: []
    };
  },
  loadSectionsFromServer: function() {
    $.ajax({
      url: this.props.sectionsJSONPath,
      dataType: "json",
      success: (function(data) {
        this.setState({
          sections: data.sections
        });
      }).bind(this),
      error: (function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }).bind(this)
    });
  },
  handleItemDrop: function(item, index) {
    var filename, id, image, section, sections, split_path, tiled_image;
    tiled_image = item.links.tiled_image;
    split_path = tiled_image.path.split('/');
    filename = split_path.pop();
    id = split_path.pop();
    image = "http://localhost:3017/system/items/images/000/000/" + id + "/original/" + filename;
    section = {
      id: 'new',
      title: item.title,
      image: image,
      item_id: item.id,
      order: index
    };
    sections = this.state.sections;
    sections.splice(index, 0, section);
    return this.setState({
      sections: sections
    }, function() {
      $.ajax({
        url: this.props.sectionsJSONPath,
        dataType: "json",
        type: "POST",
        data: {
          section: section
        },
        success: (function(data) {
          this.loadSectionsFromServer();
        }).bind(this),
        error: (function(xhr, status, err) {
          console.error(this.props.url, status, err.toString());
        }).bind(this)
      });
    });
  },
  onDragStart: function(details) {
    return this.setState({
      currentDragItem: details
    });
  },
  onDragStop: function() {
    return this.setState({
      currentDragItem: null
    });
  },
  onDrop: function(target, index) {
    this.handleItemDrop(target, index);
    return this.setState({
      lastDrop: {
        source: this.state.currentDragItem,
        target: target
      }
    });
  },
  componentDidMount: function() {
    this.loadSectionsFromServer();
    setInterval(this.loadSectionsFromServer(), 8000);
  },
  sectionClick: function(section) {
    window.location = "" + this.props.sectionsPath + "/" + section.id + "/edit";
  },
  render: function() {
    var divclassname;
    divclassname = "sections";
    if (this.state.currentDragItem) {
      divclassname = "sections dragging";
    }
    return (
    <div className={this.divclassname}>
      <h1>Sections</h1>
      <div className="sections-content">
        <SectionList sections={this.state.sections} onSectionClick={this.sectionClick} currentDragItem={this.state.currentDragItem} onDrop={this.onDrop} />
      </div>
      <div className="add-items-content">
        <AddItemBox onDragStart={this.onDragStart} onDragStop={this.onDragStop} itemsJSONPath={this.props.itemsJSONPath} />
      </div>
    </div>);
  }
});



var SectionList = React.createClass({
  propTypes: {
    sections: React.PropTypes.array.isRequired,
    onSectionClick: React.PropTypes.func.isRequired,
    currentDragItem: React.PropTypes.object,
    onDrop: React.PropTypes.func.isRequired
  },
  sectionRows: function() {
    var i, rows, section, key;
    rows = [];
    i = 0;
    while (i < this.props.sections.length) {
      section = this.props.sections[i];
      rows.push(this.section_tag(section));
      rows.push(this.spacer_tag(section.order))
      i++;
    }
    if (rows.length === 0) {
      rows.push(this.spacer_tag(0));
    }
    return rows;
  },
  section_tag: function(section) {
    var key = section.id + '-' + section.order
    return (<Section section={section} key={key} onSectionClick={this.props.onSectionClick} />)
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

