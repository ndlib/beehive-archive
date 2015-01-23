/** @jsx React.DOM */

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
    var image, section, sections, style_path, honeypot_image;
    honeypot_image = item.links.image;
    style_path = honeypot_image.styles.medium.path;
    image = "http://localhost:3019/images/" + style_path;
    section = {
      id: 'new',
      title: item.title,
      image: image,
      item_id: item.id,
      display_type: 'image',
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
      <h2>Sections</h2>
      <div className="sections-content">
        <SectionList sections={this.state.sections} onSectionClick={this.sectionClick} currentDragItem={this.state.currentDragItem} onDrop={this.onDrop} />
      </div>
      <div className="add-items-content">
        <AddItemsBar onDragStart={this.onDragStart} onDragStop={this.onDragStop} itemsJSONPath={this.props.itemsJSONPath} />
      </div>
    </div>);
  }
});
