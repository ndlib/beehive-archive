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
      rows.push(this.dropzone_tag(section.order))
      i++;
    }
    if (rows.length === 0) {
      rows.push(this.dropzone_tag(0));
    }
    return rows;
  },
  section_tag: function(section) {
    var key = section.id + '-' + section.order
    return (<Section section={section} key={key} onSectionClick={this.props.onSectionClick} />)
  },
  dropzone_tag: function(order) {
    var  key = "spacer-" + order;
    return (<NewSectionDropzone key={key} currentDragItem={this.props.currentDragItem} onDrop={this.props.onDrop} new_index= {order + 1} />);
  },
  render: function() {
    return (<div className="sections-content-inner">{this.sectionRows()}</div>);
  }
});
