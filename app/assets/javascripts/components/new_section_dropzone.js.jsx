/** @jsx React.DOM */

var NewSectionDropzone = React.createClass({
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
