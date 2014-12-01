var ShowcaseEditor = React.createClass({
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
        <AddItemsBar onDragStart={this.onDragStart} onDragStop={this.onDragStop} itemsJSONPath={this.props.itemsJSONPath} />
      </div>
    </div>);
  }
});
