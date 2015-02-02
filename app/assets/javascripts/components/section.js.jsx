/** @jsx React.DOM */

var DRAG_THRESHOLD, Item, LEFT_BUTTON;

LEFT_BUTTON = 0;

DRAG_THRESHOLD = 3;

var Section = React.createClass({
  propTypes: {
    section: React.PropTypes.object.isRequired,
    onSectionClick: React.PropTypes.func.isRequired
  },

  getInitialState: function() {
    return {
      mouseDown: false,
      dragging: false
    };
  },
  style: function() {
    if (this.state.dragging) {
      return {
        position: 'fixed',
        left: this.state.left,
        top: this.state.top,
        zIndex: '1000',
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
      if (!this.state.mouseDown) {
        return this.setState({
          mouseDown: true,
          viewportOriginX: event.pageX - document.body.scrollLeft,
          viewportOriginY: event.pageY - document.body.scrollTop,
          elementX: event.pageX - document.body.scrollLeft - 50,
          elementY: event.pageY - document.body.scrollTop - 75
        });
      }

    }
  },
  onMouseMove: function(event) {
    var deltaX, deltaY, distance;
    deltaX = (event.pageX - document.body.scrollLeft) - this.state.viewportOriginX;
    deltaY = (event.pageY - document.body.scrollTop) - this.state.viewportOriginY;
    distance = Math.abs(deltaX) + Math.abs(deltaY);
    if (!this.state.dragging && distance > DRAG_THRESHOLD) {
      this.setState({
        dragging: true
      });
      this.props.onDragStart(this.props.section, 'reorder');
    }
    if (this.state.dragging) {
      return this.setState({
        left: this.state.elementX + deltaX,
        top: this.state.elementY + deltaY
      });
    }
  },
  onMouseUp: function() {
    this.removeEvents();
    if (this.state.dragging) {
      this.props.onDragStop();
      return this.setState({
        dragging: false,
        mouseDown: false
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

  handleClick: function(e) {
    e.preventDefault();
    this.props.onSectionClick(this.props.section);
  },

  render: function() {
    dragclass = " drag ";
    if (this.state.dragging) {
      dragclass = "" + dragclass + " dragging";
    } else {
      dragclass = "" + dragclass + " hidden";
    }

    return (
      <div className="section" onMouseDown={this.onMouseDown} >
        <div className={dragclass} style={this.style()}> DRAG ME !!</div>
        <SectionImage section={this.props.section} />
        <SectionDescription section={this.props.section} />
        <div className="section-edit" onClick={this.handleClick}>Edit</div>
      </div>
    );
  }
});
