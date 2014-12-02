var DRAG_THRESHOLD, Item, LEFT_BUTTON;

LEFT_BUTTON = 0;

DRAG_THRESHOLD = 3;

Item = React.createClass({
  getInitialState: function() {
    return {
      mouseDown: false,
      dragging: false
    };
  },
  style: function() {
    if (this.state.dragging) {
      return {
        position: 'absolute',
        left: this.state.left,
        top: this.state.top
      };
    } else {
      return {};
    }
  },
  onMouseDown: function(event) {
    var pageOffset;
    if (event.button === LEFT_BUTTON) {
      event.stopPropagation();
      event.preventDefault();
      this.addEvents();
      pageOffset = this.getDOMNode().getBoundingClientRect();
      return this.setState({
        mouseDown: true,
        originX: event.pageX,
        originY: event.pageY,
        elementX: pageOffset.left,
        elementY: pageOffset.top
      });
    }
  },
  onMouseMove: function(event) {
    var deltaX, deltaY, distance;
    deltaX = event.pageX - this.state.originX;
    deltaY = event.pageY - this.state.originY;
    distance = Math.abs(deltaX) + Math.abs(deltaY);
    if (!this.state.dragging && distance > DRAG_THRESHOLD) {
      this.setState({
        dragging: true
      });
      this.props.onDragStart(this.props.item);
    }
    if (this.state.dragging) {
      return this.setState({
        left: this.state.elementX + deltaX + document.body.scrollLeft,
        top: this.state.elementY + deltaY + document.body.scrollTop
      });
    }
  },
  onMouseUp: function() {
    this.removeEvents();
    if (this.state.dragging) {
      this.props.onDragStop();
      return this.setState({
        dragging: false
      });
    }
  },
  addEvents: function() {
    document.addEventListener('mousemove', this.onMouseMove);
    return document.addEventListener('mouseup', this.onMouseUp);
  },
  removeEvents: function() {
    document.removeEventListener('mousemove', this.onMouseMove);
    return document.removeEventListener('mouseup', this.onMouseUp);
  },
  render: function() {
    var dragclass, image, tiled_image;
    dragclass = "drag ";
    if (this.state.dragging) {
      dragclass = "" + dragclass + " dragging";
    }
    tiled_image = this.props.item.links.tiled_image;
    return (
      <div className={dragclass} onMouseDown={this.onMouseDown} style={this.style()}>
        <TiledImage tiled_image={tiled_image} />
      </div>);
  }
});